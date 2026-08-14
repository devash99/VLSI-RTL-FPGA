module bus_width_conversion(
    input logic [3:0] narrow_data,
    input logic [7:0] wide_data,

    output logic [7:0] zero_extended,
    output logic [7:0] sign_extended,
    output logic [3:0] lower_nibble,
    output logic [3:0] upper_nibble
);

assign zero_extended = {4'b0000, narrow_data};
assign sign_extended = {{4{narrow_data[3]}}, narrow_data};

assign lower_nibble = wide_data[3:0];
assign upper_nibble = wide_data[7:4];

endmodule