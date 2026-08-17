module bus_slicing_tb();
logic [15:0] data;
logic [3:0] field_0;
logic [3:0] field_1;
logic [3:0] field_2;
logic [3:0] field_3;

bus_slicing uut(
    .data(data),
    .field_0(field_0),
    .field_1(field_1),
    .field_2(field_2),
    .field_3(field_3)
);

initial begin
    $monitor ("t=%0t | field_0=%b field_1=%b field_2=%b field_3=%b", $time, field_0, field_1, field_2, field_3);

#10 data = 16'b1100101010110110;
#10 data = 16'b1100000010110110;
#10 data = 16'b1100101110110111;
#10 data = 16'b1100101111110110;
#10 data = 16'b0000101010110110;
#10 data = 16'b1100001100110110;
end

endmodule

