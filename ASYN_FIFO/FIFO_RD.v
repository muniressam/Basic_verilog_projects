module FIFO_RD #(parameter p_width = 4)
(
input wire               rinc    ,
input wire               rclk    ,
input wire               rrst_n  ,
input wire [p_width-1:0] rq2_wptr,

output reg [p_width-1:0] rptr  ,
output reg [p_width-1:0] raddr ,
output reg               rempty 
);

reg [p_width-1:0] gray_rptr ;
reg [p_width-1:0] counter;
reg is_empty ;
integer i;
		
always @(posedge rclk or negedge rrst_n)
 begin
     if(!rrst_n) begin
	     raddr  <= 'b0 ;
		 rempty <= 'b0 ;
		 rptr   <= 'b0 ;
		 
		 //is_empty<= 'b0;
		 counter<= 'b0;
	end else if (rinc && !is_empty) begin
			  raddr <= raddr + 1;
			  counter <= counter +1 ;
		 end 
		 
	     rempty <= is_empty;
		 rptr   <= gray_rptr;
     
 end 
 
 //convert from binary to gray 
 always @(*) 
 begin
	  
	  for (i = 0; i < p_width-1 ; i = i + 1) begin
         gray_rptr[i] = counter[i] ^ counter[i+1];	
	  end
  
   gray_rptr[p_width-1] = counter[p_width-1];
     
 end
 
// to check the empty flag 
always @(*) 
 begin
     if(gray_rptr == rq2_wptr)
      begin
	     is_empty = 1'b1 ; 
	  end else begin
	     is_empty = 1'b0 ;
	  end
	  
 end
 

endmodule

