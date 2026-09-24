// Package config loads service configuration from environment variables.
package config

import (
	"fmt"
	"log/slog"
	"os"
	"strings"
)

// Config holds all runtime settings of the service.
type Config struct {
	HTTPAddr    string
	DBPath      string
	CORSOrigins []string
	LogLevel    slog.Level
}

// Load reads configuration from the environment, applying defaults
// suitable for local development.
func Load() (Config, error) {
	cfg := Config{
		HTTPAddr:    getEnv("HTTP_ADDR", ":8080"),
		DBPath:      getEnv("DB_PATH", "data/cars.db"),
		CORSOrigins: splitList(getEnv("CORS_ORIGINS", "http://localhost:5173")),
	}

	if err := cfg.LogLevel.UnmarshalText([]byte(getEnv("LOG_LEVEL", "info"))); err != nil {
		return Config{}, fmt.Errorf("parse LOG_LEVEL: %w", err)
	}

	return cfg, nil
}

func getEnv(key, fallback string) string {
	if v, ok := os.LookupEnv(key); ok && strings.TrimSpace(v) != "" {
		return strings.TrimSpace(v)
	}
	return fallback
}

func splitList(s string) []string {
	var out []string
	for part := range strings.SplitSeq(s, ",") {
		if p := strings.TrimSpace(part); p != "" {
			out = append(out, p)
		}
	}
	return out
}
