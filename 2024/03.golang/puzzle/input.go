package puzzle

import (
	"bufio"
	"fmt"
	"os"
	"regexp"

	util "aoc/util"

	log "github.com/sirupsen/logrus"
)

type Input struct {
	Muls []Mul
}

type Mul struct {
	First  int
	Second int
}

func ParseInput(filename string) (Input, error) {
	input := Input{Muls: []Mul{}}

	log.Debug("Slurping file: ", filename)
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)

		return input, fmt.Errorf("couldn't read file: %w", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	re := regexp.MustCompile(`mul\((\d+),(\d+)\)|(do)\(\)|(don't)\(\)`)
	enabled := true

	for scanner.Scan() {
		line := scanner.Text()
		log.Debug("Parsing line: ", line)

		matches := re.FindAllStringSubmatch(line, -1)
		for _, match := range matches {
			log.Debug("Match: ", match)

			if enabled && match[1] != "" {
				mul := Mul{First: util.Atoi(match[1]), Second: util.Atoi(match[2])}
				input.Muls = append(input.Muls, mul)
			} else {
				log.Debug("Ignored!")
				enabled = match[3] == "do"
			}
		}
	}

	return input, nil
}
