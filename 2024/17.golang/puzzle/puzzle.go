package puzzle

import (
	"fmt"
	"strconv"
	"strings"

	log "github.com/sirupsen/logrus"
)

func PartOne(input Input) string {
	log.Debug("Running part 1")

	register_a, err := strconv.Atoi(strings.Split(input.Lines[0], " ")[2])
	if err != nil {
		log.Fatal(err)
	}

	program := []int{}
	for _, v := range strings.Split(input.Lines[4], ",") {
		i, err := strconv.Atoi(v)
		if err != nil {
			i, _ = strconv.Atoi(strings.Split(v, " ")[1])
		}
		program = append(program, i)
	}

	calculator := NewCalculator(
		register_a,
		0,
		0,
		program,
		[]int{},
	)

	return calculator.Run()
}

func PartTwo(input Input) string {
	log.Debug("Running part 2")

	program := []int{}
	for _, v := range strings.Split(input.Lines[4], ",") {
		i, err := strconv.Atoi(v)
		if err != nil {
			i, _ = strconv.Atoi(strings.Split(v, " ")[1])
		}
		program = append(program, i)
	}

	for attempt := 0; attempt < 1_000_000_000_000_000; attempt++ {
		log.Debug("attempt: ", attempt)
		calculator := NewCalculator(
			attempt,
			0,
			0,
			program,
			program,
		)
		answer := calculator.Run()

		// join array of integers into string
		if answer == SliceToString(program, ",") {
			return strconv.Itoa(attempt)
		}
	}

	return "0"
}

func SliceToString(a []int, sep string) string {
	if len(a) == 0 {
		return ""
	}

	b := make([]string, len(a))
	for i, v := range a {
		b[i] = strconv.Itoa(v)
	}
	return strings.Join(b, sep)
}

type Calculator struct {
	RegisterA int
	RegisterB int
	RegisterC int
	Program   []int
	Pointer   int
	Output    []int
	MustMatch []int
}

func NewCalculator(registerA, registerB, registerC int, program, mustMatch []int) *Calculator {
	return &Calculator{
		RegisterA: registerA,
		RegisterB: registerB,
		RegisterC: registerC,
		Program:   program,
		Pointer:   0,
		Output:    []int{},
		MustMatch: mustMatch,
	}
}

func (c *Calculator) Run() string {
	for c.Pointer < len(c.Program) {
		opcode := c.Program[c.Pointer]
		operand := c.Program[c.Pointer+1]

		log.Debugf("opcode: %d, operand: %d", opcode, operand)

		var advance int
		switch opcode {
		case 0:
			c.Adv(operand)
			advance = 2
		case 1:
			c.Bxl(operand)
			advance = 2
		case 2:
			c.Bst(operand)
			advance = 2
		case 3:
			if c.Jnz(operand) {
				advance = 0
			} else {
				advance = 2
			}
		case 4:
			c.Bxc(operand)
			advance = 2
		case 5:
			c.Out(operand)
			advance = 2
		case 6:
			c.Bdv(operand)
			advance = 2
		case 7:
			c.Cdv(operand)
			advance = 2
		default:
			return c.Halt()
		}

		if c.haltConditionsMet() {
			return c.Halt()
		}

		c.Pointer += advance
	}
	return c.Halt()
}

func (c *Calculator) comboOperand(operand int) int {
	switch operand {
	case 4:
		return c.RegisterA
	case 5:
		return c.RegisterB
	case 6:
		return c.RegisterC
	default:
		return operand
	}
}

func (c *Calculator) Adv(operand int) {
	c.RegisterA /= (1 << c.comboOperand(operand))
}

func (c *Calculator) Bxl(operand int) {
	c.RegisterB ^= operand
}

func (c *Calculator) Bst(operand int) {
	c.RegisterB = c.comboOperand(operand) % 8
}

func (c *Calculator) Jnz(operand int) bool {
	if c.RegisterA == 0 {
		return false
	}
	c.Pointer = operand
	return true
}

func (c *Calculator) Bxc(_ int) {
	c.RegisterB ^= c.RegisterC
}

func (c *Calculator) Out(operand int) {
	c.Output = append(c.Output, c.comboOperand(operand)%8)
}

func (c *Calculator) Bdv(operand int) {
	c.RegisterB = c.RegisterA / (1 << c.comboOperand(operand))
}

func (c *Calculator) Cdv(operand int) {
	c.RegisterC = c.RegisterA / (1 << c.comboOperand(operand))
}

func (c *Calculator) Halt() string {
	var sb strings.Builder
	for i, v := range c.Output {
		if i > 0 {
			sb.WriteString(",")
		}
		sb.WriteString(fmt.Sprintf("%d", v))
	}
	return sb.String()
}

func (c *Calculator) haltConditionsMet() bool {
	if len(c.MustMatch) == 0 || len(c.Output) == 0 {
		return false
	}

	if len(c.Output) > len(c.MustMatch) {
		return true
	}

	for i, v := range c.MustMatch {
		if i < len(c.Output) && v != c.Output[i] {
			return true
		}
	}

	return false
}
