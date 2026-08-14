module zero_extension(
    input logic [3:0] data,
    output logic [7:0] extended
);

assign extended = {4'b0000, data};

endmodule