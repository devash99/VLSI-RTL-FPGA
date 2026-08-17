module multi_input_gates(
    input a,
    input b,
    input c,
    output y1,
    output y2,
    output y3,
    output y4,
    output y5,
    output y6
);

assign y1 = (a & b & c);
assign y2 = (a | b | c);
assign y3 = ~(a & b & c);
assign y4 = ~(a | b | c);
assign y5 = (a ^ b ^ c);
assign y6 = ~(a ^ b ^ c);

endmodule

