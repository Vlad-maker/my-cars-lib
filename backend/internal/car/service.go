package car

import (
	"context"
	"fmt"
	"regexp"
	"strings"
)

const maxQueryLen = 100

var slugPattern = regexp.MustCompile(`^[a-z0-9]+(?:-[a-z0-9]+)*$`)

// Service implements catalog use cases.
type Service struct {
	repo Repository
}

// NewService creates a catalog service.
func NewService(repo Repository) *Service {
	return &Service{repo: repo}
}

// List returns all cars, optionally filtered by a free-text query.
//
// Filtering happens here rather than in SQL because SQLite's LOWER()
// only folds ASCII, while the catalog contains Cyrillic aliases.
func (s *Service) List(ctx context.Context, query string) ([]Summary, error) {
	cars, err := s.repo.List(ctx)
	if err != nil {
		return nil, fmt.Errorf("list cars: %w", err)
	}

	terms := queryTerms(query)
	out := make([]Summary, 0, len(cars))
	for _, c := range cars {
		if matches(c, terms) {
			out = append(out, c)
		}
	}
	return out, nil
}

// Get returns the full card of a car. It returns ErrNotFound for
// unknown or malformed slugs.
func (s *Service) Get(ctx context.Context, slug string) (Detail, error) {
	if !slugPattern.MatchString(slug) {
		return Detail{}, ErrNotFound
	}

	d, err := s.repo.GetBySlug(ctx, slug)
	if err != nil {
		return Detail{}, fmt.Errorf("get car %s: %w", slug, err)
	}
	return d, nil
}

// queryTerms normalizes a search query into lower-case words.
func queryTerms(query string) []string {
	query = strings.ToLower(strings.TrimSpace(query))
	if r := []rune(query); len(r) > maxQueryLen {
		query = string(r[:maxQueryLen])
	}
	return strings.Fields(query)
}

// matches reports whether every term occurs in the car's searchable text.
func matches(c Summary, terms []string) bool {
	if len(terms) == 0 {
		return true
	}
	haystack := strings.ToLower(strings.Join([]string{c.Brand, c.Model, c.Generation, c.Aliases}, " "))
	for _, t := range terms {
		if !strings.Contains(haystack, t) {
			return false
		}
	}
	return true
}
