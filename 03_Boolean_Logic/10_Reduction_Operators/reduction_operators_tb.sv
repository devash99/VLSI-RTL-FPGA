module reduction_operators_tb();
logic [3:0] a;
logic y_and;
logic y_or;
logic y_xor;

reduction_operators uut(
    .a(a),
    .y_and(y_and),
    .y_or(y_or),
    .y_xor(y_xor)
);

initial begin 
            $monitor("time=%0t | a=%b | y_and=%b y_or=%b y_xor=%b", $time, a, y_and, y_or, y_xor);  
#10 a=4'b0000;
#10 a=4'b0001;
#10 a=4'b0010;
#10 a=4'b0011;
#10 a=4'b0100;
#10 a=4'b0101;
#10 a=4'b0110;
#10 a=4'b0111;
#10 a=4'b1000;
#10 a=4'b1001;
#10 a=4'b1010;
#10 a=4'b1011;
#10 a=4'b1100;
#10 a=4'b1101;
#10 a=4'b1110;
#10 a=4'b1111;

end 

endmodule