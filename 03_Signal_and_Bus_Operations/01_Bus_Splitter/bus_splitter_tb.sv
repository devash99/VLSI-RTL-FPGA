module bus_splitter_tb();
logic [7:0] A;
logic [3:0] lower;
logic [3:0] upper;

bus_splitter uut(
    .A(A),
    .lower(lower),
    .upper(upper)
);

initial begin
    $monitor ("t=%0t | A=%b | lower=%b upper=%b", $time, A, lower, upper);
#10 A=8'b00000000;
#10 A=8'b11111111;
#10 A=8'b10101010;
#10 A=8'b01010101;
#10 A=8'b11001100;
#10 A=8'b00110011;
#10 A=8'b10110110;
end
endmodule

