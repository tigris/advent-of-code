package puzzle

import (
	"strconv"

	log "github.com/sirupsen/logrus"
)

func PartOne(input Input) string {
	log.Debug("Running part 1")

	answer := 0
	for _, mul := range input.Muls {
		answer += mul.First * mul.Second
	}

	return strconv.Itoa(answer)
}

func PartTwo(input Input) string {
	log.Debug("Running part 2")

	answer := 0
	for _, mul := range input.Muls {
		answer += mul.First * mul.Second
	}

	return strconv.Itoa(answer)
}
