`timescale 1ns/1ps

module tb_smart_street_light;

    reg clk;
    reg reset;
    reg night;
    reg vehicle;
    wire [1:0] light_mode;

    smart_street_light uut (
        .clk(clk),
        .reset(reset),
        .night(night),
        .vehicle(vehicle),
        .light_mode(light_mode)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waveforms/smart_street_light.vcd");
        $dumpvars(0, tb_smart_street_light);

        $monitor("Time=%0t reset=%b night=%b vehicle=%b light_mode=%b",
                 $time, reset, night, vehicle, light_mode);

        clk = 0;
        reset = 1;
        night = 0;
        vehicle = 0;

        #12 reset = 0;
        #10 night = 1;
        #20 vehicle = 1;
        #20 vehicle = 0;
        #20 night = 0;
        #10 $finish;
    end

endmodule
