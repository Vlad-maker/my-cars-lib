// Package migrations embeds SQL migration files into the binary.
//
// To add a car, create a new pair of files with the next number, e.g.
// 000003_add_toyota_rav4.up.sql / .down.sql. Never edit applied migrations.
package migrations

import "embed"

// FS contains all *.sql migration files.
//
//go:embed *.sql
var FS embed.FS
