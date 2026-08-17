module replication_tb();

logic [1:0] a;

logic [3:0] y_2x;
logic [7:0] y_4x;
logic [3:0] y_zeros;
logic [3:0] y_ones;


replication uut(
    .a(a),
    .y_2x(y_2x),
    .y_4x(y_4x),
    .y_zeros(y_zeros),
    .y_ones(y_ones)
);


initial begin

    $monitor("time=%0t | a=%b | y_2x=%b y_4x=%b y_zeros=%b y_ones=%b",
             $time, a, y_2x, y_4x, y_zeros, y_ones);

    #10 a = 2'b00;
    #10 a = 2'b01;
    #10 a = 2'b10;
    #10 a = 2'b11;

end

endmodule