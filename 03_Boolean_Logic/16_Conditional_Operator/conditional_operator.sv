module conditional_operator(
    input logic [3:0] a,
    input logic [3:0] b,
    input logic sel,
    output logic [3:0] y
);

assign y = sel ? a : b;

endmodule

