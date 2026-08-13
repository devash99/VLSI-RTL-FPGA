module logical_operators(
    input logic [3:0] a,
    input logic [3:0] b,
    output y_and,
    output y_or,
    output y_not
);

assign y_and = a && b;
assign y_or = a || b;
assign y_not = !a;

endmodule
