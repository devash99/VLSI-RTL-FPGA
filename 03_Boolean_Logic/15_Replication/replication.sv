module replication(
    input logic [1:0] a,
    output logic [3:0] y_2x,
    output logic [7:0] y_4x,
    output logic [3:0] y_zeros,
    output logic [3:0] y_ones
);

assign y_2x = {2{a}};
assign y_4x = {4{a}};
assign y_zeros = {4{1'b0}};
assign y_ones = {4{1'b1}};

endmodule 