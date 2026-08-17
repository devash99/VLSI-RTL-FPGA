module bitwise_operators(
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [3:0] y_and,
    output logic [3:0] y_or,
    output logic [3:0] y_xor,
    output logic [3:0] y_xnor,
    output logic [3:0] y_not
);

assign y_and = a & b;
assign y_or = a | b;
assign y_xor = a ^ b;
assign y_xnor = ~(a ^ b);
assign y_not = ~a;

endmodule 