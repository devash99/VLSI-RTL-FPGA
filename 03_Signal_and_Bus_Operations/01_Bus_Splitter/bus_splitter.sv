module bus_splitter(
    input logic [7:0] A,
    output logic [3:0] lower,
    output logic [3:0] upper
);

assign upper = A[7:4];
assign lower = A[3:0];

endmodule

