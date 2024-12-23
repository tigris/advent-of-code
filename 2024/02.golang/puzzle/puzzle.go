package puzzle

import (
	"slices"
	"strconv"

	log "github.com/sirupsen/logrus"
)

type Report struct {
	Levels []int
}

func PartOne(input Input) string {
	log.Debug("Running part 1")

	valid := 0

	for _, report := range input.Reports {
		log.Debug("Report: ", report)
		if reportValid(report) {
			valid++
		}
	}

	return strconv.Itoa(valid)
}

func PartTwo(input Input) string {
	log.Debug("Running part 2")

	valid := 0

	for _, report := range input.Reports {
		log.Debug("Report: ", report)
		if reportValidWithOneMissing(report) {
			valid++
		}
	}

	return strconv.Itoa(valid)
}

func reportValid(report Report) bool {
	levels := report.Levels

	if levels[0] > levels[len(levels)-1] {
		slices.Reverse(levels)
	}

	for i, level := range report.Levels[1:] {
		diff := level - report.Levels[i]
		if diff < 1 || diff > 3 {
			log.Debug("Invalid: (", diff, ") ", report)

			return false
		}
	}
	log.Debug("Valid: ", report)

	return true
}

func reportValidWithOneMissing(report Report) bool {
	if reportValid(report) {
		return true
	}

	for i := range report.Levels {
		modifiedLevels := slices.Concat(report.Levels[0:i], report.Levels[i+1:])
		modifiedReport := Report{Levels: modifiedLevels}
		log.Debug("Modified report: ", modifiedReport)

		if reportValid(modifiedReport) {
			return true
		}
	}

	return false
}
