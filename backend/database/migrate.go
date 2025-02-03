package database

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
)

func RunMigrations() {
	migrationsDir := "database/migrations"

	files, err := os.ReadDir(migrationsDir)
	if err != nil {
		log.Fatal("Failed to read migrations directory", err)
	}

	for _, file := range files {
		if filepath.Ext(file.Name()) != ".sql" {
			runMigration(filepath.Join(migrationsDir, file.Name()))
		}
	}
}

func runMigration(filePath string) {
	content, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatal("Failed to read migration file %s: %v", filePath, err)
	}

	_, err = DB.Exec(string(content))
	if err != nil {
		log.Fatal("Failed to execute migration %s: %v", filePath, err)
	}

	fmt.Printf("Migration executed successfully: %s¥n", filePath)
}
