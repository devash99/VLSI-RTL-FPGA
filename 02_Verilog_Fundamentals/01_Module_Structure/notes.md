# Verilog Fundamentals — Module Structure

## 1. Verilog / SystemVerilog Mental Model

Verilog/SystemVerilog is an HDL (Hardware Description Language).

It is used to describe hardware, not to write a normal sequential software program.

Hardware described in HDL operates concurrently.

Example:

assign y = a & b;

This represents a continuous hardware relationship:

a ──┐
    AND ──► y
b ──┘

It does NOT mean:

"Execute this line once."

It means:

"Create hardware behavior where y continuously reflects a AND b."

---

## 2. Module

A module is a hardware block.

It can represent:

- Logic gate
- Adder
- Multiplexer
- ALU
- Register
- CPU
- Any other digital hardware block

Basic structure:

module module_name();

endmodule

Module with ports:

module basic_module(
    input a,
    input b,
    output y
);

endmodule

Mental model:

             MODULE
        ┌─────────────┐
a ─────►│             │
b ─────►│   Hardware  │────► y
        │             │
        └─────────────┘

The module is the container for a hardware block.

---

## 3. Module Ports

Ports are the connection points at the boundary of a module.

Common directions:

input  → signal enters the module
output → signal leaves the module
inout  → signal can travel in both directions

Example:

module basic_module(
    input a,
    input b,
    output y
);

endmodule

Mental model:

        MODULE
   ┌─────────────┐
a ─►             │
b ─►   hardware  ├──► y
   │             │
   └─────────────┘

Ports define the external interface of a module.

---

## 4. Internal Signals

Signals can also exist inside a module.

Example:

logic a;
logic b;
logic y;

These are internal signals when they are declared inside a module rather than as ports.

Mental model:

Ports:
- Define the boundary/interface of a module.

Internal signals:
- Represent connections inside the module.

---

## 5. Continuous Assignment

Syntax:

assign destination = expression;

Example:

assign y = a & b;

This represents a continuously existing hardware relationship.

If an input changes:

input changes
    ↓
expression is reevaluated
    ↓
output changes

It is NOT a software loop.

There is no CPU executing the statement repeatedly.

The statement describes the relationship between hardware signals.

---

## 6. First RTL Design — AND Gate

Our first design:

module basic_module(
    input a,
    input b,
    output y
);

assign y = a & b;

endmodule

Hardware:

a ──┐
    AND ──► y
b ──┘

Truth table:

| a | b | y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

---

# Testbench and Simulation

## 7. What is a Testbench?

A testbench is a simulation environment used to test a hardware design.

DUT = Design Under Test.

Our DUT:

basic_module.sv

Our testbench:

basic_module_tb.sv

Mental model:

             TESTBENCH
                 │
                 │ drives inputs
                 ▼
                DUT
                 │
                 │ produces outputs
                 ▼
             TESTBENCH

A testbench can:

- Generate inputs
- Observe outputs
- Check expected behavior
- Generate waveforms
- Report failures

The testbench is normally NOT synthesized into FPGA hardware.

It exists primarily for verification.

---

## 8. DUT

DUT = Design Under Test.

The DUT is the actual hardware block being tested.

In our example:

basic_module.sv

The testbench interacts with the DUT.

---

## 9. Testbench Signals

For our AND gate:

TESTBENCH ──► a ──► DUT
TESTBENCH ──► b ──► DUT

DUT ──► y ──► TESTBENCH

Therefore:

a → controlled by the testbench
b → controlled by the testbench
y → produced by the DUT

"Drive a signal" means:

Put a value onto that signal.

Example:

a = 1

means the driver of `a` is currently putting logic 1 onto that connection.

---

## 10. Testbench Structure

Our testbench:

module basic_module_tb();

logic a;
logic b;
logic y;

basic_module uut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin

    // stimulus

end

endmodule

Unlike the DUT, this testbench has no external ports because it is the top-level simulation environment.

---

# Module Instantiation

## 11. What is Instantiation?

Instantiation means:

Creating an instance of one module inside another module and connecting its ports to signals in the surrounding module.

General structure:

module_name instance_name(
    .port(signal),
    .port(signal)
);

Our example:

basic_module uut(
    .a(a),
    .b(b),
    .y(y)
);

Meaning:

DUT port       Testbench signal

DUT.a     →    TB.a
DUT.b     →    TB.b
DUT.y     →    TB.y

Mental model:

             TESTBENCH
   ┌────────────────────────┐
   │                        │
   │ a ───────────────┐     │
   │                  │     │
   │ b ────────────┐  │     │
   │               ▼  ▼     │
   │             ┌──────┐   │
   │             │ UUT  │   │
   │             │ AND  │   │
   │             └──┬───┘   │
   │                │       │
   │ y ◄────────────┘       │
   │                        │
   └────────────────────────┘

Instantiation creates a hierarchical hardware relationship.

Later, large designs will be built using the same concept:

CPU
├── ALU
├── Register File
├── Control Unit
├── Memory Interface
└── Branch Unit

Each block can be a module instantiated inside another module.

---

## 12. UUT

`uut` commonly means:

Unit Under Test.

Example:

basic_module uut(...);

`uut` is simply the instance name.

The instance could technically be called:

dut
and1
my_gate
anything

`uut` is simply a common testbench convention.

---

# Simulation Stimulus

## 13. initial Block

An `initial` block is commonly used in testbenches to generate simulation stimulus.

Example:

initial begin

    // simulation actions

end

Mental model:

simulation starts
      ↓
initial block starts
      ↓
statements execute
      ↓
simulation continues

Important:

`initial` in our testbench is a simulation construct.

We are using it to generate test stimulus.

It is not describing synthesizable FPGA hardware in this context.

---

## 14. Simulation Time and Delays

Example:

#10 a = 0;

Means:

Wait 10 simulation time units, then assign 0 to `a`.

Our stimulus:

#10 a = 0;
    b = 0;

#10 a = 1;
    b = 0;

#10 a = 0;
    b = 1;

#10 a = 1;
    b = 1;

Simulation sequence:

t = 10 → a=0, b=0
t = 20 → a=1, b=0
t = 30 → a=0, b=1
t = 40 → a=1, b=1

The `#10` is a simulation delay.

At this stage we are not modeling an FPGA clock.

---

# Observation

## 15. $monitor

`$monitor` is a simulation system task used to observe signals.

Example:

$monitor("time=%0t | a=%b b=%b | y=%b", $time, a, b, y);

Meaning:

%0t → simulation time
%b  → binary value
$time → current simulation time
a, b, y → signals being observed

`$monitor` prints when one of the monitored values changes.

Example output:

time=0  | a=x b=x | y=x
time=10 | a=0 b=0 | y=0
time=20 | a=1 b=0 | y=0
time=30 | a=0 b=1 | y=0
time=40 | a=1 b=1 | y=1

`$monitor` is for simulation/verification.

It is not hardware.

---

# 4-State Logic

## 16. Four Simulation States

SystemVerilog simulation commonly uses four logic states:

0 → known logic 0
1 → known logic 1
X → unknown
Z → high impedance

At simulation time 0, our testbench signals had not been assigned yet:

a = X
b = X

Therefore:

y = a & b
  = X & X
  = X

So the simulator initially showed:

time=0 | a=x b=x | y=x

This is useful information.

The simulator is telling us that the signal does not currently have a known value.

---

# Simulator vs Testbench vs DUT

## 17. Difference

### DUT

The actual hardware design being tested.

Example:

basic_module.sv

### Testbench

The environment that:

- Generates stimulus
- Drives DUT inputs
- Observes DUT outputs
- Verifies behavior

Example:

basic_module_tb.sv

### Simulator

Software that models the behavior of the DUT and testbench over simulation time.

Our simulator:

Icarus Verilog

Mental model:

DUT
↓
Actual hardware being described

Testbench
↓
Environment testing the hardware

Simulator
↓
Software modeling their behavior

---

# Icarus Verilog

## 18. Icarus Verilog

Icarus Verilog is a Verilog/SystemVerilog compiler and simulator.

We used:

iverilog -g2012 -o sim basic_module.sv basic_module_tb.sv

This compiles/elaborates the design and testbench into a simulation executable:

sim

Important:

Compilation is NOT the same as running the simulation.

---

# VVP

## 19. VVP

We ran:

vvp sim

`vvp` executes the compiled Icarus simulation.

Complete flow:

basic_module.sv
        +
basic_module_tb.sv
        ↓
     iverilog
        ↓
       sim
        ↓
      vvp sim
        ↓
   simulation runs

---

# First Compilation Error

## 20. Debugging the First Error

Our first compilation produced:

basic_module_tb.sv:3: syntax error

The problem was:

module basic_module_tb ()

It needed:

module basic_module_tb ();

The missing semicolon caused the parser to report the error at a later line.

Important debugging lesson:

The line reported by a compiler is not always the actual location where the mistake was made.

Always inspect the surrounding syntax when debugging compiler errors.

---

# Complete First Testbench

## 21. basic_module_tb.sv

Current working testbench:

module basic_module_tb ();

logic a;
logic b;
logic y;

basic_module uut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin

    $monitor("time=%0t | a=%b b=%b | y=%b", $time, a, b, y);

    #10 a = 0;
        b = 0;

    #10 a = 1;
        b = 0;

    #10 a = 0;
        b = 1;

    #10 a = 1;
        b = 1;

end

endmodule

---

# 22. First Complete Hardware Verification Loop

We completed:

Hardware idea
      ↓
Digital logic
      ↓
Verilog module
      ↓
Testbench
      ↓
DUT instantiation
      ↓
Stimulus
      ↓
Icarus compilation
      ↓
VVP simulation
      ↓
Observe output
      ↓
Compare with truth table
      ↓
Verified

This is the fundamental RTL development loop.

---

# 23. Actual Simulation Result

Our AND gate simulation produced:

time=0  | a=x b=x | y=x
time=10 | a=0 b=0 | y=0
time=20 | a=1 b=0 | y=0
time=30 | a=0 b=1 | y=0
time=40 | a=1 b=1 | y=1

Verification:

| a | b | Expected y | Simulated y |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 |
| 0 | 1 | 0 | 0 |
| 1 | 1 | 1 | 1 |

All four known input combinations matched.

Therefore the RTL behavior was verified.

---

# 24. Current Folder

Current structure:

02_Verilog_Fundamentals/
└── 01_Module_Structure/
    ├── basic_module.sv
    ├── basic_module_tb.sv
    └── notes.md

After compilation, an additional generated file exists:

sim

`sim` is a build artifact, not source code.

Eventually generated files should be separated or ignored using `.gitignore`.

---

# 25. Complete Mental Model

Keep this hierarchy in mind:

Digital Logic
      ↓
Circuit
      ↓
RTL description
      ↓
Module
      ↓
Ports + internal signals
      ↓
Module Instantiation
      ↓
Testbench
      ↓
Simulation
      ↓
Verification
      ↓
Synthesis
      ↓
Real hardware

The goal is NOT to memorize Verilog syntax.

The goal is to understand:

"What hardware am I trying to build?"

and:

"How does my HDL describe that hardware?"

---

# 26. Key Lessons Learned

1. A module represents a hardware block.
2. Ports define the module's external interface.
3. Internal signals represent connections inside a module.
4. `assign` describes a continuous hardware relationship.
5. A DUT is the hardware being tested.
6. A testbench is the simulation environment around the DUT.
7. Testbench signals can drive DUT inputs and observe DUT outputs.
8. Instantiation creates an instance of one module inside another.
9. `uut` commonly means Unit Under Test.
10. `initial` is useful for testbench stimulus.
11. `#10` introduces simulation time delay.
12. `$monitor` lets us observe signals during simulation.
13. `iverilog` compiles/elaborates the design.
14. `vvp` runs the compiled simulation.
15. `X` represents an unknown simulation value.
16. Simulation verifies behavior before hardware implementation.
17. Testbench code is generally not part of the synthesized FPGA hardware.
18. Hardware operates concurrently; HDL describes hardware relationships rather than normal sequential software execution.
19. Debugging compiler errors is part of the real RTL workflow.
20. The complete process is:

Design → RTL → Testbench → Compile → Simulate → Observe → Verify.