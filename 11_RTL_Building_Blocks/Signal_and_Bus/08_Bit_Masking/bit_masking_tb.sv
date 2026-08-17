module bit_masking_tb();
logic [7:0] data;
logic [7:0] mask;
logic [7:0] result;

bit_masking uut(
    .data(data),
    .mask(mask),
    .result(result)
);

initial begin
    $monitor ("t=%0t | data=%b mask=%b | result=%b", $time, data, mask, result);

#10 data = 8'b00000000; mask = 8'b11111111;
#10 data = 8'b11111111; mask = 8'b00000000;
#10 data = 8'b10110110; mask = 8'b11111111;
#10 data = 8'b10110110; mask = 8'b00001111;
#10 data = 8'b10110110; mask = 8'b11110000;
#10 data = 8'b10110110; mask = 8'b10101010;
#10 data = 8'b11110000; mask = 8'b00001111;
end

endmodule
