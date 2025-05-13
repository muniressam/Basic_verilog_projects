`timescale 1ns / 1ps

module frame_gen_tb;
    reg rst;
    reg [7:0] data_in;
    reg parity_out;
    reg [1:0] parity_type;
    reg stop_bits;
    reg data_length;
    reg send;
    wire [10:0] frame_out;

    // Instantiate the DUT (Device Under Test)
    frame_gen dut (
        .rst(rst),
        .data_in(data_in),
        .parity_out(parity_out),
        .parity_type(parity_type),
        .stop_bits(stop_bits),
        .data_length(data_length),
        .send(send),
        .frame_out(frame_out)
    );

    initial begin
        // Initialize inputs
        rst = 1;
        data_in = 8'b0;
        parity_out = 0;
        parity_type = 2'b00;
        stop_bits = 1;
        data_length = 1;
        send = 0;

        // Apply reset
        #10 rst = 0;

        // Test case 1
        data_in = 8'b10101010;
        parity_out = 1;
        parity_type = 2'b01;
        send = 1;
        #20 send = 0;

        // Test case 2
        data_in = 8'b11001100;
        parity_out = 0;
        parity_type = 2'b10;
        send = 1;
        #20 send = 0;

        $stop;
    end
endmodule