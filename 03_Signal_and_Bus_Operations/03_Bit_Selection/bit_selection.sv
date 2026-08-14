module bit_selection(
    input logic [7:0] data,
    output logic bit_7,
    output logic bit_6,
    output logic bit_5,
    output logic bit_4,
    output logic bit_3,
    output logic bit_2,
    output logic bit_1,
    output logic bit_0
);

assign bit_7 = data[7];
assign bit_6 = data[6];
assign bit_5 = data[5];
assign bit_4 = data[4];
assign bit_3 = data[3];
assign bit_2 = data[2];
assign bit_1 = data[1];
assign bit_0 = data[0];
endmodule

