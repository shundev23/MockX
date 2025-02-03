package main

import (
	"fmt"

	"github.com/shundev23/MockX/database"
)

func main() {
	fmt.Println("Starting MockX server...")

	// DB初期化
	database.InitDB()

	// マイグレーション実行
	database.RunMigrations()

	fmt.Println("MockX server is up and running!")
}
