# SECTION 2 — BOOLEAN LOGIC AND RTL OPERATORS

Status: COMPLETE
Topics Completed: 16/16

---

# TABLE OF CONTENTS

1. NOT Gate
2. Buffer
3. AND Gate
4. OR Gate
5. NAND Gate
6. NOR Gate
7. XOR Gate
8. XNOR Gate
9. Multi-Input Gates
10. Bus / Vector Basics
11. Reduction Operators
12. Bitwise Operators
13. Logical Operators
14. Shift Operators
15. Concatenation
16. Replication
17. Conditional Operator
18. Verilog/SystemVerilog Code vs RTL
19. Continuous Assignment
20. Testbench Fundamentals
21. Simulation and Icarus Verilog
22. X / Unknown Values
23. Test Vector Strategy
24. Width Rules
25. Signed vs Unsigned
26. Packed vs Unpacked Arrays
27. Common Syntax Rules
28. Common Mistakes / Weaknesses Identified
29. Master Operator Cheat Sheet
30. Final Section Checklist


============================================================
1. NOT GATE
============================================================

A NOT gate inverts its input.

Truth table:

A | Y
--|--
0 | 1
1 | 0

Boolean expression:

Y = ~A

SystemVerilog:

module not_gate(
    input logic a,
    output logic y
);

assign y = ~a;

endmodule

The operator:

~ 

is the BITWISE NOT operator.

For a 1-bit signal:

~0 = 1
~1 = 0

For a vector:

a = 4'b1010

~a = 4'b0101

The operation happens independently on every bit.

Important:

~ is bitwise NOT.
! is logical NOT.

These are NOT the same.


============================================================
2. BUFFER
============================================================

A buffer passes its input directly to its output.

Truth table:

A | Y
--|--
0 | 0
1 | 1

Boolean expression:

Y = A

SystemVerilog:

module buffer(
    input logic a,
    output logic y
);

assign y = a;

endmodule

A buffer does not invert or modify the logical value.

It simply passes the signal through.


============================================================
3. AND GATE
============================================================

AND produces 1 only when ALL inputs are 1.

Boolean expression:

Y = A · B

SystemVerilog:

assign y = a & b;

Truth table:

A | B | Y
--|---|--
0 | 0 | 0
0 | 1 | 0
1 | 0 | 0
1 | 1 | 1

Mental rule:

AND = everything must be 1.


============================================================
4. OR GATE
============================================================

OR produces 1 when AT LEAST ONE input is 1.

Boolean expression:

Y = A + B

SystemVerilog:

assign y = a | b;

Truth table:

A | B | Y
--|---|--
0 | 0 | 0
0 | 1 | 1
1 | 0 | 1
1 | 1 | 1

Mental rule:

OR = at least one input is 1.

For single-bit signals:

| is the OR operation.

For vectors, | is BITWISE OR.


============================================================
5. NAND GATE
============================================================

NAND = NOT + AND.

Boolean expression:

Y = ~(A · B)

SystemVerilog:

assign y = ~(a & b);

Truth table:

A | B | Y
--|---|--
0 | 0 | 1
0 | 1 | 1
1 | 0 | 1
1 | 1 | 0

Mental rule:

NAND is 0 ONLY when every input is 1.


============================================================
6. NOR GATE
============================================================

NOR = NOT + OR.

Boolean expression:

Y = ~(A + B)

SystemVerilog:

assign y = ~(a | b);

Truth table:

A | B | Y
--|---|--
0 | 0 | 1
0 | 1 | 0
1 | 0 | 0
1 | 1 | 0

Mental rule:

NOR is 1 ONLY when every input is 0.


============================================================
7. XOR GATE
============================================================

XOR = Exclusive OR.

XOR produces 1 when the inputs are DIFFERENT.

Boolean expression:

Y = A XOR B

SystemVerilog:

assign y = a ^ b;

Truth table:

A | B | Y
--|---|--
0 | 0 | 0
0 | 1 | 1
1 | 0 | 1
1 | 1 | 0

Mental rule:

XOR = different.

Examples:

0 ^ 0 = 0
0 ^ 1 = 1
1 ^ 0 = 1
1 ^ 1 = 0


============================================================
8. XNOR GATE
============================================================

XNOR = NOT XOR.

XNOR produces 1 when the inputs are the SAME.

SystemVerilog:

assign y = ~(a ^ b);

Alternative operators:

assign y = a ~^ b;

assign y = a ^~ b;

Truth table:

A | B | Y
--|---|--
0 | 0 | 1
0 | 1 | 0
1 | 0 | 0
1 | 1 | 1

Mental rule:

XNOR = same / equal.


============================================================
9. MULTI-INPUT GATES
============================================================

Boolean operators can operate on more than two inputs.

Example:

assign y_and  = a & b & c;
assign y_or   = a | b | c;
assign y_nand = ~(a & b & c);
assign y_nor  = ~(a | b | c);
assign y_xor  = a ^ b ^ c;
assign y_xnor = ~(a ^ b ^ c);

For:

a = 1
b = 1
c = 1

AND:

1 & 1 & 1 = 1

OR:

1 | 1 | 1 = 1

NAND:

~(1 & 1 & 1) = 0

NOR:

~(1 | 1 | 1) = 0


MULTI-INPUT XOR

Multi-input XOR represents parity.

For three inputs:

a ^ b ^ c

Result:

1 = odd number of 1s
0 = even number of 1s

Truth table:

a b c | XOR
------|----
0 0 0 | 0
0 0 1 | 1
0 1 0 | 1
0 1 1 | 0
1 0 0 | 1
1 0 1 | 0
1 1 0 | 0
1 1 1 | 1

Therefore:

XOR = odd parity
XNOR = even parity


============================================================
10. BUS / VECTOR BASICS
============================================================

A bus is a collection of multiple bits treated as one signal/vector.

Example:

logic [3:0] a;

This is a 4-bit vector.

The bits are:

a[3] a[2] a[1] a[0]

Example:

a = 4'b1011

Then:

a[3] = 1
a[2] = 0
a[1] = 1
a[0] = 1

A 4-bit bus can contain ANY of the following 16 combinations:

0000
0001
0010
0011
0100
0101
0110
0111
1000
1001
1010
1011
1100
1101
1110
1111

Number of possible combinations:

2^4 = 16

General rule:

N bits = 2^N possible combinations.

A bus does NOT mean that it can only contain one specific value such as 1011.

1011 was simply one example/test vector.


============================================================
11. REDUCTION OPERATORS
============================================================

Reduction operators take an entire vector and reduce it to ONE bit.

Reduction operators:

&
|
^
~&
~|
~^
^~

Example:

logic [3:0] a;

Reduction AND:

assign y_and = &a;

Reduction OR:

assign y_or = |a;

Reduction XOR:

assign y_xor = ^a;


REDUCTION AND

&a

All bits must be 1.

Examples:

&1111 = 1
&1110 = 0
&1011 = 0
&0000 = 0


REDUCTION OR

|a

At least one bit must be 1.

Examples:

|0000 = 0
|0001 = 1
|1000 = 1
|1111 = 1


REDUCTION XOR

^a

Calculates parity.

Examples:

^0000 = 0
^0001 = 1
^0011 = 0
^0111 = 1
^1111 = 0


REDUCTION NAND

~&a

Equivalent to:

~(&a)


REDUCTION NOR

~|a

Equivalent to:

~(|a)


REDUCTION XNOR

~^a

or:

^~a


CRITICAL DISTINCTION:

Bitwise:

a & b

produces a result with the vector width.

Reduction:

&a

produces ONE BIT.


Example:

a = 4'b1011

~a = 4'b0100

but:

&a = 1'b0

Therefore:

BITWISE = operates on each bit and preserves width.

REDUCTION = collapses all bits into one result.


============================================================
12. BITWISE OPERATORS
============================================================

Bitwise operators operate independently on corresponding bits.

Operators:

&
|
^
~
~^
^~

Example:

a = 4'b1010
b = 4'b1100


BITWISE AND

a & b

  1010
& 1100
------
  1000


BITWISE OR

a | b

  1010
| 1100
------
  1110


BITWISE XOR

a ^ b

  1010
^ 1100
------
  0110


BITWISE XNOR

~(a ^ b)

a ^ b = 0110

~0110 = 1001


BITWISE NOT

~a

a  = 1010
~a = 0101


For N-bit vectors:

N-bit bitwise operation → N-bit result.


============================================================
13. LOGICAL OPERATORS
============================================================

Logical operators:

&&
||
!

Logical operators operate on the logical TRUE/FALSE interpretation of operands.

The result is normally ONE BIT.


LOGICAL AND

&&

Examples:

0 && 0 = 0
0 && 1 = 0
1 && 0 = 0
1 && 1 = 1

For vectors:

0000 = FALSE

Any non-zero value = TRUE.

Example:

a = 4'b1010
b = 4'b0101

Both are non-zero.

Therefore:

a && b = 1


LOGICAL OR

||

Examples:

0 || 0 = 0
0 || 1 = 1
1 || 0 = 1
1 || 1 = 1

For vectors:

0000 = FALSE
anything non-zero = TRUE.

Example:

0000 || 1010 = 1


LOGICAL NOT

!

Examples:

!0 = 1
!1 = 0

For vectors:

!0000 = 1
!1010 = 0


CRITICAL DIFFERENCE:

BITWISE AND:

a & b

LOGICAL AND:

a && b

Example:

a = 1010
b = 0101

a & b = 0000

but:

a && b = 1

Why?

Because bitwise AND compares each bit:

1010
0101
----
0000

Logical AND asks:

Is a non-zero?
YES

Is b non-zero?
YES

Therefore:

1 && 1 = 1


BITWISE NOT:

~1010 = 0101

LOGICAL NOT:

!1010 = 0


There is NO separate standard logical XOR/XNOR operator like &&, || and !.

XOR is:

^

XNOR is:

~^


============================================================
14. SHIFT OPERATORS
============================================================

Shift operators:

<<
>>
<<<
>>>

They move bits left or right.


LOGICAL LEFT SHIFT

<<

Example:

a = 4'b1011

a << 1

Result:

0110

Bits move left.

Zeros enter from the right.

1011 << 1 = 0110


LOGICAL RIGHT SHIFT

>>

Example:

1011 >> 1 = 0101

Bits move right.

For an unsigned value, zeros enter from the left.


ARITHMETIC LEFT SHIFT

<<<

Example:

1011 <<< 1 = 0110

For normal fixed-width values, arithmetic left shift behaves essentially like logical left shift.

The important distinction is on arithmetic RIGHT shifting.


ARITHMETIC RIGHT SHIFT

>>>

Arithmetic right shift preserves the sign bit for signed operands.

Example:

logic signed [3:0] a;

a = 4'b1010

MSB = 1

This represents a negative two's-complement value.

Logical right shift:

1010 >> 1 = 0101

Arithmetic right shift:

1010 >>> 1 = 1101

The leftmost bit is filled with the sign bit.

Therefore:

>>  = logical right shift

>>> = arithmetic right shift


SIGNEDNESS

Unsigned:

logic [3:0] a;

Signed:

logic signed [3:0] a;


For signed:

1010 >>> 1 = 1101

because the sign bit is 1.

More examples:

1100 >> 1  = 0110
1100 >>> 1 = 1110

1000 >> 1  = 0100
1000 >>> 1 = 1100


SHIFT WIDTH

If:

logic [3:0] a;

then shifting does NOT magically create a wider output.

Example:

1111 << 1

Conceptually:

11110

But a 4-bit result becomes:

1110

The overflow bit is discarded.


SHIFT SUMMARY

<<  = logical left shift
>>  = logical right shift
<<< = arithmetic left shift
>>> = arithmetic right shift


============================================================
15. CONCATENATION
============================================================

Concatenation combines multiple signals/bits into a larger vector.

Syntax:

{a,b}

Example:

a = 1010
b = 1100

{a,b}

= 10101100

Width:

4 bits + 4 bits = 8 bits


ORDER MATTERS

{a,b} is NOT the same as {b,a}.

Example:

a = 1010
b = 1100

{a,b} = 10101100

{b,a} = 11001010

The leftmost item becomes the more significant part of the resulting vector.


INDIVIDUAL BIT CONCATENATION

Example:

{a[0],b[3]}

If:

a = 1010
b = 1100

Then:

a[0] = 0
b[3] = 1

Therefore:

{a[0],b[3]} = 01


CONCATENATION WIDTH

The width of a concatenation is the SUM of the widths.

Examples:

{a,b}

4 + 4 = 8 bits

{a[0],b[3]}

1 + 1 = 2 bits

{a,b,c}

4 + 4 + 4 = 12 bits


Example RTL:

module concatenation(
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [7:0] y_ab,
    output logic [7:0] y_ba,
    output logic [1:0] y_selected
);

assign y_ab = {a,b};
assign y_ba = {b,a};
assign y_selected = {a[0],b[3]};

endmodule


============================================================
16. REPLICATION
============================================================

Replication repeats a bit pattern N times.

Syntax:

{N{pattern}}

IMPORTANT:

Replication has TWO sets of braces.

Example:

{4{1'b1}}

means:

repeat 1 four times.

Result:

1111


{4{1'b0}}

Result:

0000


MULTI-BIT REPLICATION

Suppose:

a = 2'b10

Then:

{3{a}}

means:

10 10 10

Result:

101010

Width:

2 bits × 3 repetitions = 6 bits


REPLICATION WIDTH RULE

Output width = pattern width × repetition count.


Examples:

a = 2 bits

{2{a}}

2 × 2 = 4 bits


{4{a}}

2 × 4 = 8 bits


{4{1'b0}}

1 × 4 = 4 bits


{4{1'b1}}

1 × 4 = 4 bits


REPLICATION VS CONCATENATION

Concatenation:

{a,b}

means:

A followed by B.

Replication:

{3{a}}

means:

A followed by A followed by A.


SIGN EXTENSION USING REPLICATION

Suppose:

a = 4'b1010

a[3] = 1

To sign-extend to 8 bits:

{{4{a[3]}},a}

Result:

11111010

This technique becomes extremely important in processor RTL.

Examples include:

- Immediate generation
- Sign extension
- ALU operands
- RISC-V datapaths


============================================================
17. CONDITIONAL OPERATOR
============================================================

The conditional operator is:

condition ? true_value : false_value

Example:

assign y = sel ? a : b;

Meaning:

if sel = 1:

y = a

if sel = 0:

y = b


MUX INTERPRETATION

The conditional operator is essentially a compact 2:1 multiplexer.

             sel
              |
              v
          +-------+
a ------->|       |
          |  MUX  |----> y
b ------->|       |
          +-------+

SystemVerilog:

assign y = sel ? a : b;


BUS EXAMPLE

logic [3:0] a;
logic [3:0] b;
logic sel;
logic [3:0] y;

assign y = sel ? a : b;

If:

a = 1010
b = 1100
sel = 0

y = 1100

If:

sel = 1

y = 1010


CONDITIONAL OPERATOR VS IF/ELSE

Conditional:

assign y = sel ? a : b;

Conceptually equivalent to:

if (sel)
    y = a;
else
    y = b;

The conditional operator is extremely common for simple combinational selection logic.


============================================================
18. VERILOG/SYSTEMVERILOG CODE VS RTL
============================================================

"Verilog/SystemVerilog code" refers to code written in the hardware description language.

"RTL" means Register Transfer Level.

RTL is a hardware abstraction level.

SystemVerilog is a language used to describe RTL.

Therefore:

Not every piece of SystemVerilog code is necessarily RTL, but SystemVerilog is commonly used to write RTL.

Example:

assign y = a & b;

This is SystemVerilog code that describes combinational RTL hardware.

Professional terminology:

"I'm writing Verilog/SystemVerilog code."

or:

"I'm writing RTL."

"RTL" is more hardware/design specific.

In VLSI, saying:

"I'm implementing the ALU RTL"

is more precise than:

"I'm writing ALU code."


============================================================
19. CONTINUOUS ASSIGNMENT
============================================================

The assign keyword creates a continuous assignment.

Example:

assign y = a & b;

This describes a continuous hardware relationship.

It does NOT mean:

"execute this line once."

Instead:

Whenever the inputs change, the output relationship updates.

Example:

assign y = a;

If a changes:

a = 0 → y = 0

a = 1 → y = 1


This is fundamental combinational RTL.


============================================================
20. TESTBENCH FUNDAMENTALS
============================================================

A testbench verifies the RTL.

Typical structure:

module and_gate_tb();

logic a;
logic b;
logic y;

and_gate uut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin

    $monitor("time=%0t | a=%b b=%b | y=%b",
             $time, a, b, y);

    #10 a = 0;
        b = 0;

    #10 a = 0;
        b = 1;

    #10 a = 1;
        b = 0;

    #10 a = 1;
        b = 1;

end

endmodule


DUT

DUT = Design Under Test.

Example:

and_gate uut(...);

uut = Unit Under Test.

The testbench:

1. Drives inputs.
2. DUT processes inputs.
3. Testbench observes outputs.


$MONITOR

$monitor continuously prints whenever a monitored signal changes.

Example:

$monitor("time=%0t | a=%b | y=%b",
         $time, a, y);


TIME DELAYS

#10

means wait 10 simulation time units.

Example:

#10 a = 0;

Then after another 10:

#10 a = 1;


============================================================
21. SIMULATION AND ICARUS VERILOG
============================================================

Compile:

iverilog -g2012 -o sim design.sv design_tb.sv

Run:

vvp sim

Example:

iverilog -g2012 -o sim not_gate.sv not_gate_tb.sv

vvp sim


Typical workflow:

1. Write RTL.
2. Write testbench.
3. Compile using Icarus Verilog.
4. Fix compile errors.
5. Run vvp.
6. Inspect simulation output.
7. Verify expected truth table.
8. Commit to Git.


============================================================
22. X / UNKNOWN VALUES
============================================================

At time 0, uninitialized signals often appear as:

x

or:

xxxx

X means UNKNOWN.

Example:

time=0 | a=x | y=x

This is normal if the testbench has not driven a yet.

After initialization:

time=10 | a=0 | y=1

the value becomes known.

Important:

X is NOT 0.

X is NOT 1.

It means the simulator does not know the signal's value.


============================================================
23. TEST VECTOR STRATEGY
============================================================

For N input bits:

number of possible combinations = 2^N


4-bit input:

2^4 = 16 combinations.

Therefore testing all 16 values is feasible.

For two 4-bit inputs:

2^4 × 2^4 = 256 combinations.

Manually testing every combination is usually unnecessary for simple demonstrations.

For larger spaces, use representative vectors.


IMPORTANT TEST CASES

Use:

1. All zeros
2. All ones
3. Alternating bits
4. Different patterns
5. Same patterns
6. Boundary values
7. Sign-bit cases
8. Zero/non-zero cases
9. Maximum value
10. Minimum signed value when relevant


Examples:

0000
1111
1010
0101
1000
0001
0011
1100


EXHAUSTIVE TESTING

Use when the input space is small.

Example:

4-bit reduction operators.

16 vectors is completely reasonable.


============================================================
24. WIDTH RULES
============================================================

THIS IS ONE OF THE MOST IMPORTANT TOPICS OF THE ENTIRE SECTION.

Always calculate the width of an expression before declaring the output.


BITWISE OPERATIONS

If:

a = 4 bits
b = 4 bits

then:

a & b = 4 bits

a | b = 4 bits

a ^ b = 4 bits

~a = 4 bits


REDUCTION OPERATIONS

If:

a = 4 bits

then:

&a = 1 bit

|a = 1 bit

^a = 1 bit


CONCATENATION

{a,b}

if:

a = 4 bits
b = 4 bits

then:

4 + 4 = 8 bits


REPLICATION

{4{a}}

if:

a = 2 bits

then:

4 × 2 = 8 bits


BIT SELECTION

a[3]

= 1 bit

a[0]

= 1 bit


CONDITIONAL

sel ? a : b

if a and b are 4 bits:

result = 4 bits


WIDTH TABLE

Operation                    Result Width

a & b                        operand width
a | b                        operand width
a ^ b                        operand width
~a                           operand width

&a                           1
|a                           1
^a                           1
~&a                          1
~|a                          1
~^a                          1

{a,b}                        width(a)+width(b)

{N{a}}                       N × width(a)

a[index]                     1

sel ? a : b                  selected value width


============================================================
25. SIGNED VS UNSIGNED
============================================================

By default, a declaration such as:

logic [3:0] a;

is unsigned.

Signed:

logic signed [3:0] a;


TWO'S COMPLEMENT

Signed binary numbers commonly use two's complement.

For 4-bit signed values:

0000 = 0
0001 = 1
0010 = 2
0011 = 3
0100 = 4
0101 = 5
0110 = 6
0111 = 7

1000 = -8
1001 = -7
1010 = -6
1011 = -5
1100 = -4
1101 = -3
1110 = -2
1111 = -1


This is why:

1010

when signed means:

-6

But when unsigned means:

10


ARITHMETIC RIGHT SHIFT

For signed values:

1010 >>> 1 = 1101

because the sign bit is preserved.


SIGN EXTENSION

If the sign bit is 1:

1010

sign extend:

11111010

If the sign bit is 0:

0101

sign extend:

00000101


Replication is commonly used for sign extension:

{{4{a[3]}},a}


============================================================
26. PACKED VS UNPACKED ARRAYS
============================================================

PACKED VECTOR:

logic [3:0] a;

This means:

one 4-bit vector.

Bits:

a[3:0]


UNPACKED ARRAY:

logic a[3:0];

This means an array containing multiple separate elements.

For normal RTL buses, use:

logic [3:0] a;

not:

logic a[3:0];


This distinction caused a compilation error during reduction operators.


============================================================
27. COMMON SYSTEMVERILOG SYNTAX RULES
============================================================

MODULE DECLARATION

Correct:

module example(
    input logic a,
    output logic y
);

Incorrect:

module example(
    input logic a,
    output logic y
)


The port list ends with:

);


MODULE NAME VS FILE NAME

Filename:

concate.sv

Module:

module concate(

Do NOT write:

module concate.sv


PORT TYPES

Correct:

input logic a;

Correct:

output logic y;

For a vector:

input logic [3:0] a;

output logic [3:0] y;


MODULE INSTANTIATION

Correct:

conditional_operator uut(
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

Remember the final:

);


TESTBENCH DECLARATIONS

Correct:

logic [3:0] a;
logic [3:0] b;

Do not separate declarations with commas.

Wrong:

logic [3:0] a,
logic [3:0] b,


LITERALS

Prefer:

4'b1010

instead of:

1010

because:

4 = width
b = binary
1010 = value


OTHER COMMON FORMATS

8'b10101010
8'hA5
16'd100
32'hDEADBEEF


============================================================
28. COMMON MISTAKES / WEAKNESSES IDENTIFIED
============================================================

These are the specific weaknesses identified while completing Section 2.


WEAKNESS 1 — WIDTH CALCULATION

This was the biggest recurring weakness.

Examples of incorrect thinking:

output logic [8:0] y_ab;

when:

{a,b}

is only 8 bits.

Correct:

output logic [7:0] y_ab;


Another example:

{4{1'b0}}

is:

4 × 1 = 4 bits

NOT 8 bits.


FIX:

Before declaring an output, ask:

"What is the exact width of this expression?"


Use this process:

1. Determine operand widths.
2. Identify the operator.
3. Calculate result width.
4. Declare output accordingly.


------------------------------------------------------------

WEAKNESS 2 — PACKED VS UNPACKED ARRAYS

Initially:

logic a[3:0];

was used when:

logic [3:0] a;

was required.

Correct for a normal bus:

logic [3:0] a;

Remember:

logic [3:0] a;

= one packed 4-bit vector.


------------------------------------------------------------

WEAKNESS 3 — INPUT VS TESTBENCH STIMULUS

Initially attempted:

assign a = 2'b01;

inside a DUT where a was an input.

This is incorrect.

The DUT receives inputs.

The testbench drives inputs.


Correct architecture:

TESTBENCH
    |
    | drives inputs
    v
DUT
    |
    | produces outputs
    v
TESTBENCH observes outputs


DUT:

input logic [1:0] a;


TESTBENCH:

a = 2'b01;


------------------------------------------------------------

WEAKNESS 4 — SMALL SYNTAX ERRORS

Recurring issues included:

- Missing semicolons
- Missing ); after port lists
- Missing ); after module instantiations
- Incorrect input declarations
- Incorrect literal notation
- Incorrect module naming


These are not conceptual hardware problems.

They are syntax discipline problems.

Fix:

After writing each module, perform a syntax scan:

[ ] module name correct
[ ] opening (
[ ] all ports declared
[ ] closing );
[ ] assignments end with ;
[ ] endmodule present


------------------------------------------------------------

WEAKNESS 5 — BITWISE VS LOGICAL OPERATORS

Must be completely automatic:

&  = bitwise AND
&& = logical AND

|  = bitwise OR
|| = logical OR

~  = bitwise NOT
!  = logical NOT


Example:

a = 1010
b = 0101

a & b = 0000

a && b = 1

because both a and b are non-zero.


------------------------------------------------------------

WEAKNESS 6 — SIGNEDNESS

Initially:

>> and >>> appeared identical.

That was because the operand was unsigned.

After making a signed:

logic signed [3:0] a;

the difference became:

1010 >> 1  = 0101

1010 >>> 1 = 1101


Must remember:

>>  = logical right shift

>>> = arithmetic right shift


------------------------------------------------------------

WEAKNESS 7 — EXPLICIT BINARY LITERALS

Avoid:

a = 1010;

when intending binary.

Prefer:

a = 4'b1010;


This makes the width and base explicit.


------------------------------------------------------------

WEAKNESS 8 — HARDWARE MENTAL MODEL

The next level is to stop thinking:

"this line of code executes."

Instead think:

"this expression describes a hardware relationship."


For example:

assign y = a & b;

means:

a and b feed an AND operation whose output drives y.


assign y = sel ? a : b;

means:

a and b feed a multiplexer controlled by sel.


assign y = a << 1;

means:

the bits are shifted to form the resulting vector.


RTL describes hardware structure/behavior, not sequential software execution.


------------------------------------------------------------

WEAKNESS 9 — WIDTH + SIGNEDNESS TOGETHER

The next major improvement is to combine:

WIDTH

and

SIGNEDNESS

thinking.

For every non-trivial expression ask:

1. What are the operand widths?
2. Are the operands signed or unsigned?
3. What operator is being used?
4. What is the resulting width?
5. Is sign extension occurring?
6. Is truncation occurring?


This habit becomes critical in:

- ALUs
- Register files
- Datapaths
- Multipliers
- Comparators
- Immediate generators
- CPU RTL


============================================================
29. MASTER OPERATOR CHEAT SHEET
============================================================

BASIC BOOLEAN:

NOT:
~a

BUFFER:
a

AND:
a & b

OR:
a | b

NAND:
~(a & b)

NOR:
~(a | b)

XOR:
a ^ b

XNOR:
~(a ^ b)

or:

a ~^ b

or:

a ^~ b


REDUCTION:

AND:
&a

OR:
|a

XOR:
^a

NAND:
~&a

NOR:
~|a

XNOR:
~^a

or:

^~a


LOGICAL:

AND:
a && b

OR:
a || b

NOT:
!a


SHIFT:

Logical left:
a << n

Logical right:
a >> n

Arithmetic left:
a <<< n

Arithmetic right:
a >>> n


CONCATENATION:

{a,b}


REPLICATION:

{N{a}}


CONDITIONAL:

sel ? a : b


============================================================
30. FINAL SECTION CHECKLIST
============================================================

BASIC GATES

[✓] NOT Gate
[✓] Buffer
[✓] AND Gate
[✓] OR Gate
[✓] NAND Gate
[✓] NOR Gate
[✓] XOR Gate
[✓] XNOR Gate


MULTI-INPUT

[✓] Multi-input AND
[✓] Multi-input OR
[✓] Multi-input NAND
[✓] Multi-input NOR
[✓] Multi-input XOR
[✓] Multi-input XNOR
[✓] XOR parity


VECTORS

[✓] Bus concept
[✓] 4-bit vectors
[✓] Bit indexing
[✓] Packed vectors
[✓] Width calculation


REDUCTION

[✓] Reduction AND
[✓] Reduction OR
[✓] Reduction XOR
[✓] Reduction NAND
[✓] Reduction NOR
[✓] Reduction XNOR


BITWISE

[✓] Bitwise AND
[✓] Bitwise OR
[✓] Bitwise XOR
[✓] Bitwise XNOR
[✓] Bitwise NOT


LOGICAL

[✓] Logical AND
[✓] Logical OR
[✓] Logical NOT
[✓] Zero vs non-zero behavior
[✓] No separate logical XOR/XNOR operators


SHIFT

[✓] <<
[✓] >>
[✓] <<<
[✓] >>>
[✓] Logical shifting
[✓] Arithmetic shifting
[✓] Signedness
[✓] Sign extension
[✓] Fixed-width behavior


CONCATENATION

[✓] {a,b}
[✓] Ordering
[✓] Bit selection
[✓] Width calculation


REPLICATION

[✓] {N{pattern}}
[✓] Single-bit replication
[✓] Multi-bit replication
[✓] Width calculation
[✓] Sign extension


CONDITIONAL

[✓] ?:
[✓] MUX behavior
[✓] Bus selection
[✓] Conditional vs if/else


VERIFICATION

[✓] Testbench structure
[✓] DUT
[✓] UUT
[✓] $monitor
[✓] # delays
[✓] Icarus Verilog
[✓] vvp
[✓] X/unknown values
[✓] Test vectors
[✓] Exhaustive testing


============================================================
FINAL MENTAL MODEL
============================================================

When writing RTL, think in this order:

1. SIGNALS
   What are my inputs and outputs?

2. WIDTHS
   How many bits does every signal contain?

3. SIGNEDNESS
   Are the signals signed or unsigned?

4. OPERATOR
   Is this:
   - bitwise?
   - logical?
   - reduction?
   - shift?
   - concatenation?
   - replication?
   - conditional?

5. RESULT WIDTH
   How many bits will the expression produce?

6. HARDWARE
   What physical hardware does this describe?

7. TESTBENCH
   What input vectors prove that it works?

8. SIMULATION
   Does the waveform/output match the expected hardware behavior?



