
module MUX (
 input wire [1:0] mux_sel,
 input wire       start_bit,
 input wire       stop_bit,
 input wire       ser_data,
 input wire       par_bit,
 input wire       CLK,
 input wire       RST,
 
 output reg      TX_OUT
 );
reg            MUX_OUT ;



always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    TX_OUT <= 'b0 ;
   end
  else
   begin
    TX_OUT <= MUX_OUT ;
   end 
 end  

always @(*)
  begin
    case (mux_sel)
		     2'b00 : MUX_OUT = start_bit;
			 2'b01 : MUX_OUT = ser_data;
			 2'b10 : MUX_OUT = par_bit;
			 2'b11 : MUX_OUT = stop_bit;
		 endcase
  end
  
 
   
endmodule