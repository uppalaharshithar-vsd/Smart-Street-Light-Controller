module smart_street_light (
    input wire clk,
    input wire reset,
    input wire night,
    input wire vehicle,
    output reg [1:0] light_mode
);

    parameter DAY = 2'b00;
    parameter NIGHT = 2'b01;
    parameter BRIGHT = 2'b10;

    reg [1:0] current_state;
    reg [1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= DAY;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            DAY: begin
                if (night)
                    next_state = NIGHT;
                else
                    next_state = DAY;
            end

            NIGHT: begin
                if (!night)
                    next_state = DAY;
                else if (vehicle)
                    next_state = BRIGHT;
                else
                    next_state = NIGHT;
            end

            BRIGHT: begin
                if (!night)
                    next_state = DAY;
                else if (!vehicle)
                    next_state = NIGHT;
                else
                    next_state = BRIGHT;
            end

            default: next_state = DAY;
        endcase
    end

    always @(*) begin
        case (current_state)
            DAY:    light_mode = 2'b00;
            NIGHT:  light_mode = 2'b01;
            BRIGHT: light_mode = 2'b10;
            default: light_mode = 2'b00;
        endcase
    end

endmodule
