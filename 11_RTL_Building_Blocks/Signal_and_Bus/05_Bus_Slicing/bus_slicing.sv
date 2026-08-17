module bus_slicing (
    input logic [15:0] data,
    output logic [3:0] field_0,
    output logic [3:0] field_1,
    output logic [3:0] field_2,
    output logic [3:0] field_3
);

assign field_0 = data[3:0];
assign field_1 = data[7:4];
assign field_2 = data[11:8];
assign field_3 = data[15:12];

endmodule
