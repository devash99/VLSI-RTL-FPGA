module bit_masking(
    input logic [7:0] data,
    input logic [7:0] mask,
    output logic [7:0] result
);

assign result = data & mask;

endmodule

