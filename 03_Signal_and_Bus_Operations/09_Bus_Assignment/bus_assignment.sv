module bus_assignment(
    input logic [7:0] data,
    output logic [7:0] result,
    output logic [7:0] result_inverted
);

assign result = data;
assign result_inverted = ~data;

endmodule

