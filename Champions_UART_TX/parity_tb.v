`timescale 1ns / 1ps

module parity_tb;
    reg rst;
    reg [7:0] data_in;
    reg [1:0] parity_type;
    wire parity_out;

    // Instantiate the DUT (Device Under Test)
    parity #(8) dut (
        .rst(rst),
        .data_in(data_in),
        .parity_type(parity_type),
        .parity_out(parity_out)
    );

    initial begin
        // Initialize inputs
        rst = 1;
        data_in = 8'b0;
        parity_type = 2'b00;

        // Apply reset
        #10 rst = 0;

        // Test cases
        parity_type = 2'b01; data_in = 8'b10101010; #10;
        parity_type = 2'b10; data_in = 8'b11110000; #10;
        parity_type = 2'b00; data_in = 8'b00001111; #10;
        parity_type = 2'b11; data_in = 8'b11001100; #10;

        $stop;
    end
endmodule