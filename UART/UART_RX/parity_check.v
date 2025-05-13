module parity_check (
input wire PAR_TYP,
input wire par_chk_en,
input wire sampled_bit,
input wire clk,
input wire rst,

output reg par_err

);

always @(posedge clk or negedge rst)
begin
 if(!rst) begin
  par_err <= 1'b0;
 end else begin
 
     if(par_chk_en == 1) begin
       par_err <= (PAR_TYP == sampled_bit) ? 1'b0 : 1'b1; 
     end else begin
       par_err <= 1'b0;
     end	
	 
 end   
end
endmodule

