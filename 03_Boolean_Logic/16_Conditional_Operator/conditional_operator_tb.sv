module conditional_operator_tb();
logic [3:0] a;
logic [3:0] b;
logic sel;
logic [3:0] y;

conditional_operator uut(
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

initial begin
    $monitor ("t=%0t | a=%b b=%b sel=%b | y=%b", $time, a, b, sel, y);
#10 a = 4'b1010; 
    b = 4'b1100; 
    sel = 0;

#10 a = 4'b1010;
    b = 4'b1100;
    sel = 1;
end

endmodule
