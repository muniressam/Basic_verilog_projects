module FIFO_WR  #(parameter p_width = 4)
(
input wire               winc    ,
input wire               wclk    ,
input wire               wrst_n  ,
input wire [p_width-1:0] wq2_rptr,

output reg [p_width-1:0] wptr  ,
output reg [p_width-1:0] waddr ,
output reg               wfull 
);

reg [p_width-1:0] gray_wptr ;
reg [p_width-1:0] counter;
reg is_full ;
integer i;
		
always @(posedge wclk or negedge wrst_n)
 begin
     if(!wrst_n) begin
	    waddr <= 'b0 ;
		 wfull <= 'b0 ;
		 wptr  <= 'b0 ;
		 
		 //is_full<= 'b0;
		 counter<= 'b0;
	 end else if (winc && !is_full) begin
			  waddr <= waddr + 1;
			  counter <= counter +1 ;
		 end
		 
	     wfull <= is_full;
		 wptr  <= gray_wptr;
 end 
 
 //convert from binary to gray 
 always @(*) 
 begin
	  
	  for (i = 0; i < p_width-1 ; i = i + 1) begin
         gray_wptr[i] = counter[i] ^ counter[i+1];	
	  end
  
   gray_wptr[p_width-1] = counter[p_width-1];
     
 end
 
// to check the full flag 
always @(*) 
 begin
     if(gray_wptr[p_width-1]!= wq2_rptr[p_width-1] &&
     	 gray_wptr[p_width-2]!= wq2_rptr[p_width-2] && 
		  gray_wptr[p_width-3:0]== wq2_rptr[p_width-3:0])
      begin
	     is_full = 1'b1 ; 
	  end else begin
	     is_full = 1'b0 ;
	  end
	  
 end
 

endmodule



