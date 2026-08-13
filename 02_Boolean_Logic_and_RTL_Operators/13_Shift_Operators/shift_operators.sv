module shift_operators(
    input logic signed [3:0] a,
    output logic [3:0] y_left,
    output logic [3:0] y_right,
    output logic [3:0] y_arith_left,
    output logic [3:0] y_arith_right
);

assign y_left = a << 1;
assign y_right = a >> 1;
assign y_arith_left = a <<< 1;
assign y_arith_right = a >>> 1;

endmodule

