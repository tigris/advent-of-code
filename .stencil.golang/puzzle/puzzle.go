package puzzle

import (
	"strconv"

	log "github.com/sirupsen/logrus"
)

func PartOne(input Input) string {
	log.Debug("Running part 1")

	answer := len(input.Lines)

	return strconv.Itoa(answer)
}

func PartTwo(input Input) string {
	log.Debug("Running part 2")

	answer := len(input.Lines)

	return strconv.Itoa(answer)
}
