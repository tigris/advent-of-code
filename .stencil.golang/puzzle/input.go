package puzzle

import (
	"fmt"
	"os"
	"strings"

	log "github.com/sirupsen/logrus"
)

type Input struct {
	Lines []string
}

func ParseInput(file string) (Input, error) {
	input := Input{Lines: []string{}}

	log.Debug("Slurping file: ", file)
	raw, err := os.ReadFile(file)
	if err != nil {
		return input, fmt.Errorf("couldn't read file: %w", err)
	}

	lines := strings.Split(string(raw), "\n")

	for _, line := range lines {
		if line == "" {
			continue
		}

		log.Debug("Parsing line: ", line)

		input.Lines = append(input.Lines, line)
	}

	return input, nil
}
