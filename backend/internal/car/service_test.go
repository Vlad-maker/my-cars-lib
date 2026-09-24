package car

import (
	"context"
	"errors"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

type fakeRepo struct {
	cars    []Summary
	details map[string]Detail
	err     error
}

func (f *fakeRepo) List(context.Context) ([]Summary, error) {
	return f.cars, f.err
}

func (f *fakeRepo) GetBySlug(_ context.Context, slug string) (Detail, error) {
	if f.err != nil {
		return Detail{}, f.err
	}
	d, ok := f.details[slug]
	if !ok {
		return Detail{}, ErrNotFound
	}
	return d, nil
}

func newFake() *fakeRepo {
	return &fakeRepo{
		cars: []Summary{
			{Slug: "toyota-camry", Brand: "Toyota", Model: "Camry", Generation: "XV70", Aliases: "тойота камри"},
			{Slug: "lada-vesta", Brand: "Lada", Model: "Vesta", Generation: "I (NG)", Aliases: "лада веста"},
			{Slug: "skoda-octavia", Brand: "Škoda", Model: "Octavia", Generation: "IV (A8)", Aliases: "шкода октавия"},
		},
		details: map[string]Detail{"toyota-camry": {Slug: "toyota-camry"}},
	}
}

func TestService_List(t *testing.T) {
	tests := []struct {
		name  string
		query string
		want  []string
	}{
		{name: "empty query returns all", query: "", want: []string{"toyota-camry", "lada-vesta", "skoda-octavia"}},
		{name: "whitespace query returns all", query: "   ", want: []string{"toyota-camry", "lada-vesta", "skoda-octavia"}},
		{name: "case-insensitive latin", query: "CAMRY", want: []string{"toyota-camry"}},
		{name: "cyrillic alias", query: "Камри", want: []string{"toyota-camry"}},
		{name: "generation", query: "xv70", want: []string{"toyota-camry"}},
		{name: "unicode brand", query: "škoda", want: []string{"skoda-octavia"}},
		{name: "all terms must match", query: "лада веста", want: []string{"lada-vesta"}},
		{name: "terms from different cars", query: "лада камри", want: []string{}},
		{name: "no match", query: "ferrari", want: []string{}},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			svc := NewService(newFake())

			got, err := svc.List(t.Context(), tt.query)
			require.NoError(t, err)

			slugs := make([]string, 0, len(got))
			for _, c := range got {
				slugs = append(slugs, c.Slug)
			}
			assert.Equal(t, tt.want, slugs)
		})
	}
}

func TestService_List_RepoError(t *testing.T) {
	boom := errors.New("boom")
	svc := NewService(&fakeRepo{err: boom})

	_, err := svc.List(t.Context(), "")
	require.ErrorIs(t, err, boom)
}

func TestService_Get(t *testing.T) {
	svc := NewService(newFake())

	d, err := svc.Get(t.Context(), "toyota-camry")
	require.NoError(t, err)
	assert.Equal(t, "toyota-camry", d.Slug)

	_, err = svc.Get(t.Context(), "unknown-car")
	require.ErrorIs(t, err, ErrNotFound)
}

func TestService_Get_InvalidSlug(t *testing.T) {
	svc := NewService(&fakeRepo{err: errors.New("repo must not be called")})

	for _, slug := range []string{"", "Toyota", "a b", "../etc", "-x", "x-", "x--y"} {
		_, err := svc.Get(t.Context(), slug)
		require.ErrorIs(t, err, ErrNotFound, "slug %q", slug)
	}
}
