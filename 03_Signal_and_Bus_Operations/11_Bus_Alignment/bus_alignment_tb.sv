module bus_alignment_tb();
logic [3:0] data;
logic [7:0] right_aligned;
logic [7:0] left_aligned;

bus_alignment uut(
    .data(data),
    .right_aligned(right_aligned),
    .left_aligned(left_aligned)
);

initial begin
    $monitor ("t=%0t | data=%b | right_aligned=%b left_aligned=%b", $time, data, right_aligned, left_aligned);

#10 data=4'b0000;
#10 data=4'b0001;
#10 data=4'b0010;
#10 data=4'b0011;
#10 data=4'b0100;
#10 data=4'b0101;
#10 data=4'b0110;
#10 data=4'b0111;
#10 data=4'b1000;
#10 data=4'b1001;
#10 data=4'b1010;
end 

endmodule

