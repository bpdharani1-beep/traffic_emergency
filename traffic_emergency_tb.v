module testbench;

reg clk, reset;
reg emergency_north, emergency_south, emergency_east, emergency_west;

wire [3:0] light;

traffic_emergency uut(
    clk, reset,
    emergency_north,
    emergency_south,
    emergency_east,
    emergency_west,
    light
);

// clock
always #5 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;

    emergency_north = 0;
    emergency_south = 0;
    emergency_east  = 0;
    emergency_west  = 0;

    #10 reset = 0;

    // ? Emergency test cases
    #20 emergency_east = 1;
    #20 emergency_east = 0;

    #40 emergency_north = 1;
    #20 emergency_north = 0;

    #100 $finish;
end

endmodule