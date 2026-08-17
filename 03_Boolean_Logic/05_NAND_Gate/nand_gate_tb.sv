module nand_gate_tb();
logic a;
logic b;
logic y;

nand_gate uut (
    .a(a),
    .b(b),
    .y(y)
);

initial begin 
        $monitor("time=%0t | a=%b b=%b | y=%b", $time, a, b, y);  
    #10 a=0;
        b=0;
    #10 a=0;
        b=1;
    #10 a=1;
        b=0;
    #10 a=1;
        b=1;
end 

endmodule

