module concate_tb();
logic [3:0] a;
logic [3:0] b;
logic [7:0] y_ab;
logic [7:0] y_ba;
logic [1:0] y_selected;

concate uut(
    .a(a),
    .b(b),
    .y_ab(y_ab),
    .y_ba(y_ba),
    .y_selected(y_selected)
);

initial begin
    $monitor ("t=%0t | a=%b b=%b | y_ab=%b y_ba=%b y_selected=%b", $time, a, b, y_ab, y_ba, y_selected);
#10 a=4'b1010;
    b=4'b1100;

#10 a=4'b0000;    
    b=4'b1111;

#10 a=4'b1111;    
    b=4'b0000;

#10 a=4'b0011;    
    b=4'b1001;
end

endmodule

