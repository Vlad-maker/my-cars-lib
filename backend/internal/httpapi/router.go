// Package httpapi exposes the catalog over HTTP (Gin).
package httpapi

import (
	"context"
	"log/slog"
	"net/http"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"

	"github.com/Vlad-maker/my-cars-lib/backend/internal/car"
)

// CarService is what the handlers need from the catalog.
// Declared here because the handlers are its consumer.
type CarService interface {
	List(ctx context.Context, query string) ([]car.Summary, error)
	Get(ctx context.Context, slug string) (car.Detail, error)
}

// Pinger checks that a dependency (the database) is reachable.
type Pinger interface {
	PingContext(ctx context.Context) error
}

// RouterConfig holds transport-level settings.
type RouterConfig struct {
	CORSOrigins []string
}

// NewRouter builds the Gin engine with all routes.
func NewRouter(cfg RouterConfig, cars CarService, db Pinger, log *slog.Logger) *gin.Engine {
	gin.SetMode(gin.ReleaseMode)

	r := gin.New()
	r.Use(gin.Recovery(), requestLogger(log))

	if len(cfg.CORSOrigins) > 0 {
		r.Use(cors.New(cors.Config{
			AllowOrigins: cfg.CORSOrigins,
			AllowMethods: []string{http.MethodGet, http.MethodOptions},
			AllowHeaders: []string{"Content-Type"},
			MaxAge:       12 * time.Hour,
		}))
	}

	h := &carHandler{cars: cars, log: log}

	r.GET("/health/live", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})
	r.GET("/health/ready", func(c *gin.Context) {
		if err := db.PingContext(c.Request.Context()); err != nil {
			log.ErrorContext(c.Request.Context(), "readiness check failed", slog.Any("error", err))
			c.JSON(http.StatusServiceUnavailable, gin.H{"status": "unavailable"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	api := r.Group("/api/v1")
	api.GET("/cars", h.list)
	api.GET("/cars/:slug", h.get)

	r.NoRoute(func(c *gin.Context) {
		writeError(c, http.StatusNotFound, codeNotFound, "route not found")
	})

	return r
}

func requestLogger(log *slog.Logger) gin.HandlerFunc {
	return func(c *gin.Context) {
		start := time.Now()
		c.Next()
		log.InfoContext(c.Request.Context(), "http request",
			slog.String("method", c.Request.Method),
			slog.String("path", c.Request.URL.Path),
			slog.Int("status", c.Writer.Status()),
			slog.Duration("duration", time.Since(start)),
		)
	}
}
