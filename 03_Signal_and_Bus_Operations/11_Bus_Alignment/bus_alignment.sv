module bus_alignment(
    input logic [3:0] data,
    output logic [7:0] right_aligned,
    output logic [7:0] left_aligned
);

assign right_aligned = {4'b0000, data};
assign left_aligned = {data, 4'b0000};

endmodule
