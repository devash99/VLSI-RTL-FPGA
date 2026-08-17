module multi_input_gates_tb();
logic a;
logic b;
logic c;
logic y1;
logic y2;
logic y3;
logic y4;
logic y5;
logic y6;

multi_input_gates uut(
    .a(a),
    .b(b),
    .c(c),
    .y1(y1),
    .y2(y2),
    .y3(y3),
    .y4(y4),
    .y5(y5),
    .y6(y6)

);

initial begin 
                $monitor("time=%0t | a=%b b=%b c=%b | y1=%b y2=%b y3=%b y4=%b y5=%b y6=%b", $time, a, b, c, y1, y2, y3, y4, y5, y6);  
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