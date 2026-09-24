package storage

import (
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestMigrate_SeedsTenCars(t *testing.T) {
	db, err := Open(t.Context(), ":memory:")
	require.NoError(t, err)
	t.Cleanup(func() { _ = db.Close() })

	require.NoError(t, Migrate(db))

	var cars, brands, images int
	require.NoError(t, db.QueryRow(`SELECT COUNT(*) FROM cars`).Scan(&cars))
	require.NoError(t, db.QueryRow(`SELECT COUNT(DISTINCT brand_id) FROM cars`).Scan(&brands))
	require.NoError(t, db.QueryRow(`SELECT COUNT(*) FROM car_images`).Scan(&images))

	assert.Equal(t, 10, cars)
	assert.Equal(t, 10, brands, "every car must be of a different brand")
	assert.GreaterOrEqual(t, images, 10)
}

func TestMigrate_IsIdempotent(t *testing.T) {
	path := filepath.Join(t.TempDir(), "sub", "cars.db")

	for range 2 {
		db, err := Open(t.Context(), path)
		require.NoError(t, err)
		require.NoError(t, Migrate(db))
		require.NoError(t, db.Close())
	}
}

func TestOpen_ForeignKeysEnabled(t *testing.T) {
	db, err := Open(t.Context(), ":memory:")
	require.NoError(t, err)
	t.Cleanup(func() { _ = db.Close() })

	var on int
	require.NoError(t, db.QueryRow(`PRAGMA foreign_keys`).Scan(&on))
	assert.Equal(t, 1, on)
}
