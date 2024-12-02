package cmd

import (
	puzzle "aoc/puzzle"

	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

func RootCmd() *cobra.Command {
	var Part int
	var Verbose bool
	var InputFile string

	//nolint:exhaustruct
	var rootCmd = &cobra.Command{
		Use: "aoc",
		Run: func(_ *cobra.Command, _ []string) {
			if Verbose {
				log.SetLevel(log.DebugLevel)
			}

			input, _ := puzzle.ParseInput(InputFile)

			//nolint:gomnd,mnd
			switch Part {
			case 1:
				log.Info("Answer for part 1: ", puzzle.PartOne(input))
			case 2:
				log.Info("Answer for part 2: ", puzzle.PartTwo(input))
			}
		},
	}

	rootCmd.Flags().StringVarP(&InputFile, "file", "f", "input.txt", "File to use for input")
	_ = rootCmd.MarkFlagRequired("file")

	rootCmd.Flags().IntVarP(&Part, "part", "p", 1, "Part to run")
	_ = rootCmd.MarkFlagRequired("part")

	rootCmd.Flags().BoolVarP(&Verbose, "verbose", "v", false, "Be more spammy")

	return rootCmd
}
