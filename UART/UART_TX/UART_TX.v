module UART_TX #(parameter width = 8) (
 input wire [width - 1 : 0] P_DATA_TX,
 input wire                   DATA_VALID_TX,
 input wire                   PAR_EN,
 input wire                   PAR_TYP,
 input wire                   CLK_TX,
 input wire                   RST_TX,
 
 output wire                  TX_OUT,
 output wire                  Busy

);
 wire ser_done , ser_en , ser_data;
 wire [1:0] mux_sel ;
 wire par_bit ;



  Serializer #(.P_Width(width)) u_seralizer (
  
     .P_DATA(P_DATA_TX),
	 .DATA_VALID(DATA_VALID_TX),
	 .ser_en(ser_en),
	 .ser_done(ser_done),
	 .ser_data(ser_data),
	 .Busy(Busy),
	 .CLK(CLK_TX),
     .RST(RST_TX)
	 
	);
   
   FSM u_fsm (
   
     .DATA_VALID(DATA_VALID_TX),
	 .PAR_EN(PAR_EN),
	 .ser_done(ser_done),
	 .ser_en(ser_en),
	 .mux_sel(mux_sel),
	 .Busy(Busy),
	 .CLK(CLK_TX),
     .RST(RST_TX)
	 
   );
   
   Parity_Calc #(.P_Width(width)) u_parity_cal(
   
     .P_DATA(P_DATA_TX),
	 .DATA_VALID(DATA_VALID_TX),
	 .PAR_TYP(PAR_TYP),
	 .PAR_EN(PAR_EN),
	 .Busy(Busy),
     .par_bit(par_bit),
	 .CLK(CLK_TX),
     .RST(RST_TX)
   
   );
   
   MUX u_mux (
     
	 .mux_sel(mux_sel),
	 .start_bit(1'b0),
	 .ser_data(ser_data),
	 .par_bit(par_bit),
	 .stop_bit(1'b1),
	 .TX_OUT(TX_OUT),
	 .CLK(CLK_TX),
     .RST(RST_TX)
	 
   
   );
   
   
   
endmodule
   