package puzzle

import (
	"bufio"
	"fmt"
	"os"
	"regexp"

	log "github.com/sirupsen/logrus"
)

type Input struct {
	Lines []string
}

func ParseInput(filename string) (Input, error) {
	input := Input{Lines: []string{}}

	log.Debug("Slurping file: ", filename)
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)

		return input, fmt.Errorf("couldn't read file: %w", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	re := regexp.MustCompile("^.*$")

	for scanner.Scan() {
		line := scanner.Text()
		log.Debug("Parsing line: ", line)
		input.Lines = append(input.Lines, re.FindAllString(line, -1)[0])
	}

	return input, nil
}
