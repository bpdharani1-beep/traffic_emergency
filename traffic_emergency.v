module traffic_emergency(
    input clk,
    input reset,

    input emergency_north,
    input emergency_south,
    input emergency_east,
    input emergency_west,

    output reg [3:0] light  // N S E W
);

reg [1:0] state;

parameter NORTH = 2'b00;
parameter SOUTH = 2'b01;
parameter EAST  = 2'b10;
parameter WEST  = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= NORTH;
        light <= 4'b1000;
    end
    else begin

        // ? EMERGENCY PRIORITY (highest priority)
        if (emergency_north) begin
            state <= NORTH;
            light <= 4'b1000;
        end
        else if (emergency_south) begin
            state <= SOUTH;
            light <= 4'b0100;
        end
        else if (emergency_east) begin
            state <= EAST;
            light <= 4'b0010;
        end
        else if (emergency_west) begin
            state <= WEST;
            light <= 4'b0001;
        end

        // ? NORMAL FSM TRAFFIC CYCLE
        else begin
            case(state)

                NORTH: begin
                    light <= 4'b1000;
                    state <= SOUTH;
                end

                SOUTH: begin
                    light <= 4'b0100;
                    state <= EAST;
                end

                EAST: begin
                    light <= 4'b0010;
                    state <= WEST;
                end

                WEST: begin
                    light <= 4'b0001;
                    state <= NORTH;
                end

            endcase
        end
    end
end

endmodule