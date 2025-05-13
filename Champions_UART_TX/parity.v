module parity #(parameter integer width = 8)(
  input  wire             rst,
  input  wire [width-1:0] data_in,
  input  wire [1:0]       parity_type,
  output reg              parity_out
);

always @(*) begin  
  if (rst)
    parity_out = 1'b0;
  else begin
    case (parity_type)
      2'b00   : parity_out =  1'b0;        // No parity
      2'b01   : parity_out = ~(^data_in);  // Odd parity
      2'b10   : parity_out =  (^data_in);  // Even parity
      2'b11   : parity_out = ~(^data_in);  // Odd parity without using it in the serial frame
      default : parity_out =  1'b0;
    endcase
  end
end

endmodule