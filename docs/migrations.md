# MockX マイグレーション手順

このドキュメントでは、MockX のデータベースマイグレーションの手順について説明します。

---

## **1. マイグレーションファイルの作成**
マイグレーション用の SQL ファイルを `database/migrations/` ディレクトリに作成します。

```sh
mkdir -p backend/database/migrations
```

### **`001_create_mocks.sql`**
```sql
CREATE TABLE IF NOT EXISTS mocks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    method TEXT NOT NULL,
    path TEXT NOT NULL,
    response_status INTEGER NOT NULL,
    response_headers JSONB,
    response_body JSONB,
    delay INTEGER DEFAULT 0,
    rate_limit INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);
```

### **`002_create_logs.sql`**
```sql
CREATE TABLE IF NOT EXISTS logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mock_id UUID REFERENCES mocks(id) ON DELETE CASCADE,
    request_method TEXT NOT NULL,
    request_path TEXT NOT NULL,
    request_headers JSONB,
    request_body JSONB,
    response_status INTEGER,
    response_headers JSONB,
    response_body JSONB,
    created_at TIMESTAMP DEFAULT now()
);
```

---

## **2. データベースの接続設定**
環境変数 `DATABASE_URL` を設定して、Heroku Postgres に接続します。

```sh
export DATABASE_URL="your_postgres_connection_url"
```

データベースの接続は `database/db.go` で設定します。

```go
package database

import (
    "database/sql"
    "fmt"
    "log"
    "os"

    _ "github.com/lib/pq"
)

var DB *sql.DB

func InitDB() {
    dbURL := os.Getenv("DATABASE_URL")
    if dbURL == "" {
        log.Fatal("DATABASE_URL is not set")
    }

    var err error
    DB, err = sql.Open("postgres", dbURL)
    if err != nil {
        log.Fatal("Failed to connect to database:", err)
    }

    if err := DB.Ping(); err != nil {
        log.Fatal("Database ping failed:", err)
    }

    fmt.Println("Connected to the database successfully")
}
```

---

## **3. マイグレーションの実行**
マイグレーションを実行するには、以下のスクリプトを使用します。

### **`database/migrate.go`**
```go
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
        log.Fatal("Failed to read migrations directory:", err)
    }

    for _, file := range files {
        if filepath.Ext(file.Name()) == ".sql" {
            runMigration(filepath.Join(migrationsDir, file.Name()))
        }
    }
}

func runMigration(filePath string) {
    content, err := os.ReadFile(filePath)
    if err != nil {
        log.Fatalf("Failed to read migration file %s: %v", filePath, err)
    }

    _, err = DB.Exec(string(content))
    if err != nil {
        log.Fatalf("Failed to execute migration %s: %v", filePath, err)
    }

    fmt.Printf("Successfully applied migration: %s\n", filePath)
}
```

### **実行方法**
```sh
go run backend/cmd/main.go
```

これにより、`database/migrate.go` が実行され、`database/migrations/` 内の SQL ファイルが適用されます。

---

この手順に従ってマイグレーションを実施してください。

