// Package car contains the car catalog: models, business rules and
// data access. It knows nothing about HTTP.
package car

import (
	"context"
	"errors"
)

// ErrNotFound is returned when a car with the requested slug does not exist.
var ErrNotFound = errors.New("car not found")

// Summary is a short car representation for the catalog list.
type Summary struct {
	Slug          string  `json:"slug"`
	Brand         string  `json:"brand"`
	Model         string  `json:"model"`
	Generation    string  `json:"generation"`
	YearFrom      int     `json:"year_from"`
	YearTo        *int    `json:"year_to"`
	BodyType      string  `json:"body_type"`
	PowerHP       int     `json:"power_hp"`
	Aliases       string  `json:"aliases"`
	CoverImageURL *string `json:"cover_image_url"`
}

// Detail is the full car card.
type Detail struct {
	Slug        string  `json:"slug"`
	Model       string  `json:"model"`
	Generation  string  `json:"generation"`
	YearFrom    int     `json:"year_from"`
	YearTo      *int    `json:"year_to"`
	BodyType    string  `json:"body_type"`
	CarClass    string  `json:"car_class"`
	Description string  `json:"description"`
	Brand       Brand   `json:"brand"`
	Specs       Specs   `json:"specs"`
	Images      []Image `json:"images"`
	Links       Links   `json:"links"`
}

// Brand describes a car manufacturer.
type Brand struct {
	Slug        string `json:"slug"`
	Name        string `json:"name"`
	Country     string `json:"country"`
	FoundedYear int    `json:"founded_year"`
	History     string `json:"history"`
}

// Specs are technical characteristics of a specific car version.
// Pointer fields are nullable: nil means "unknown".
type Specs struct {
	VersionNote      string   `json:"version_note"`
	EngineType       string   `json:"engine_type"`
	EngineVolumeCC   *int     `json:"engine_volume_cc"`
	PowerHP          int      `json:"power_hp"`
	TorqueNM         int      `json:"torque_nm"`
	Transmission     string   `json:"transmission"`
	Drive            string   `json:"drive"`
	AccelerationS    *float64 `json:"acceleration_s"`
	TopSpeedKMH      *int     `json:"top_speed_kmh"`
	FuelConsumptionL *float64 `json:"fuel_consumption_l"`
	FuelTankL        *int     `json:"fuel_tank_l"`
	LengthMM         int      `json:"length_mm"`
	WidthMM          int      `json:"width_mm"`
	HeightMM         int      `json:"height_mm"`
	WheelbaseMM      int      `json:"wheelbase_mm"`
	CurbWeightKG     *int     `json:"curb_weight_kg"`
	TrunkL           *int     `json:"trunk_l"`
	Seats            int      `json:"seats"`
}

// Image is a car photo with attribution.
type Image struct {
	URL       string `json:"url"`
	SourceURL string `json:"source_url"`
	Author    string `json:"author"`
	License   string `json:"license"`
}

// Links point to marketplaces where the car can be bought.
type Links struct {
	AutoRu string `json:"auto_ru"`
	Avito  string `json:"avito"`
}

// Repository provides read access to the catalog storage.
// Declared here because Service is its consumer.
type Repository interface {
	List(ctx context.Context) ([]Summary, error)
	GetBySlug(ctx context.Context, slug string) (Detail, error)
}
