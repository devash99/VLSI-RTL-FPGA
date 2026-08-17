module part_selection_tb();
logic [15:0] data;
logic [7:0] upper;
logic [7:0] lower;
logic [3:0] middle;
logic [3:0] nibble;

part_selection uut(
    .data(data),
    .upper(upper),
    .lower(lower),
    .middle(middle),
    .nibble(nibble)
);

initial begin
    $monitor ("t=%0t | data=%b | upper=%b lower=%b middle=%b nibble=%b", $time, data, upper, lower, middle, nibble);

#10 data = 16'b1100101010110110;
#10 data = 16'b1100000010110110;
#10 data = 16'b1100101110110111;
#10 data = 16'b1100101111110110;
#10 data = 16'b0000101010110110;
#10 data = 16'b1100001100110110;
end

endmodule

