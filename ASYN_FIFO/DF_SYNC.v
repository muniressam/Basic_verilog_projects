module DF_SYNC #(parameter p_width = 4)
(
input wire [p_width-1:0] ptr ,
input wire clk ,
input wire rst ,

output reg [p_width-1:0] sync_out
);

reg [p_width-1:0] sync_out1;

always @(posedge clk or negedge rst) 
 begin 
     if(!rst) begin
         sync_out1 <= 'b0;
		 sync_out  <= 'b0;
     end else begin
	     sync_out1 <= ptr ;
         sync_out  <= sync_out1 ;
     end	 
 end
 
endmodule


