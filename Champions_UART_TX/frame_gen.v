module frame_gen (
    input  wire        rst,
    input  wire [7:0]  data_in,
    input  wire        parity_out,
    input  wire [1:0]  parity_type,
    input  wire        stop_bits,
    input  wire        data_length,
  
    output reg [10:0]  frame_out
);

reg [7:0] data;
reg parity;


always @(*) begin
 if (rst) begin
   frame_out = 11'd0;
 end
 else begin
 data = (data_length) ? data_in [7:0] : data_in [6:0];
 parity = (parity_type== 2'b11) ? 1'b0        : parity_out; 
 
 frame_out = (stop_bits && !data_length)? {1'b0, data , parity , 1'b1, 1'b1 } : {1'b0, data , parity , 1'b1 };
  // Because length of fram 11 bit , there will be conflect in state when data_length = 1 and stop_bits =1 
 
 end  
 end
endmodule

