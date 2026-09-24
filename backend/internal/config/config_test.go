package config

import (
	"log/slog"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestLoad_Defaults(t *testing.T) {
	t.Setenv("HTTP_ADDR", "")
	t.Setenv("DB_PATH", "")
	t.Setenv("CORS_ORIGINS", "")
	t.Setenv("LOG_LEVEL", "")

	cfg, err := Load()
	require.NoError(t, err)

	assert.Equal(t, ":8080", cfg.HTTPAddr)
	assert.Equal(t, "data/cars.db", cfg.DBPath)
	assert.Equal(t, []string{"http://localhost:5173"}, cfg.CORSOrigins)
	assert.Equal(t, slog.LevelInfo, cfg.LogLevel)
}

func TestLoad_FromEnv(t *testing.T) {
	t.Setenv("HTTP_ADDR", ":9090")
	t.Setenv("DB_PATH", "/tmp/x.db")
	t.Setenv("CORS_ORIGINS", "http://a.test, http://b.test ,")
	t.Setenv("LOG_LEVEL", "debug")

	cfg, err := Load()
	require.NoError(t, err)

	assert.Equal(t, ":9090", cfg.HTTPAddr)
	assert.Equal(t, "/tmp/x.db", cfg.DBPath)
	assert.Equal(t, []string{"http://a.test", "http://b.test"}, cfg.CORSOrigins)
	assert.Equal(t, slog.LevelDebug, cfg.LogLevel)
}

func TestLoad_InvalidLogLevel(t *testing.T) {
	t.Setenv("LOG_LEVEL", "loud")

	_, err := Load()
	require.Error(t, err)
}
