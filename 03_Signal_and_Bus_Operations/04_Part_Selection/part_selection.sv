module part_selection(
    input logic [15:0] data,
    output logic [7:0] upper,
    output logic [7:0] lower,
    output logic [3:0] middle,
    output logic [3:0] nibble
);

assign upper = data [7:0];
assign lower = data [15:8];
assign middle = data [11:8];
assign nibble = data [3:0];

endmodule