package httpapi

import (
	"context"
	"encoding/json"
	"errors"
	"io"
	"log/slog"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/Vlad-maker/my-cars-lib/backend/internal/car"
)

type fakeService struct {
	gotQuery string
	listErr  error
	getErr   error
}

func (f *fakeService) List(_ context.Context, q string) ([]car.Summary, error) {
	f.gotQuery = q
	if f.listErr != nil {
		return nil, f.listErr
	}
	return []car.Summary{{Slug: "toyota-camry", Brand: "Toyota", Model: "Camry"}}, nil
}

func (f *fakeService) Get(_ context.Context, slug string) (car.Detail, error) {
	if f.getErr != nil {
		return car.Detail{}, f.getErr
	}
	return car.Detail{Slug: slug, Model: "Camry", Images: []car.Image{}}, nil
}

type fakePinger struct{ err error }

func (f fakePinger) PingContext(context.Context) error { return f.err }

func newTestRouter(svc CarService, db Pinger) http.Handler {
	log := slog.New(slog.NewTextHandler(io.Discard, nil))
	return NewRouter(RouterConfig{CORSOrigins: []string{"http://localhost:5173"}}, svc, db, log)
}

func do(t *testing.T, h http.Handler, method, target string, headers map[string]string) *httptest.ResponseRecorder {
	t.Helper()
	req := httptest.NewRequestWithContext(t.Context(), method, target, nil)
	for k, v := range headers {
		req.Header.Set(k, v)
	}
	rec := httptest.NewRecorder()
	h.ServeHTTP(rec, req)
	return rec
}

func TestListCars(t *testing.T) {
	svc := &fakeService{}
	rec := do(t, newTestRouter(svc, fakePinger{}), http.MethodGet, "/api/v1/cars?q=camry", nil)

	require.Equal(t, http.StatusOK, rec.Code)
	assert.Equal(t, "camry", svc.gotQuery)

	var body listResponse
	require.NoError(t, json.Unmarshal(rec.Body.Bytes(), &body))
	assert.Equal(t, 1, body.Meta.Total)
	assert.Equal(t, "toyota-camry", body.Data[0].Slug)
}

func TestGetCar(t *testing.T) {
	tests := []struct {
		name     string
		getErr   error
		wantCode int
		wantErr  string
	}{
		{name: "found", wantCode: http.StatusOK},
		{name: "not found", getErr: car.ErrNotFound, wantCode: http.StatusNotFound, wantErr: codeNotFound},
		{name: "wrapped not found", getErr: errors.Join(errors.New("ctx"), car.ErrNotFound), wantCode: http.StatusNotFound, wantErr: codeNotFound},
		{name: "internal", getErr: errors.New("db is down"), wantCode: http.StatusInternalServerError, wantErr: codeInternal},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			rec := do(t, newTestRouter(&fakeService{getErr: tt.getErr}, fakePinger{}), http.MethodGet, "/api/v1/cars/toyota-camry", nil)
			require.Equal(t, tt.wantCode, rec.Code)

			if tt.wantErr == "" {
				var body detailResponse
				require.NoError(t, json.Unmarshal(rec.Body.Bytes(), &body))
				assert.Equal(t, "toyota-camry", body.Data.Slug)
				return
			}

			var body errorResponse
			require.NoError(t, json.Unmarshal(rec.Body.Bytes(), &body))
			assert.Equal(t, tt.wantErr, body.Error.Code)
			assert.NotContains(t, rec.Body.String(), "db is down", "internal details must not leak")
		})
	}
}

func TestHealth(t *testing.T) {
	ok := newTestRouter(&fakeService{}, fakePinger{})
	assert.Equal(t, http.StatusOK, do(t, ok, http.MethodGet, "/health/live", nil).Code)
	assert.Equal(t, http.StatusOK, do(t, ok, http.MethodGet, "/health/ready", nil).Code)

	down := newTestRouter(&fakeService{}, fakePinger{err: errors.New("down")})
	assert.Equal(t, http.StatusServiceUnavailable, do(t, down, http.MethodGet, "/health/ready", nil).Code)
}

func TestUnknownRoute(t *testing.T) {
	rec := do(t, newTestRouter(&fakeService{}, fakePinger{}), http.MethodGet, "/nope", nil)
	assert.Equal(t, http.StatusNotFound, rec.Code)
	assert.Contains(t, rec.Body.String(), codeNotFound)
}

func TestCORS(t *testing.T) {
	h := newTestRouter(&fakeService{}, fakePinger{})

	rec := do(t, h, http.MethodGet, "/api/v1/cars", map[string]string{"Origin": "http://localhost:5173"})
	assert.Equal(t, "http://localhost:5173", rec.Header().Get("Access-Control-Allow-Origin"))

	rec = do(t, h, http.MethodGet, "/api/v1/cars", map[string]string{"Origin": "http://evil.test"})
	assert.Empty(t, rec.Header().Get("Access-Control-Allow-Origin"))
}
