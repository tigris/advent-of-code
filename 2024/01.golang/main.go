package main

//nolint:depguard
import (
	"os"
	"slices"
	"strconv"
	"strings"

	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

func main() {
	var Part int
	var Verbose bool
	var InputFile string

	//nolint:exhaustruct
	rootCmd := &cobra.Command{
		Use: "aoc",
		Run: func(_ *cobra.Command, _ []string) {
			if Verbose {
				log.SetLevel(log.DebugLevel)
			}

			log.Debug("Reading input from ", InputFile)
			input, _ := os.ReadFile(InputFile)

			//nolint:gomnd,mnd
			switch Part {
			case 1:
				log.Info("Answer for part 1: ", runPart1(input))
			case 2:
				log.Info("Answer for part 2: ", runPart2(input))
			}
		},
	}

	rootCmd.Flags().StringVarP(&InputFile, "file", "f", "input.txt", "File to use for input")
	_ = rootCmd.MarkFlagRequired("file")

	rootCmd.Flags().IntVarP(&Part, "part", "p", 1, "Part to run")
	_ = rootCmd.MarkFlagRequired("part")

	rootCmd.Flags().BoolVarP(&Verbose, "verbose", "v", false, "Be more spammy")

	_ = rootCmd.Execute()
}

func runPart1(input []byte) string {
	log.Debug("Running part 1")

	left, right := parseInput(input)
	diff := 0

	for i := range left {
		currDiff := right[i] - left[i]
		log.Debug("comparing ", left[i], " and ", right[i], " got ", max(currDiff, -currDiff))
		diff += max(currDiff, -currDiff)
	}

	return strconv.Itoa(diff)
}

func runPart2(input []byte) string {
	log.Debug("Running part 2")

	left, right := parseInput(input)
	score := 0

	for _, l := range left {
		matches := 0
		for _, r := range right {
			if l == r {
				matches++
			}
		}

		log.Debug("checking right side for ", l, " and found ", matches)
		score += l * matches
	}

	return strconv.Itoa(score)
}

func parseInput(input []byte) ([]int, []int) {
	lines := strings.Split(string(input), "\n")

	left := []int{}
	right := []int{}

	for _, line := range lines {
		if line == "" {
			continue
		}

		log.Debug("Parsing line: ", line)
		numbers := strings.Fields(line)
		leftNum, _ := strconv.Atoi(numbers[0])
		rightNum, _ := strconv.Atoi(numbers[1])
		left = append(left, leftNum)
		right = append(right, rightNum)
	}

	slices.Sort(left)
	slices.Sort(right)

	return left, right
}
