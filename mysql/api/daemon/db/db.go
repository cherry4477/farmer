package db

import (
	"os"
	"fmt"
	"database/sql"

	_ "github.com/go-sql-driver/mysql"
)

var (
	DB *sql.DB
	DB_ERROR error
)

func Connect() {
	cs := fmt.Sprintf("%s:%s@%s(%s)/",
		"root",
		os.Getenv("MYSQL_ROOT_PASSWORD"),
		"tcp",
		"mysql:3306",
	)

	DB, DB_ERROR = sql.Open("mysql", cs)
}

func Close() error {
	return DB.Close()
}

func CreateDatabase(dbName string) error {
	if _, err := DB.Exec("CREATE DATABASE IF NOT EXISTS `" + dbName + "` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci"); err != nil {
		return err
	}

	return nil
}

func CreateUser(dbName string, username string, password string) error {
	if _, err := DB.Exec("GRANT ALL ON `" + dbName + "`.* TO '" + username  + "'@'%' IDENTIFIED BY '" + password + "'"); err != nil {
		return err
	}

	return nil
}
