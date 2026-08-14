module bit_selection_tb();
logic [7:0] data;
logic bit_7;
logic bit_6;
logic bit_5;
logic bit_4;
logic bit_3;
logic bit_2;
logic bit_1;
logic bit_0;

bit_selection uut(
    .data(data),
    .bit_7(bit_7),
    .bit_6(bit_6),
    .bit_5(bit_5),
    .bit_4(bit_4),
    .bit_3(bit_3),
    .bit_2(bit_2),
    .bit_1(bit_1),
    .bit_0(bit_0)
);

initial begin
$monitor("t=%0t | data=%b | b7=%b b6=%b b5=%b b4=%b b3=%b b2=%b b1=%b b0=%b", $time, data, bit_7, bit_6, bit_5, bit_4, bit_3, bit_2, bit_1, bit_0);

#10 data=8'b10010000;
#10 data=8'b11111111;
#10 data=8'b00000000;
#10 data=8'b10110110;
end
endmodule

