module shift_operators_tb();
logic [3:0] a;
logic [3:0] y_left;
logic [3:0] y_right;
logic [3:0] y_arith_left;
logic [3:0] y_arith_right;

shift_operators uut(
    .a(a),
    .y_left(y_left),
    .y_right(y_right),
    .y_arith_left(y_arith_left),
    .y_arith_right(y_arith_right)
);

initial begin
        $monitor ("time =%0t | a=%b | y_left=%b y_right=%b y_arith_left=%b y_arith_right=%b", $time, a, y_left, y_right, y_arith_left, y_arith_right);
#10 a=4'b0000;
#10 a=4'b0001;
#10 a=4'b0011;
#10 a=4'b1111;
#10 a=4'b1010;
#10 a=4'b1100;
#10 a=4'b0101;
#10 a=4'b1000;

end

endmodule

