module bus_combiner_tb();
logic [3:0] upper;
logic [3:0] lower;
logic [7:0] data;

bus_combiner uut(
    .upper(upper),
    .lower(lower),
    .data(data)
);

initial begin
    $monitor("t=%0t | upper=%t lower=%t | data=%t", $time, upper, lower, data);

#10 upper = 4'b0000;
    lower = 4'b0000;

#10upper = 4'b1111; 
    lower = 4'b1111;

#10 upper = 4'b1010; 
    lower = 4'b1010;

#10upper = 4'b0101; 
    lower = 4'b0101;

#10 upper = 4'b1100; 
    lower = 4'b1100;

#10 upper = 4'b0011; 
    lower = 4'b0011;

#10 upper = 4'b1011; 
    lower = 4'b0110;
end

endmodule

