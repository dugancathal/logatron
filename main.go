package main

import (
	"bytes"
	"fmt"
	"net/http"
	"time"
)

func main() {
	time.Sleep(3 * time.Second)
	for i := 0; i < 100; i++ {
		fmt.Println("About to log")
		log(fmt.Sprintf("Yolo, loggin' from go for the %d time", i))
		time.Sleep(1 * time.Second)
	}
}

func log(message string) {
	buf := bytes.NewBuffer([]byte(fmt.Sprintf(`{"body": "%s", "timestamp": "%s"}`, message, time.Now())))
	http.Post("http://localhost:3000/projects/golang/logs", "application/json", buf)
}
