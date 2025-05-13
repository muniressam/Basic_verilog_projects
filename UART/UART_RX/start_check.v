module start_check (
input wire strt_chk_en,
input wire sampled_bit,
input wire clk,
input wire rst,

output reg strt_glitch

);
always @(posedge clk or negedge rst)
begin
 if(!rst) begin
  strt_glitch <= 1'b0;
 end else begin
 
     if(strt_chk_en == 1) begin
       strt_glitch <= (sampled_bit== 0) ? 1'b0 : 1'b1; 
     end else begin
       strt_glitch <= 1'b0;
     end
 end	 
end
endmodule