package main

import "aoc/cmd"

func main() {
	rootCmd := cmd.RootCmd()
	_ = rootCmd.Execute()
}
