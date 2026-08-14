module sign_extension(
    input logic [3:0] data,
    output logic [7:0] extended
);

assign extended = {{4{data[3]}}, data};

endmodule