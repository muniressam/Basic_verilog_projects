module stop_check (
input wire stp_chk_en,
input wire sampled_bit,
input wire clk,
input wire rst,

output reg stp_err

);
 always @(posedge clk or negedge rst)
begin
 if(!rst) begin
  stp_err <= 1'b0;
 end else begin
 
     if(stp_chk_en == 1) begin
       stp_err <= (sampled_bit== 1) ? 1'b0 : 1'b1; 
     end else begin
       stp_err <= 1'b0;
     end	
	 
 end	 
end
endmodule