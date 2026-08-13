module reduction_operators(
    input logic [3:0] a,
    output y_and,
    output y_or,
    output y_xor
);

assign y_and = &a;
assign y_or = |a;
assign y_xor = ^a;

endmodule 