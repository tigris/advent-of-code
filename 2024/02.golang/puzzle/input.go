package puzzle

import (
	"bufio"
	"fmt"
	"os"

	util "aoc/util"

	log "github.com/sirupsen/logrus"
)

type Input struct {
	Reports []Report
}

func ParseInput(filename string) (Input, error) {
	input := Input{Reports: []Report{}}

	log.Debug("Slurping file: ", filename)
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)

		return input, fmt.Errorf("couldn't read file: %w", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		log.Debug("Parsing line: ", line)

		levels := util.LineToInts(line)
		input.Reports = append(input.Reports, Report{Levels: levels})
	}

	return input, nil
}
