package httpapi

import (
	"errors"
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"

	"github.com/Vlad-maker/my-cars-lib/backend/internal/car"
)

const (
	codeNotFound = "NOT_FOUND"
	codeInternal = "INTERNAL"
)

type carHandler struct {
	cars CarService
	log  *slog.Logger
}

type listMeta struct {
	Total int `json:"total"`
}

type listResponse struct {
	Data []car.Summary `json:"data"`
	Meta listMeta      `json:"meta"`
}

type detailResponse struct {
	Data car.Detail `json:"data"`
}

type errorBody struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

type errorResponse struct {
	Error errorBody `json:"error"`
}

// list handles GET /api/v1/cars?q=...
func (h *carHandler) list(c *gin.Context) {
	cars, err := h.cars.List(c.Request.Context(), c.Query("q"))
	if err != nil {
		h.internalError(c, err)
		return
	}
	c.JSON(http.StatusOK, listResponse{Data: cars, Meta: listMeta{Total: len(cars)}})
}

// get handles GET /api/v1/cars/:slug
func (h *carHandler) get(c *gin.Context) {
	d, err := h.cars.Get(c.Request.Context(), c.Param("slug"))
	switch {
	case errors.Is(err, car.ErrNotFound):
		writeError(c, http.StatusNotFound, codeNotFound, "car not found")
	case err != nil:
		h.internalError(c, err)
	default:
		c.JSON(http.StatusOK, detailResponse{Data: d})
	}
}

func (h *carHandler) internalError(c *gin.Context, err error) {
	h.log.ErrorContext(c.Request.Context(), "request failed",
		slog.String("path", c.Request.URL.Path),
		slog.Any("error", err),
	)
	writeError(c, http.StatusInternalServerError, codeInternal, "internal server error")
}

func writeError(c *gin.Context, status int, code, message string) {
	c.AbortWithStatusJSON(status, errorResponse{Error: errorBody{Code: code, Message: message}})
}
