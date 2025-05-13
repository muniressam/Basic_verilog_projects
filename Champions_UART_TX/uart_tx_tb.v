`timescale 1ns / 1ps

module uart_tx_tb;

  // Inputs
  reg clock;
  reg rst;
  reg send;
  reg [1:0] baud_rate;
  reg [7:0] data_in;
  reg [1:0] parity_type;
  reg stop_bits;
  reg data_length;

  // Outputs
  wire data_out;
  wire p_parity_out;
  wire tx_active;
  wire tx_done;

  // Instantiate the Unit Under Test (UUT)
  uart_tx uut (
    .clock(clock),
    .rst(rst),
    .send(send),
    .baud_rate(baud_rate),
    .data_in(data_in),
    .parity_type(parity_type),
    .stop_bits(stop_bits),
    .data_length(data_length),
    .data_out(data_out),
    .p_parity_out(p_parity_out),
    .tx_active(tx_active),
    .tx_done(tx_done)
  );

  // 50MHz clock
  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock; 
  end
  
  // Resetting the system
  initial begin
    rst = 1'b1;
    send = 1'b0;
    stop_bits = 0;
    data_length = 0;
    #100;
    rst = 1'b0;
    send = 1'b1;
  end
  
  // Varying the Baud Rate and the Parity Type
  initial begin
    // Test with different configurations
    test_uart_tx(8'b10101010, 2'b10, 2'b01, 0, 1);
    test_uart_tx(8'b10101010, 2'b10, 2'b01, 1, 1);
    test_uart_tx(8'b10101010, 2'b10, 2'b01, 1, 0);
    test_uart_tx(8'b10101010, 2'b10, 2'b01, 0, 0);
    test_uart_tx(8'b10101010, 2'b11, 2'b10, 0, 1);
    test_uart_tx(8'b10101010, 2'b11, 2'b10, 1, 1);
    test_uart_tx(8'b10101010, 2'b11, 2'b10, 1, 0);
    test_uart_tx(8'b10101010, 2'b11, 2'b10, 0, 0);
  end

  // Task to test UART transmitter with different configurations
  task test_uart_tx(
    input [7:0] data,
    input [1:0] baud,
    input [1:0] parity,
    input stop,
    input length
  );
  begin
    data_in = data;
    baud_rate = baud;
    parity_type = parity;
    stop_bits = stop;
    data_length = length;
    #100;  // Waits for the whole frame to be sent
  end
  endtask
  
  // Stop simulation
  initial begin
    #2600000 $stop;  // Simulation for 2.6 ms
  end

endmodule