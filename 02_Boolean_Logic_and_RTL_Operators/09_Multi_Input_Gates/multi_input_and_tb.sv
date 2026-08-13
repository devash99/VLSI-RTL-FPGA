module multi_input_and_tb();
logic a;
logic b;
logic c;
logic y;

multi_input_and uut(
    .a(a),
    .b(b),
    .c(c),
    .y(y)
);

initial begin 
                $monitor("time=%0t | a=%b b=%b c=%b | y=%b", $time, a, b, c, y);  
    #10 a=0;
        b=0;
        c=0;
    #10 a=0;
        b=0;
        c=1;
    #10 a=0;
        b=1;
        c=0;
    #10 a=1;
        b=0;
        c=0;
    #10 a=1;
        b=1;
        c=0;
    #10 a=1;
        b=0;
        c=1;
    #10 a=0;
        b=1;
        c=1;
    #10 a=1;
        b=1;
        c=1;
end 

endmodule