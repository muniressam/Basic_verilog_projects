module edge_bit_counter (
 input wire enable_count,
 input wire clk,
 input wire rst,
 input wire [5:0] PRESCALE,
 
 output reg [5:0] edge_cnt,
 output reg [3:0] bit_cnt
 

);
//reg [7:0] count;

always @(posedge clk or negedge rst) 
begin
 if(!rst) begin
     bit_cnt  <= 'b0;
	 edge_cnt <= 'b0;
	// count    <= 'b0;
 end else begin
     if(enable_count) begin
	    //edge_cnt <= count ;
		 if(edge_cnt == PRESCALE - 6'b1) begin
		  bit_cnt <= bit_cnt +1 ;
		  edge_cnt   <= 'b0;
		 end else begin
		  edge_cnt <= edge_cnt +1;
		 end		
	 end
	 
	 else begin
	     bit_cnt  <= 'b0;
	     edge_cnt <= 'b0;
	     //count    <= 'b0; 
	 end
 end
end
endmodule