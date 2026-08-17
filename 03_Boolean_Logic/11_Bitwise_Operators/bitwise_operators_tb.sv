module bitwise_operators_tb();
logic [3:0] a;
logic [3:0] b;
logic [3:0] y_and;
logic [3:0] y_or;
logic [3:0] y_xor;
logic [3:0] y_xnor;
logic [3:0] y_not;

bitwise_operators uut(
    .a(a),
    .b(b),
    .y_and(y_and),
    .y_or(y_or),
    .y_xor(y_xor),
    .y_xnor(y_xnor),
    .y_not(y_not)
);

initial begin
    $monitor("time=%0t | a=%b b=%b | y_and=%b y_or=%b y_xor=%b y_xnor=%b y_not=%b", $time, a, b, y_and, y_or, y_xor, y_xnor, y_not);  
#10 a = 4'b0000;
    b = 4'b0000;

#10 a = 4'b1111;
    b = 4'b1111;

#10 a = 4'b1010;
    b = 4'b0101;

#10 a = 4'b1100;
    b = 4'b1010;

#10 a = 4'b1011;
    b = 4'b1101;

#10 a = 4'b0101;
    b = 4'b0011;
end
endmodule 