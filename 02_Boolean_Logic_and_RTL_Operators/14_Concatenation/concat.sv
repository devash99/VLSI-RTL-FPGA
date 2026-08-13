module concate(
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [7:0] y_ab,
    output logic [7:0] y_ba,
    output logic [1:0] y_selected
);

assign y_ab = {a,b};
assign y_ba = {b,a};
assign y_selected = {a[0],b[3]};

endmodule

