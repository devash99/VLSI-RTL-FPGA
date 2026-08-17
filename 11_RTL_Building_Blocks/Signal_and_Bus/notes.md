
# SECTION 3 — SIGNAL & BUS OPERATIONS
COMPLETE RTL NOTES

# STATUS: COMPLETE — 11/11 TOPICS

01. Bus Splitter
02. Bus Combiner
03. Bit Selection
04. Part Selection
05. Bus Slicing
06. Sign Extension
07. Zero Extension
08. Bit Masking
09. Bus Assignment
10. Bus Width Conversion
11. Bus Alignment


======================================================================
0. SECTION OVERVIEW
======================================================================

Section 3 is about manipulating, routing, extracting, extending,
assigning, masking, resizing, and positioning digital signals and buses
inside RTL designs.

The main idea is:

    LARGE BUS
       |
       +---- select bits
       |
       +---- split into fields
       |
       +---- combine fields
       |
       +---- extend width
       |
       +---- reduce width
       |
       +---- mask bits
       |
       +---- align fields
       |
       +---- assign/reroute signals


These operations are fundamental to:

- CPU datapaths
- Register files
- Instruction decoding
- Memory interfaces
- Address generation
- Control registers
- Status registers
- ALUs
- Immediate generators
- Bus interfaces
- FPGA designs
- RISC-V processors
- RTL datapath construction


======================================================================
1. FUNDAMENTAL CONCEPT — WHAT IS A BUS?
======================================================================

A bus is a group of multiple bits treated as one signal.

Example:

    logic [7:0] data;

This is an 8-bit bus.

The bits are:

    data[7] data[6] data[5] data[4] data[3] data[2] data[1] data[0]

Example:

    data = 8'b10110110


Bit positions:

    data[7] = 1
    data[6] = 0
    data[5] = 1
    data[4] = 1
    data[3] = 0
    data[2] = 1
    data[1] = 1
    data[0] = 0


IMPORTANT:

The leftmost bit is the MSB.

The rightmost bit is the LSB.

For:

    logic [7:0] data;

    7 = MSB
    0 = LSB


======================================================================
2. VECTOR DECLARATION
======================================================================

A vector is declared using:

    logic [MSB:LSB] signal_name;

Example:

    logic [7:0] data;

means:

    data has 8 bits.


Width calculation:

    width = MSB - LSB + 1


Examples:

    [7:0]    = 8 bits
    [3:0]    = 4 bits
    [15:8]   = 8 bits
    [31:16]  = 16 bits
    [6:0]    = 7 bits


VERY IMPORTANT DISTINCTION:

    logic [3:0]

is a DECLARATION.

It means:

    "This signal is 4 bits wide."


Whereas:

    data[3:0]

is a SELECTION.

It means:

    "Select bits 3 through 0 from data."


This was one of the main mistakes made during Section 3.

MEMORIZE:

    logic [3:0]     → DECLARE a 4-bit signal
    data[3:0]       → SELECT 4 bits from data


======================================================================
3. BIT INDEXING
======================================================================

A single bit is selected using:

    signal[index]

Example:

    data[7]

selects exactly one bit.

For:

    data = 10110110

we have:

    data[7] = 1
    data[6] = 0
    data[5] = 1
    data[4] = 1
    data[3] = 0
    data[2] = 1
    data[1] = 1
    data[0] = 0


Single-bit selection:

    assign bit_7 = data[7];


======================================================================
4. RANGE SELECTION
======================================================================

A range is selected using:

    signal[MSB:LSB]

Example:

    data[7:4]

selects four bits.

If:

    data = 10110110

then:

    data[7:4] = 1011
    data[3:0] = 0110


Width:

    7 - 4 + 1 = 4 bits


Another example:

    data[15:8]

is 8 bits wide.

    15 - 8 + 1 = 8


======================================================================
5. BUS SPLITTER
======================================================================

A bus splitter takes one large bus and separates it into smaller buses.

Example:

    8-bit input
         |
         +---- upper 4 bits
         |
         +---- lower 4 bits


Example:

    A = 10110110

    A[7:4] = 1011
    A[3:0] = 0110


RTL:

    module bus_splitter(
        input logic [7:0] A,
        output logic [3:0] upper,
        output logic [3:0] lower
    );

    assign upper = A[7:4];
    assign lower = A[3:0];

    endmodule


Hardware interpretation:

                A[7:0]
                   |
           +-------+-------+
           |               |
           v               v
        A[7:4]          A[3:0]
           |               |
           v               v
         upper           lower


IMPORTANT:

The output does NOT need to be declared [7:4].

Correct:

    output logic [3:0] upper;

because upper contains 4 bits.


Incorrect:

    output logic [7:4] upper;


The source range:

    A[7:4]

is where the original bit positions are specified.

The destination:

    logic [3:0]

simply represents a 4-bit signal.


APPLICATIONS:

- instruction fields
- address fields
- control fields
- register fields
- datapaths
- packet decoding
- CPU instruction decoding


======================================================================
6. BUS COMBINER
======================================================================

Bus combiner performs the reverse operation.

It combines smaller buses into one larger bus.

Example:

    upper = 1011
    lower = 0110

combine:

    {upper, lower}

result:

    10110110


RTL:

    module bus_combiner(
        input logic [3:0] upper,
        input logic [3:0] lower,
        output logic [7:0] data
    );

    assign data = {upper, lower};

    endmodule


IMPORTANT:

Concatenation:

    {A, B}

means:

    A goes on the LEFT
    B goes on the RIGHT


Therefore:

    {1011, 0110}

becomes:

    10110110


This is directly related to Section 2's concatenation operator.


======================================================================
7. CONCATENATION
======================================================================

Concatenation joins signals together.

Syntax:

    {signal1, signal2, signal3}


Example:

    logic [3:0] a;
    logic [3:0] b;
    logic [7:0] result;

    assign result = {a, b};


If:

    a = 1010
    b = 1100

then:

    result = 10101100


Order matters.

    {a, b} != {b, a}


Example:

    {1010, 1100} = 10101100

    {1100, 1010} = 11001010


======================================================================
8. BIT SELECTION
======================================================================

Bit selection means selecting ONE individual bit.

Syntax:

    signal[index]


Example:

    data[7]

selects bit 7.

Example RTL:

    module bit_selection(
        input logic [7:0] data,
        output logic bit_7,
        output logic bit_6,
        output logic bit_5,
        output logic bit_4,
        output logic bit_3,
        output logic bit_2,
        output logic bit_1,
        output logic bit_0
    );

    assign bit_7 = data[7];
    assign bit_6 = data[6];
    assign bit_5 = data[5];
    assign bit_4 = data[4];
    assign bit_3 = data[3];
    assign bit_2 = data[2];
    assign bit_1 = data[1];
    assign bit_0 = data[0];

    endmodule


Example:

    data = 10110110

    bit_7 = 1
    bit_6 = 0
    bit_5 = 1
    bit_4 = 1
    bit_3 = 0
    bit_2 = 1
    bit_1 = 1
    bit_0 = 0


KEY DISTINCTION:

    data[7]

        = one bit


    data[7:4]

        = four bits


======================================================================
9. PART SELECTION
======================================================================

Part selection selects one continuous range of bits.

Syntax:

    signal[MSB:LSB]


Example:

    data[15:8]

selects the upper 8 bits.

Example:

    data = 1100101010110110

    data[15:8] = 11001010
    data[7:0]  = 10110110


Additional examples:

    data[11:8]
    data[7:4]
    data[3:0]


IMPORTANT:

If:

    data[11:8]

is selected, the destination is still just a 4-bit signal:

    logic [3:0] field;


NOT:

    logic [11:8] field;


Why?

Because the selected value has four bits.

The source indexes do not transfer to the destination.


MENTAL MODEL:

    SOURCE RANGE              DESTINATION

    data[11:8]  ----------->  field[3:0]

    4 bits                     4 bits


======================================================================
10. BUS SLICING
======================================================================

Bus slicing means partitioning a larger bus into multiple meaningful
fields.

Example:

    data = 1100101010110110


Visual representation:

    [15:12] [11:8] [7:4] [3:0]
    1100    1010   1011   0110


RTL:

    assign field_3 = data[15:12];
    assign field_2 = data[11:8];
    assign field_1 = data[7:4];
    assign field_0 = data[3:0];


Result:

    field_3 = 1100
    field_2 = 1010
    field_1 = 1011
    field_0 = 0110


Bus slicing is commonly used for:

- instruction fields
- packet headers
- register fields
- configuration registers
- CPU control signals
- memory-mapped registers


Example CPU instruction:

    32-bit instruction
    +---------+---------+---------+---------+
    | field A | field B | field C | opcode  |
    +---------+---------+---------+---------+


Each field can be extracted using a slice.


IMPORTANT DISTINCTION:

BIT SELECTION:

    data[7]

    = one bit


PART SELECTION:

    data[7:4]

    = one contiguous range


BUS SLICING:

    multiple ranges extracted from one larger bus

Example:

    data[15:12]
    data[11:8]
    data[7:4]
    data[3:0]


======================================================================
11. SIGNED NUMBERS AND SIGN BIT
======================================================================

For two's-complement signed numbers:

    MSB = 0 → positive
    MSB = 1 → negative


Example 4-bit:

    0101

MSB = 0

therefore positive.


Example:

    1011

MSB = 1

therefore negative.


This becomes important when increasing the width of signed values.


======================================================================
12. SIGN EXTENSION
======================================================================

Sign extension increases the width of a signed value while preserving
its numerical meaning.

Rule:

    Copy the MSB/sign bit into the new upper bits.


If sign bit = 0:

    add zeros.


If sign bit = 1:

    add ones.


Examples:

    0101 → 00000101

    0011 → 00000011

    0111 → 00000111


Negative examples:

    1000 → 11111000

    1001 → 11111001

    1010 → 11111010

    1011 → 11111011

    1111 → 11111111


RTL:

    assign extended = {{4{data[3]}}, data};


Breakdown:

    data[3]

is the sign bit.


    {4{data[3]}}

replicates the sign bit four times.


If:

    data = 1011

then:

    data[3] = 1

    {4{data[3]}} = 1111

therefore:

    {1111, 1011}

    = 11111011


If:

    data = 0101

then:

    data[3] = 0

    {4{data[3]}} = 0000

therefore:

    {0000, 0101}

    = 00000101


======================================================================
13. REPLICATION OPERATOR
======================================================================

Syntax:

    {N{value}}


Example:

    {4{1'b0}}

produces:

    0000


Example:

    {4{1'b1}}

produces:

    1111


Example:

    {4{data[3]}}

copies data[3] four times.


This is heavily used in sign extension.


======================================================================
14. ZERO EXTENSION
======================================================================

Zero extension increases the width of a value by adding zeros to the
MSB side.

Example:

    1011 → 00001011


Unlike sign extension, the original MSB does not matter.

Always add zeros.


RTL:

    assign extended = {4'b0000, data};


Examples:

    0000 → 00000000
    0001 → 00000001
    0011 → 00000011
    0111 → 00000111
    1000 → 00001000
    1001 → 00001001
    1010 → 00001010
    1011 → 00001011
    1111 → 00001111


IMPORTANT COMPARISON:

    data = 1011


SIGN EXTENSION:

    11111011


ZERO EXTENSION:

    00001011


Therefore:

    SIGN EXTENSION → copy sign bit

    ZERO EXTENSION → insert zeros


======================================================================
15. SIGN EXTENSION VS ZERO EXTENSION
======================================================================

This is one of the most important comparisons in Section 3.


4-bit value:

    1000


ZERO EXTENSION:

    00001000


SIGN EXTENSION:

    11111000


Another:

    1011


ZERO:

    00001011


SIGN:

    11111011


Decision rule:

    If the value is SIGNED:
        use sign extension.


    If the value is UNSIGNED:
        use zero extension.


This distinction becomes extremely important in CPUs.


======================================================================
16. BIT MASKING
======================================================================

Bit masking selectively keeps or clears bits.

Typical operation:

    result = data & mask;


The mask determines which bits survive.


Rule:

    mask bit = 1 → KEEP original data bit

    mask bit = 0 → CLEAR data bit


Example:

    data = 10110110
    mask = 00001111

    AND
    --------
           00000110


Why?

    1 AND 0 = 0
    0 AND 0 = 0
    1 AND 0 = 0
    1 AND 0 = 0

and:

    0 AND 1 = 0
    1 AND 1 = 1
    1 AND 1 = 1
    0 AND 1 = 0


Result:

    00000110


Another example:

    data = 10110110
    mask = 11110000

    result = 10110000


Another:

    data = 10110110
    mask = 10101010

    result = 10100010


RTL:

    assign result = data & mask;


APPLICATIONS:

- clearing bits
- extracting fields
- register manipulation
- enable bits
- control registers
- status registers
- permissions
- CPU control
- hardware configuration


======================================================================
17. MASKING TO EXTRACT A FIELD
======================================================================

Suppose:

    data = 10110110


Want only lower 4 bits.

Use:

    mask = 00001111


Then:

    10110110
    00001111
    --------
    00000110


Want upper 4 bits:

    mask = 11110000


Then:

    10110110
    11110000
    --------
    10110000


Masking is therefore another way of controlling which bits survive.


======================================================================
18. BUS ASSIGNMENT
======================================================================

Bus assignment means directly assigning one bus to another.

Example:

    logic [7:0] data;
    logic [7:0] result;


RTL:

    assign result = data;


This means:

    data[7:0] → result[7:0]


No arithmetic is performed.

No logic transformation occurs.

It is direct signal routing.


Hardware interpretation:

    data ----------------------> result


Example:

    data = 10110110

    result = 10110110


Every bit is copied.


======================================================================
19. BUS ASSIGNMENT WITH TRANSFORMATION
======================================================================

Assignment can also happen after a transformation.

Example:

    assign inverted = ~data;


If:

    data = 00110011

then:

    inverted = 11001100


This is different from simple assignment.


Direct assignment:

    assign result = data;


Transformation:

    assign inverted = ~data;


The assignment itself is still just routing the resulting value.


======================================================================
20. WIDTH MATCHING
======================================================================

When assigning buses, widths matter.

Example:

    8-bit → 8-bit

    logic [7:0] a;
    logic [7:0] b;

    assign b = a;

Correct and straightforward.


Example:

    4-bit → 8-bit

Requires extension.


Example:

    8-bit → 4-bit

Requires truncation/selection.


General idea:

    SAME WIDTH
        ↓
    direct assignment


    SMALL → LARGE
        ↓
    extension


    LARGE → SMALL
        ↓
    truncation/selection


======================================================================
21. BUS WIDTH CONVERSION
======================================================================

Bus width conversion means changing the width of a signal.

Three major cases:

    1. Narrow → Wide
    2. Wide → Narrow
    3. Equal → Equal


----------------------------------------------------------------------
21.1 NARROW → WIDE
----------------------------------------------------------------------

Example:

    4-bit → 8-bit


Must decide how to generate the new upper bits.


ZERO EXTENSION:

    1011 → 00001011


SIGN EXTENSION:

    1011 → 11111011


----------------------------------------------------------------------
21.2 WIDE → NARROW
----------------------------------------------------------------------

Example:

    8-bit → 4-bit


Some bits must be discarded or selected.


Example:

    data = 10110110


Upper nibble:

    data[7:4] = 1011


Lower nibble:

    data[3:0] = 0110


This is truncation/selection.


----------------------------------------------------------------------
21.3 EQUAL WIDTH
----------------------------------------------------------------------

Example:

    8-bit → 8-bit


Simply:

    assign result = data;


======================================================================
22. BUS WIDTH CONVERSION RTL
======================================================================

A combined example:

    module bus_width_conversion(
        input logic [3:0] narrow_data,
        input logic [7:0] wide_data,

        output logic [7:0] zero_extended,
        output logic [7:0] sign_extended,
        output logic [3:0] lower_nibble,
        output logic [3:0] upper_nibble
    );

    assign zero_extended = {4'b0000, narrow_data};

    assign sign_extended =
        {{4{narrow_data[3]}}, narrow_data};

    assign lower_nibble = wide_data[3:0];

    assign upper_nibble = wide_data[7:4];

    endmodule


This single design demonstrates:

    zero extension
    sign extension
    part selection
    truncation
    width conversion


======================================================================
23. BUS ALIGNMENT
======================================================================

Bus alignment means positioning a value or field at the correct bit
positions inside a larger bus.


Example:

    data = 1011


RIGHT ALIGNED:

    00001011


LEFT ALIGNED:

    10110000


RTL:

    assign right_aligned = {4'b0000, data};

    assign left_aligned = {data, 4'b0000};


For:

    data = 1011


Right:

    00001011


Left:

    10110000


The value is the same 4-bit field, but its position inside the
8-bit bus changes.


======================================================================
24. WHY ALIGNMENT MATTERS
======================================================================

Alignment is important when different fields must occupy specific
positions inside a larger bus.

Example:

    16-bit bus:

    [15:12] [11:8] [7:4] [3:0]


Suppose a 4-bit field must occupy [7:4].

Conceptually:

    0000 FIELD 0000 0000


The field has to be shifted/positioned correctly.


Alignment is important in:

- CPU datapaths
- memory interfaces
- register fields
- instruction formats
- addresses
- packet formats
- peripheral interfaces
- bus protocols


======================================================================
25. BIT SELECTION VS PART SELECTION VS SLICING
======================================================================

This distinction is extremely important.


BIT SELECTION:

    data[7]

returns:

    1 bit


PART SELECTION:

    data[7:4]

returns:

    4 continuous bits


BUS SLICING:

    data[15:12]
    data[11:8]
    data[7:4]
    data[3:0]

extracts multiple fields.


Think:

    BIT:
        one wire


    PART:
        one group of adjacent wires


    SLICING:
        multiple groups/fields from one bus


======================================================================
26. SOURCE VS DESTINATION WIDTH
======================================================================

One of the biggest mistakes made during Section 3 was confusing the
source range with the destination width.


Example:

    data[7:4]


This is a 4-bit selection.


The destination should normally be:

    logic [3:0] upper;


NOT:

    logic [7:4] upper;


The source says:

    WHICH BITS?


The destination says:

    HOW MANY BITS?


Example:

    data[11:8] → field


means:

    source = bits 11 through 8
    width = 4 bits


therefore:

    logic [3:0] field;


======================================================================
27. DECLARATION VS SELECTION
======================================================================

THIS IS THE MOST IMPORTANT SYNTAX LESSON FROM SECTION 3.


DECLARATION:

    logic [7:0] data;


means:

    data is an 8-bit signal.


SELECTION:

    data[7:4]


means:

    select four bits from data.


DECLARATION:

    logic [3:0] field;


SELECTION:

    data[3:0]


They look similar but do completely different jobs.


MEMORIZE:

    logic [N:M] signal

        → DECLARATION


    signal[N:M]

        → SELECTION


======================================================================
28. COMMON RTL PATTERN
======================================================================

A huge amount of bus manipulation follows:

    assign destination = source[range];


Examples:

    assign lower = data[3:0];

    assign upper = data[7:4];

    assign opcode = instruction[6:0];

    assign rd = instruction[11:7];

    assign rs1 = instruction[19:15];

    assign rs2 = instruction[24:20];


This pattern will appear constantly in CPU RTL.


======================================================================
29. CPU / RISC-V CONNECTION
======================================================================

These Section 3 concepts directly map to your future RISC-V processor.


Example RISC-V instruction:

    instruction[31:0]


Fields can be extracted:

    opcode = instruction[6:0]

    rd     = instruction[11:7]

    funct3 = instruction[14:12]

    rs1    = instruction[19:15]

    rs2    = instruction[24:20]

    funct7 = instruction[31:25]


This is:

    BIT SELECTION
    PART SELECTION
    BUS SLICING


Immediate values then need:

    SIGN EXTENSION


For example:

    12-bit immediate → 64-bit RV64 value


This is:

    SIGN EXTENSION


The processor may also:

    mask bits
    align fields
    combine fields
    route buses
    convert widths


So Section 3 is not just basic syntax.

It is fundamental CPU datapath knowledge.


======================================================================
30. IMMEDIATE GENERATION CONNECTION
======================================================================

Suppose a RISC-V instruction contains a 12-bit signed immediate.

You may extract:

    instruction[31:20]


Then sign extend:

    {{52{instruction[31]}}, instruction[31:20]}


This converts:

    12 bits → 64 bits


The concepts used are directly from Section 3:

    Part Selection
        +
    Sign Extension
        +
    Replication
        +
    Concatenation


This is why sign extension is extremely important for your future
RV64I immediate generator.


======================================================================
31. UNKNOWN VALUES — X
======================================================================

At simulation time 0, inputs may be uninitialized.

You may see:

    data = xxxxxxxx


This means:

    UNKNOWN


Example:

    t=0
    data=xxxxxxxx
    result=xxxxxxxx


This is normal if data has not yet been assigned.


After:

    #10 data = 8'b10110110;


the signal becomes known.


Important:

    x = unknown


It does NOT mean:

    0


and it does NOT mean:

    1


It means the simulator cannot determine the value.


======================================================================
32. UNKNOWN VALUES WITH EXTENSION
======================================================================

Zero extension:

    data = xxxx

    extended = 0000xxxx


Why?

Because the upper four bits are explicitly zero.

The lower four depend on data.


Sign extension:

    data = xxxx

    extended = xxxxxxxx


Why?

Because the sign bit itself is unknown.

The replicated sign bits therefore become unknown.


This is correct simulator behavior.


======================================================================
33. TESTBENCH FORMAT SPECIFIERS
======================================================================

Useful $monitor formats:


    %b

Binary.


Example:

    $monitor("data=%b", data);


    %d

Decimal.


    %h

Hexadecimal.


    %t

Simulation time.


Typical RTL learning monitor:

    $monitor(
        "t=%0t | data=%b | result=%b",
        $time,
        data,
        result
    );


IMPORTANT:

Do not use %t for normal binary signals.

One of the mistakes made during Section 3 was using time formatting for
data values.


======================================================================
34. TESTBENCH STRUCTURE
======================================================================

Typical structure:

    module testbench();

    logic [7:0] data;
    logic [7:0] result;


    dut uut(
        .data(data),
        .result(result)
    );


    initial begin

        $monitor(...);

        #10 data = ...;
        #10 data = ...;
        #10 data = ...;

    end

    endmodule


The testbench:

    1. declares input-driving signals
    2. declares output-observing signals
    3. instantiates the DUT
    4. connects ports
    5. drives test vectors
    6. monitors outputs


======================================================================
35. DUT CONNECTIONS
======================================================================

Suppose DUT:

    module example(
        input logic [7:0] data,
        output logic [3:0] lower
    );


Testbench needs:

    logic [7:0] data;
    logic [3:0] lower;


Instance:

    example uut(
        .data(data),
        .lower(lower)
    );


Every DUT input that needs to be driven should have a corresponding
testbench signal.

Every DUT output that needs to be observed should have a corresponding
testbench signal.


======================================================================
36. COMMON MISTAKES MADE IN SECTION 3
======================================================================

MISTAKE 1:

    assign upper = logic [7:4];


WHY WRONG?

    logic [7:4]

is a declaration, not a source signal.


CORRECT:

    assign upper = A[7:4];


------------------------------------------------------------

MISTAKE 2:

    output logic [7:4] upper;


WHY WRONG?

The selected value is 4 bits wide.

CORRECT:

    output logic [3:0] upper;


------------------------------------------------------------

MISTAKE 3:

Declared:

    input logic [7:0] A;


Then wrote:

    assign bit_7 = data[7];


WHY WRONG?

The input is called A.

CORRECT:

    assign bit_7 = A[7];


------------------------------------------------------------

MISTAKE 4:

Forgetting the input signal in the testbench.

If DUT has:

    input logic [15:0] data;


TB needs:

    logic [15:0] data;


and:

    .data(data)


------------------------------------------------------------

MISTAKE 5:

Not connecting all DUT ports.

Every relevant port should be deliberately connected.


------------------------------------------------------------

MISTAKE 6:

Using %t for data.

WRONG:

    $monitor("data=%t", data);


CORRECT:

    $monitor("data=%b", data);


------------------------------------------------------------

MISTAKE 7:

Swapping upper/lower names.

For:

    data[15:8]

this is conventionally:

    upper


For:

    data[7:0]

this is:

    lower


------------------------------------------------------------

MISTAKE 8:

Confusing source indexes with destination indexes.

Wrong mental model:

    data[7:4] → upper[7:4]


Correct:

    data[7:4] → upper[3:0]


The selected range contains four bits.


======================================================================
37. HOW TO AVOID THESE MISTAKES
======================================================================

Before writing an assignment, ask three questions:


QUESTION 1:

    What is my SOURCE?


Example:

    data


QUESTION 2:

    Which bits do I want?


Example:

    data[11:8]


QUESTION 3:

    Where are they going?


Example:

    logic [3:0] field


Then:

    assign field = data[11:8];


MENTAL MODEL:

    SOURCE
       ↓
    SELECT
       ↓
    DESTINATION


Example:

    data[15:0]
         |
         | select [11:8]
         ↓
       4 bits
         |
         ↓
    field[3:0]


This eliminates most bus-related syntax errors.


======================================================================
38. WIDTH RULE
======================================================================

Always calculate the width of a selection.

Formula:

    width = MSB - LSB + 1


Examples:

    [7:4]

    7 - 4 + 1 = 4


    [15:8]

    15 - 8 + 1 = 8


    [31:20]

    31 - 20 + 1 = 12


This is extremely useful for instruction decoding.


======================================================================
39. TRUNCATION
======================================================================

When a larger value is assigned to a smaller destination, some bits
must be discarded.

Example:

    8-bit:

    10110110


Take lower 4 bits:

    0110


Take upper 4 bits:

    1011


This is truncation/selection.


You must know which bits are being discarded.


======================================================================
40. EXTENSION
======================================================================

When a smaller value becomes larger, new bits must be added.


UNSIGNED:

    ZERO EXTENSION


SIGNED:

    SIGN EXTENSION


Example:

    4 → 8


Zero:

    1011 → 00001011


Sign:

    1011 → 11111011


======================================================================
41. ALIGNMENT
======================================================================

Alignment controls where a field sits inside a larger bus.


4-bit:

    1011


Right aligned in 8-bit:

    00001011


Left aligned in 8-bit:

    10110000


Right alignment:

    {4'b0000, data}


Left alignment:

    {data, 4'b0000}


Alignment is essentially positioning.


======================================================================
42. BIT MASKING VS BIT SELECTION
======================================================================

These can both be used to access fields, but they are conceptually
different.


SELECTION:

    data[3:0]


directly extracts the bits.


MASKING:

    data & 8'b00001111


keeps those bits but leaves the result at their original positions.


Example:

    data = 10110110


Selection:

    data[3:0]

    result = 0110


Mask:

    10110110
    00001111
    --------
    00000110


The mask keeps the lower bits in their original bus positions.


======================================================================
43. CONCATENATION VS MASKING
======================================================================

Concatenation combines fields:

    {upper, lower}


Masking selectively keeps/clears bits:

    data & mask


Selection extracts bits:

    data[7:4]


These are different operations with different purposes.


======================================================================
44. SECTION 3 MASTER CHEAT SHEET
======================================================================

BUS DECLARATION:

    logic [7:0] data;


ONE BIT:

    data[7]


RANGE:

    data[7:4]


DIRECT ASSIGNMENT:

    assign result = data;


CONCATENATION:

    assign result = {a, b};


REPLICATION:

    {4{data[3]}}


SIGN EXTENSION:

    assign extended = {{4{data[3]}}, data};


ZERO EXTENSION:

    assign extended = {4'b0000, data};


MASK:

    assign result = data & mask;


UPPER HALF:

    data[7:4]


LOWER HALF:

    data[3:0]


UPPER 8 OF 16:

    data[15:8]


LOWER 8 OF 16:

    data[7:0]


LEFT ALIGN:

    {data, 4'b0000}


RIGHT ALIGN:

    {4'b0000, data}


WIDTH:

    MSB - LSB + 1


BINARY MONITOR:

    %b


TIME:

    %t


UNKNOWN:

    x


======================================================================
45. COMPLETE SECTION 3 CONCEPT MAP
======================================================================

                         SIGNAL / BUS
                              |
          +-------------------+-------------------+
          |                   |                   |
       SELECT               ROUTE             MODIFY
          |                   |                   |
     +----+----+          +---+---+          +----+----+
     |         |          |       |          |         |
   BIT       PART       SPLIT   COMBINE    MASK     EXTEND
     |         |          |       |          |         |
   data[7]   data[7:4]    split   {a,b}    data&mask   |
                                                        |
                                                 +------+------+
                                                 |             |
                                               SIGN           ZERO
                                             extension      extension
                                                 |
                                                 |
                                              ALIGN
                                                 |
                                      +----------+----------+
                                      |                     |
                                    LEFT                  RIGHT
                                      |                     |
                               {data, zeros}         {zeros, data}


======================================================================
46. REAL HARDWARE INTERPRETATION
======================================================================

Most of these operations synthesize primarily into wiring/routing,
selection logic, or simple combinational logic.

Examples:


BUS SPLITTER:

    Mostly wires.


BUS COMBINER:

    Mostly wires.


BIT/PART SELECTION:

    Mostly wires.


SIGN EXTENSION:

    Wires from the sign bit to the new upper positions.


ZERO EXTENSION:

    New upper bits tied to zero.


BUS ASSIGNMENT:

    Direct routing.


MASKING:

    AND gates.


ALIGNMENT:

    Wiring/repositioning.


WIDTH CONVERSION:

    Selection, extension, truncation, and routing.


This is important:

RTL is describing hardware relationships.

You are not writing software instructions for the hardware to execute.


======================================================================
47. SYNTHESIS VIEW
======================================================================

Example:

    assign lower = data[3:0];


Synthesis sees:

    connect data[3:0] to lower.


No clock is needed.

No flip-flop is required.

No memory is created.


Example:

    assign result = data & mask;


Synthesis produces:

    8 parallel AND operations.


Example:

    assign extended = {{4{data[3]}}, data};


Synthesis produces wiring from data[3] to four output bits and connects
the original data bits to the remaining outputs.


======================================================================
48. COMBINATIONAL NATURE
======================================================================

Every operation in Section 3 was fundamentally combinational.

The output depends directly on the current input.

There is no clock.

There is no state.

There is no memory.

Examples:

    assign result = data;

    assign result = data & mask;

    assign upper = data[7:4];

    assign extended = {4'b0000, data};


All are combinational relationships.


======================================================================
49. SECTION 3 VERIFICATION STRATEGY
======================================================================

For bus-related RTL, good test vectors should include:


1. ALL ZERO:

    00000000


2. ALL ONE:

    11111111


3. ALTERNATING:

    10101010


4. INVERSE ALTERNATING:

    01010101


5. DIFFERENT UPPER/LOWER:

    10110110


6. PATTERNED:

    11001100


7. ANOTHER PATTERN:

    00110011


For extension:

    0000
    0111
    1000
    1010
    1111


The boundary between:

    MSB = 0

and:

    MSB = 1

is especially important for sign extension.


======================================================================
50. SECTION 3 TESTBENCH CHECKLIST
======================================================================

Before considering a module complete:

[ ] DUT compiles.

[ ] Testbench compiles.

[ ] DUT instantiated.

[ ] All ports connected.

[ ] Inputs initialized.

[ ] Multiple test vectors used.

[ ] Boundary cases tested.

[ ] Outputs visually verified.

[ ] %b used for binary signals.

[ ] No unexpected X values after initialization.

[ ] Simulation output matches expected behavior.

[ ] Simulation file removed.

[ ] RTL committed.

[ ] Testbench committed.

[ ] Git pushed.


======================================================================
51. SECTION 3 PROJECT STRUCTURE
======================================================================

03_Signal_and_Bus_Operations/

├── 01_Bus_Splitter/
│   ├── bus_splitter.sv
│   └── bus_splitter_tb.sv
│
├── 02_Bus_Combiner/
│   ├── bus_combiner.sv
│   └── bus_combiner_tb.sv
│
├── 03_Bit_Selection/
│   ├── bit_selection.sv
│   └── bit_selection_tb.sv
│
├── 04_Part_Selection/
│   ├── part_selection.sv
│   └── part_selection_tb.sv
│
├── 05_Bus_Slicing/
│   ├── bus_slicing.sv
│   └── bus_slicing_tb.sv
│
├── 06_Sign_Extension/
│   ├── sign_extension.sv
│   └── sign_extension_tb.sv
│
├── 07_Zero_Extension/
│   ├── zero_extension.sv
│   └── zero_extension_tb.sv
│
├── 08_Bit_Masking/
│   ├── bit_masking.sv
│   └── bit_masking_tb.sv
│
├── 09_Bus_Assignment/
│   ├── bus_assignment.sv
│   └── bus_assignment_tb.sv
│
├── 10_Bus_Width_Conversion/
│   ├── bus_width_conversion.sv
│   └── bus_width_conversion_tb.sv
│
└── 11_Bus_Alignment/
    ├── bus_alignment.sv
    └── bus_alignment_tb.sv


======================================================================
52. SECTION 3 FINAL SUMMARY
======================================================================

01. BUS SPLITTER

    One large bus → multiple smaller buses.

    Example:

        A[7:4]
        A[3:0]


02. BUS COMBINER

    Multiple smaller buses → one larger bus.

    Example:

        {upper, lower}


03. BIT SELECTION

    Select one bit.

    Example:

        data[7]


04. PART SELECTION

    Select one continuous range.

    Example:

        data[7:4]


05. BUS SLICING

    Extract multiple fields from a bus.

    Example:

        data[15:12]
        data[11:8]
        data[7:4]
        data[3:0]


06. SIGN EXTENSION

    Increase width while preserving signed value.

    Copy MSB.

        1011 → 11111011


07. ZERO EXTENSION

    Increase width by adding zeros.

        1011 → 00001011


08. BIT MASKING

    Selectively keep/clear bits.

        result = data & mask

    mask 1 → keep
    mask 0 → clear


09. BUS ASSIGNMENT

    Direct bus routing.

        assign result = data;


10. BUS WIDTH CONVERSION

    Narrow → wide:
        extension

    Wide → narrow:
        truncation/selection

    Equal width:
        direct assignment


11. BUS ALIGNMENT

    Position a field correctly inside a larger bus.

    Right:

        00001011

    Left:

        10110000


======================================================================
53. MOST IMPORTANT RULES TO REMEMBER
======================================================================

RULE 1:

    logic [N:M]

    = declaration


RULE 2:

    signal[N:M]

    = selection


RULE 3:

    signal[N]

    = one bit


RULE 4:

    width = MSB - LSB + 1


RULE 5:

    mask 1 → keep bit

    mask 0 → clear bit


RULE 6:

    signed → sign extension

    unsigned → zero extension


RULE 7:

    narrow → wide → extend

    wide → narrow → select/truncate


RULE 8:

    {A,B}

    = A on left, B on right


RULE 9:

    {N{A}}

    = replicate A N times


RULE 10:

    %b = binary

    %t = time


RULE 11:

    Upper bits are conventionally the MSB side.

    Lower bits are conventionally the LSB side.


RULE 12:

    Source range determines the number of selected bits.

    Destination width should match the selected width.


======================================================================
54. FINAL MENTAL MODEL
======================================================================

When you see ANY bus in RTL, think:

                    BUS
                     |
          +----------+----------+
          |          |          |
        SELECT      SPLIT      MASK
          |          |          |
       bit/part    fields     keep/clear
          |
          +----------------+
                           |
                       TRANSFORM
                           |
                +----------+----------+
                |          |          |
              EXTEND     ALIGN      ASSIGN
                |          |          |
             sign/zero   position    route


The fundamental question for every bus operation is:

    "What bits do I have, which bits do I want, where should
     they go, and what width should the destination be?"


======================================================================
55. SECTION 3 — CONNECTION TO THE FINAL RISC-V PROJECT
======================================================================

These concepts will directly appear in the processor.

Instruction decoding:

    instruction[6:0]
    instruction[11:7]
    instruction[14:12]
    instruction[19:15]
    instruction[24:20]
    instruction[31:25]


Immediate extraction:

    instruction[31:20]


Immediate sign extension:

    {{52{instruction[31]}}, instruction[31:20]}


Register fields:

    rd
    rs1
    rs2


Control fields:

    opcode
    funct3
    funct7


Datapath routing:

    bus assignment
    bus splitting
    bus combining
    masking
    alignment


RV64 width conversion:

    32-bit / smaller fields → 64-bit values


This is the foundation for:

    Immediate Generator
    ALU
    Branch Unit
    Register File
    Control Unit
    Datapath
    Address Generation Unit


======================================================================
SECTION 3 COMPLETE
======================================================================

IMPLEMENTATION:

    01 Bus Splitter          COMPLETE
    02 Bus Combiner          COMPLETE
    03 Bit Selection         COMPLETE
    04 Part Selection        COMPLETE
    05 Bus Slicing           COMPLETE
    06 Sign Extension        COMPLETE
    07 Zero Extension        COMPLETE
    08 Bit Masking           COMPLETE
    09 Bus Assignment        COMPLETE
    10 Bus Width Conversion  COMPLETE
    11 Bus Alignment         COMPLETE


======================================================================