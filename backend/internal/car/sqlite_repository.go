package car

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
)

// SQLiteRepository reads the catalog from SQLite.
type SQLiteRepository struct {
	db *sql.DB
}

// NewSQLiteRepository creates a repository over an opened database.
func NewSQLiteRepository(db *sql.DB) *SQLiteRepository {
	return &SQLiteRepository{db: db}
}

const listQuery = `
SELECT c.slug, b.name, c.model, c.generation, c.year_from, c.year_to,
       c.body_type, s.power_hp, c.aliases,
       (SELECT i.url FROM car_images i WHERE i.car_id = c.id ORDER BY i.position LIMIT 1)
FROM cars c
JOIN brands b    ON b.id = c.brand_id
JOIN car_specs s ON s.car_id = c.id
ORDER BY c.sort_order, c.id`

// List returns all cars ordered by sort_order.
func (r *SQLiteRepository) List(ctx context.Context) ([]Summary, error) {
	rows, err := r.db.QueryContext(ctx, listQuery)
	if err != nil {
		return nil, fmt.Errorf("query cars: %w", err)
	}
	defer func() { _ = rows.Close() }()

	var out []Summary
	for rows.Next() {
		var (
			s      Summary
			yearTo sql.NullInt64
			cover  sql.NullString
		)
		if err := rows.Scan(&s.Slug, &s.Brand, &s.Model, &s.Generation, &s.YearFrom, &yearTo,
			&s.BodyType, &s.PowerHP, &s.Aliases, &cover); err != nil {
			return nil, fmt.Errorf("scan car: %w", err)
		}
		s.YearTo = nullInt(yearTo)
		s.CoverImageURL = nullString(cover)
		out = append(out, s)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("iterate cars: %w", err)
	}
	return out, nil
}

const detailQuery = `
SELECT c.id, c.slug, c.model, c.generation, c.year_from, c.year_to, c.body_type,
       c.car_class, c.description, c.auto_ru_url, c.avito_url,
       b.slug, b.name, b.country, b.founded_year, b.history,
       s.version_note, s.engine_type, s.engine_volume_cc, s.power_hp, s.torque_nm,
       s.transmission, s.drive, s.acceleration_s, s.top_speed_kmh, s.fuel_consumption_l,
       s.fuel_tank_l, s.length_mm, s.width_mm, s.height_mm, s.wheelbase_mm,
       s.curb_weight_kg, s.trunk_l, s.seats
FROM cars c
JOIN brands b    ON b.id = c.brand_id
JOIN car_specs s ON s.car_id = c.id
WHERE c.slug = ?`

const imagesQuery = `
SELECT url, source_url, author, license
FROM car_images
WHERE car_id = ?
ORDER BY position`

// GetBySlug returns the full car card or ErrNotFound.
func (r *SQLiteRepository) GetBySlug(ctx context.Context, slug string) (Detail, error) {
	var (
		id                             int64
		d                              Detail
		yearTo, volume, topSpeed, tank sql.NullInt64
		weight, trunk                  sql.NullInt64
		accel, fuel                    sql.NullFloat64
	)

	err := r.db.QueryRowContext(ctx, detailQuery, slug).Scan(
		&id, &d.Slug, &d.Model, &d.Generation, &d.YearFrom, &yearTo, &d.BodyType,
		&d.CarClass, &d.Description, &d.Links.AutoRu, &d.Links.Avito,
		&d.Brand.Slug, &d.Brand.Name, &d.Brand.Country, &d.Brand.FoundedYear, &d.Brand.History,
		&d.Specs.VersionNote, &d.Specs.EngineType, &volume, &d.Specs.PowerHP, &d.Specs.TorqueNM,
		&d.Specs.Transmission, &d.Specs.Drive, &accel, &topSpeed, &fuel,
		&tank, &d.Specs.LengthMM, &d.Specs.WidthMM, &d.Specs.HeightMM, &d.Specs.WheelbaseMM,
		&weight, &trunk, &d.Specs.Seats,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return Detail{}, ErrNotFound
	}
	if err != nil {
		return Detail{}, fmt.Errorf("query car %s: %w", slug, err)
	}

	d.YearTo = nullInt(yearTo)
	d.Specs.EngineVolumeCC = nullInt(volume)
	d.Specs.TopSpeedKMH = nullInt(topSpeed)
	d.Specs.FuelTankL = nullInt(tank)
	d.Specs.CurbWeightKG = nullInt(weight)
	d.Specs.TrunkL = nullInt(trunk)
	d.Specs.AccelerationS = nullFloat(accel)
	d.Specs.FuelConsumptionL = nullFloat(fuel)

	images, err := r.images(ctx, id)
	if err != nil {
		return Detail{}, fmt.Errorf("query images of car %s: %w", slug, err)
	}
	d.Images = images

	return d, nil
}

func (r *SQLiteRepository) images(ctx context.Context, carID int64) ([]Image, error) {
	rows, err := r.db.QueryContext(ctx, imagesQuery, carID)
	if err != nil {
		return nil, fmt.Errorf("query: %w", err)
	}
	defer func() { _ = rows.Close() }()

	out := []Image{}
	for rows.Next() {
		var img Image
		if err := rows.Scan(&img.URL, &img.SourceURL, &img.Author, &img.License); err != nil {
			return nil, fmt.Errorf("scan: %w", err)
		}
		out = append(out, img)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("iterate: %w", err)
	}
	return out, nil
}

func nullInt(v sql.NullInt64) *int {
	if !v.Valid {
		return nil
	}
	i := int(v.Int64)
	return &i
}

func nullFloat(v sql.NullFloat64) *float64 {
	if !v.Valid {
		return nil
	}
	return &v.Float64
}

func nullString(v sql.NullString) *string {
	if !v.Valid {
		return nil
	}
	return &v.String
}
