module uart_tx(
	//DO NOT EDIT any part of this port declaration
	input 		clock, rst, send,
	input [1:0]	baud_rate,
	input [7:0] data_in, 
	input [1:0] parity_type, 	//refer to the block comment above. 
	input 		stop_bits, 		//low when using 1 stop bit, high when using two stop bits
	input 		data_length, 	//low when using 7 data bits, high when using 8.
	
	output  	data_out, 		//Serial data_out
	output  	p_parity_out, 	//parallel odd parity output, low when using the frame parity.
	output  	tx_active, 		//high when Tx is transmitting, low when idle.
	output  	tx_done 		//high when transmission is done, low when not.
);

	//You MAY EDIT these signals, or module instantiations.
	wire parity_out, baud_out;
	wire [10:0] frame_out;
	
	//sub_modules
	parity		parity_gen1 (rst, data_in, parity_type, parity_out);
	frame_gen	frame_gen1  (rst, data_in, parity_out, parity_type, stop_bits, data_length, frame_out);
	baud_gen	baud_gen1	(rst, clock, baud_rate, baud_out);
	piso		shift_reg1	(rst, frame_out, parity_type, stop_bits, data_length, send, baud_out, data_out, p_parity_out, tx_active, tx_done);

endmodule