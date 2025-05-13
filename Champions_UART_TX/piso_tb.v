`timescale 1ns / 1ps

module piso_tb;
    reg rst;
    reg [10:0] frame_out;
    reg [1:0] parity_type;
    reg stop_bits;
    reg data_length;
    reg send;
    reg baud_out;

    wire data_out;
    wire p_parity_out;
    wire tx_active;
    wire tx_done;

    // Instantiate the DUT (Device Under Test)
    piso dut (
        .rst(rst),
        .frame_out(frame_out),
        .parity_type(parity_type),
        .stop_bits(stop_bits),
        .data_length(data_length),
        .send(send),
        .baud_out(baud_out),
        .data_out(data_out),
        .p_parity_out(p_parity_out),
        .tx_active(tx_active),
        .tx_done(tx_done)
    );

    initial begin
        // Initialize inputs
        rst = 1;
        frame_out = 11'b0;
        parity_type = 2'b00;
        stop_bits = 1;
        data_length = 1;
        send = 0;
        baud_out = 0;

        // Apply reset
        #10 rst = 0;

        // Test case 1: Send a frame
        frame_out = 11'b10101010101;
        send = 1;
        #20 send = 0;

        // Toggle baud_out to simulate baud clock
        repeat (20) begin
            #10 baud_out = ~baud_out;
        end

        // Test case 2: Another frame
        frame_out = 11'b01010101010;
        send = 1;
        #20 send = 0;

        // Toggle baud_out to simulate baud clock
        repeat (20) begin
            #10 baud_out = ~baud_out;
        end

        $stop;
    end
endmodule