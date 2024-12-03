package util

import (
	"strconv"

	log "github.com/sirupsen/logrus"
)

func Atoi(s string) int {
	i, err := strconv.Atoi(s)
	if err != nil {
		log.Fatal(err)
	}

	return i
}
