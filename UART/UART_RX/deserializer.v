module deserializer #(parameter width = 8) (
input wire deser_en,
input wire sampled_bit,
input wire clk,
input wire rst,
input wire [5:0]    edge_cnt, 
input wire [5:0]    PRESCALE, 
output reg [width - 1 : 0] P_DATA

);
reg [width - 1 : 0] shift_reg;

always @(posedge clk or negedge rst)
begin
 if(!rst) begin
  shift_reg <= 'b0;
  P_DATA    <= 'b0;
 end else if (deser_en && (edge_cnt == PRESCALE - 6'b1)) begin 
   // shift_reg [width-1] <= sampled_bit ;
	// shift_reg <= shift_reg >> 1 ;
	shift_reg <={sampled_bit , shift_reg[width-1:1]} ;
   end else begin
   P_DATA <= shift_reg;
   end 

 
end
endmodule