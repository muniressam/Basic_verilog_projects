module data_sampling (
 input wire RX_IN,
 input wire dat_samp_en,
 input wire [5:0] edge_cnt,
 input wire [5:0] PRESCALE,
 input wire clk,
 input wire rst,
 
 output reg sampled_bit
);
reg samp_1;
reg samp_2;
reg samp_3;

always @(posedge clk or negedge rst) 
begin
 if(!rst) begin
     samp_1 <= 1'b0;
	    samp_2 <= 1'b0;
		 samp_3 <= 1'b0;
 end else begin
      if(dat_samp_en) begin
	  
	     if(edge_cnt== PRESCALE/2 -1)
            samp_1 <= RX_IN;
		 else if(edge_cnt== PRESCALE/2 )
            samp_2 <= RX_IN;
		 else if(edge_cnt== PRESCALE/2 +1)
            samp_3 <= RX_IN;
		  
      end else begin
	   samp_1 <= 1'b0;
	    samp_2 <= 1'b0;
		 samp_3 <= 1'b0;
	  end
    end
end


always @ (posedge clk or negedge rst)
begin
if(!rst) begin
     sampled_bit = 1'b0;
 end else begin
    if(dat_samp_en) begin
         if(samp_1==samp_2)
		   sampled_bit <= samp_1;
		 else if(samp_2==samp_3)
		   sampled_bit <= samp_2;
		 else
		   sampled_bit <= samp_3; 
    end else begin 
	 sampled_bit <= 1'b0;
	end
end
end
endmodule