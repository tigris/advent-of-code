package util

import (
	"fmt"
	"regexp"
	"strconv"

	log "github.com/sirupsen/logrus"
)

func SliceAtoi(sa []string) ([]int, error) {
	si := make([]int, 0, len(sa))
	for _, a := range sa {
		i, err := strconv.Atoi(a)
		if err != nil {
			log.Fatal(err)

			return si, fmt.Errorf("couldn't convert string to int: %w", err)
		}

		si = append(si, i)
	}

	return si, nil
}

func LineToInts(line string) []int {
	re := regexp.MustCompile(`\d+`)
	si, _ := SliceAtoi(re.FindAllString(line, -1))

	return si
}
