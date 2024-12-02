package main

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRunPart1(t *testing.T) {
	input, _ := os.ReadFile("test_input.txt")

	assert.Equal(t, runPart1(input), "11")
}

func TestRunPart2(t *testing.T) {
	input, _ := os.ReadFile("test_input.txt")

	assert.Equal(t, runPart2(input), "31")
}
