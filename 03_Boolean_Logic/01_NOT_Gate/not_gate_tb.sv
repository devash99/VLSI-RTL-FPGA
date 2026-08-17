module not_gate_tb();
logic a;
logic y;

not_gate uut(
    .a(a),
    .y(y)
);

initial begin 
    $monitor("time = %0t | a=%b | y=%b", $time, a, y);
    #10 a=0;
    #10 a=1;
end

endmodule
