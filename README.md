# VLSI — RTL to RISC-V Processor

A long-term hardware design project focused on **Digital Design, SystemVerilog RTL, FPGA implementation, Computer Architecture, and RISC-V processor design**.

**This repository documents the design and implementation of my RISC-V processor and the RTL components developed toward it**.

## Vision

The ultimate goal is to design and verify an advanced **64-bit RISC-V RV64GC out-of-order superscalar processor** from RTL.

### Target Architecture

```text
ISA                 : RISC-V RV64GC
Execution           : Out-of-Order
Issue               : Superscalar
Pipeline            : 7-Stage
                      IF → ID → RN → IS → EX → WB → CM

Scheduling          : Tomasulo-style
Reorder Buffer      : 32 Entries

Architectural Regs  : 32
Physical Regs       : 64

Reservation Stations:
  Integer           : 8
  Multiply          : 4
  Memory            : 8

Branch Prediction   : Tournament Predictor
Target Accuracy     : >93%

Verification        : SystemVerilog / UVM
Implementation      : FPGA
```

## Processor Architecture

```text
                  Instruction Fetch
                          │
                          ▼
                       Decode
                          │
                          ▼
                  Register Rename
                          │
                          ▼
                 Issue / Scheduling
                          │
              ┌───────────┼───────────┐
              ▼           ▼           ▼
           Integer     Multiply     Memory
              │           │           │
              └───────────┼───────────┘
                          ▼
                      Writeback
                          │
                          ▼
                   Reorder Buffer
                          │
                          ▼
                       Commit
```

## Core Areas

* Digital Logic
* SystemVerilog / Verilog
* RTL Design
* RTL Verification
* Combinational & Sequential Logic
* FPGA Design
* Computer Architecture
* RISC-V ISA
* Pipelining
* Hazard Handling & Forwarding
* Register Renaming
* Tomasulo Scheduling
* Out-of-Order Execution
* Superscalar Architecture
* Branch Prediction
* Memory Systems
* SystemVerilog Assertions
* UVM

## Toolchain

**HDL:** SystemVerilog, Verilog
**Simulation:** Icarus Verilog, Verilator, GTKWave
**FPGA:** AMD/Xilinx Vivado
**Verification:** SystemVerilog, UVM
**Development:** VS Code, Git, GitHub, Linux/macOS

## End Goal

Design, verify, synthesize, and implement an advanced **RV64GC out-of-order superscalar RISC-V processor**, from individual RTL blocks to a complete working CPU.

> **From gates to RTL. From RTL to architecture. From architecture to a processor.**
