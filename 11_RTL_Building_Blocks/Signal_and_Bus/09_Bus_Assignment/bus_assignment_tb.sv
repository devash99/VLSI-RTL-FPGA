module bus_assignment_tb();
logic [7:0] data;
logic [7:0] result;
logic [7:0] result_inverted;

bus_assignment uut(
    .data(data),
    .result(result),
    .result_inverted(result_inverted)
);

initial begin
    $monitor ("t=%0t | data=%b | result=%b inverted=%b", $time, data, result, result_inverted);
    #10 data=8'b00110011;
    #10 data=8'b10010000;
    #10 data=8'b10010111;
    #10 data=8'b11110000;
    #10 data=8'b11111110;
    #10 data=8'b00000001;
end

endmodule