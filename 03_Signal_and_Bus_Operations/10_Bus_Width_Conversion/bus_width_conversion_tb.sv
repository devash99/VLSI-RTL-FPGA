module bus_width_conversion_tb();

logic [3:0] narrow_data;
logic [7:0] wide_data;

logic [7:0] zero_extended;
logic [7:0] sign_extended;
logic [3:0] lower_nibble;
logic [3:0] upper_nibble;

bus_width_conversion uut(
    .narrow_data(narrow_data),
    .wide_data(wide_data),
    .zero_extended(zero_extended),
    .sign_extended(sign_extended),
    .lower_nibble(lower_nibble),
    .upper_nibble(upper_nibble)
);

initial begin

    $monitor(
        "t=%0t | narrow=%b | zero_ext=%b sign_ext=%b | wide=%b | upper=%b lower=%b",
        $time,
        narrow_data,
        zero_extended,
        sign_extended,
        wide_data,
        upper_nibble,
        lower_nibble
    );

    // Narrow → Wide
    #10 narrow_data = 4'b0000;
        wide_data   = 8'b00000000;

    #10 narrow_data = 4'b0001;
        wide_data   = 8'b11111111;

    #10 narrow_data = 4'b0011;
        wide_data   = 8'b10101010;

    #10 narrow_data = 4'b0111;
        wide_data   = 8'b01010101;

    #10 narrow_data = 4'b1000;
        wide_data   = 8'b11001100;

    #10 narrow_data = 4'b1001;
        wide_data   = 8'b00110011;

    #10 narrow_data = 4'b1010;
        wide_data   = 8'b10110110;

    #10 narrow_data = 4'b1011;
        wide_data   = 8'b11001010;

    #10 narrow_data = 4'b1111;
        wide_data   = 8'b11110000;

end

endmodule
