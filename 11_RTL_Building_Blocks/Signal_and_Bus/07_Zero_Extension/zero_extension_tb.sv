module zero_extension_tb();

logic [3:0] data;
logic [7:0] extended;

zero_extension uut(
    .data(data),
    .extended(extended)
);

initial begin

    $monitor("t=%0t | data=%b | extended=%b",
             $time, data, extended);

    #10 data = 4'b0000;
    #10 data = 4'b0001;
    #10 data = 4'b0011;
    #10 data = 4'b0111;
    #10 data = 4'b1000;
    #10 data = 4'b1001;
    #10 data = 4'b1010;
    #10 data = 4'b1011;
    #10 data = 4'b1111;

end

endmodule






