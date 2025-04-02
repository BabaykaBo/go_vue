package main

import (
	"fmt"
	"go-vue/internal/driver"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
)

type config struct {
	port int
}

type application struct {
	config   config
	infoLog  *log.Logger
	errorLog *log.Logger
	db       *driver.DB
}

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	var cfg config
	cfg.port = 8089

	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errorLog := log.New(os.Stdout, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	dsn := os.Getenv("DATABASE_DSN")
	db, err := driver.ConnectDB(dsn)
	if err != nil {
		log.Fatal(err)
	}
	defer db.SQL.Close()

	app := application{
		config:   cfg,
		infoLog:  infoLog,
		errorLog: errorLog,
		db:       db,
	}

	err = app.serve()
	if err != nil {
		log.Fatal(err)
	}
}

func (app *application) serve() error {
	app.infoLog.Println("API listening on port", app.config.port)
	return http.ListenAndServe(fmt.Sprintf(":%d", app.config.port), app.routes())
}
