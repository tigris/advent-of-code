package puzzle

//nolint:depguard
import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRunPart1(t *testing.T) {
	t.Parallel()
	input, err := ParseInput("test_input.txt")
	if err != nil {
		t.Fatal(err)
	}

	assert.Equal(t, "2", PartOne(input))
}

func TestRunPart2(t *testing.T) {
	t.Parallel()
	input, err := ParseInput("test_input.txt")
	if err != nil {
		t.Fatal(err)
	}

	assert.Equal(t, "4", PartTwo(input))
}
