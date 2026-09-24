package car_test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/Vlad-maker/my-cars-lib/backend/internal/car"
	"github.com/Vlad-maker/my-cars-lib/backend/internal/storage"
)

func newRepo(t *testing.T) *car.SQLiteRepository {
	t.Helper()

	db, err := storage.Open(t.Context(), ":memory:")
	require.NoError(t, err)
	t.Cleanup(func() { _ = db.Close() })
	require.NoError(t, storage.Migrate(db))

	return car.NewSQLiteRepository(db)
}

func TestSQLiteRepository_List(t *testing.T) {
	repo := newRepo(t)

	cars, err := repo.List(t.Context())
	require.NoError(t, err)
	require.Len(t, cars, 10)

	first := cars[0]
	assert.Equal(t, "toyota-camry", first.Slug)
	assert.Equal(t, "Toyota", first.Brand)
	assert.Equal(t, 181, first.PowerHP)
	require.NotNil(t, first.CoverImageURL)
	assert.Contains(t, *first.CoverImageURL, "upload.wikimedia.org")

	for _, c := range cars {
		assert.NotEmpty(t, c.Slug)
		assert.NotNil(t, c.CoverImageURL, "car %s has no cover", c.Slug)
	}
}

func TestSQLiteRepository_GetBySlug(t *testing.T) {
	repo := newRepo(t)

	d, err := repo.GetBySlug(t.Context(), "lada-vesta")
	require.NoError(t, err)

	assert.Equal(t, "Vesta", d.Model)
	assert.Nil(t, d.YearTo, "Vesta is still produced")
	assert.Equal(t, "Lada", d.Brand.Name)
	assert.Equal(t, "Россия", d.Brand.Country)
	assert.NotEmpty(t, d.Brand.History)
	assert.Equal(t, 106, d.Specs.PowerHP)
	require.NotNil(t, d.Specs.AccelerationS)
	assert.InDelta(t, 11.8, *d.Specs.AccelerationS, 0.001)
	assert.Len(t, d.Images, 3)
	assert.Contains(t, d.Links.AutoRu, "auto.ru")
	assert.Contains(t, d.Links.Avito, "avito.ru")
}

func TestSQLiteRepository_GetBySlug_NotFound(t *testing.T) {
	repo := newRepo(t)

	_, err := repo.GetBySlug(t.Context(), "does-not-exist")
	require.ErrorIs(t, err, car.ErrNotFound)
}
