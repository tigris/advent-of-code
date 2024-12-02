package main

//nolint:depguard
import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRunPart1(t *testing.T) {
	t.Parallel()
	input, _ := os.ReadFile("test_input.txt")

	assert.Equal(t, "11", runPart1(input))
}

func TestRunPart2(t *testing.T) {
	t.Parallel()
	input, _ := os.ReadFile("test_input.txt")

	assert.Equal(t, "31", runPart2(input))
}
