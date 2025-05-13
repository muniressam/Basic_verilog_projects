`timescale 1ns / 1ps

module baudGen_tb;
    reg clock, rst;
    reg [1:0] baud_rate;
    wire baud_out;

    // Instantiate the DUT (Device Under Test)
    baudGen #(50000000) dut (
        .clock(clock),
        .rst(rst),
        .baud_rate(baud_rate),
        .baud_out(baud_out)
    );

    initial begin
        // Initialize inputs
        clock = 0;
        rst = 1;
        baud_rate = 2'b00;

        // Apply reset
        #10 rst = 0;

        // Test cases
        #20 baud_rate = 2'b00; // 2400 baud
        #1000 baud_rate = 2'b01; // 4800 baud
        #1000 baud_rate = 2'b10; // 9600 baud
        #1000 baud_rate = 2'b11; // 19200 baud

        $stop;
    end

    // Clock generation
    always #5 clock = ~clock;
endmodule