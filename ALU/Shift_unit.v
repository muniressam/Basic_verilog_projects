module SHIFT_UNIT #(parameter width = 16 , Shift_width = width)(
input wire  [width-1:0] A,
input wire  [width-1:0] B, 
input wire [1:0] ALU_FUN,
input wire Shift_Enable,
input wire CLK,
input wire RST,


output reg [Shift_width-1:0] Shift_OUT,
output reg         Shift_Flag
);

reg [Shift_width-1:0] Shift_OUT0;
reg                   Shift_Flag0 ;

always @(posedge CLK, negedge RST)
  begin
    if(!RST)
	 begin
	    Shift_OUT <= 'b0;
		Shift_Flag<= 1'b0;
	 end
	else
	 begin
	    Shift_OUT <= Shift_OUT0;
		Shift_Flag<= Shift_Flag0;
	 end
  end


always @(*)
  begin
     if(Shift_Enable)
	 begin
	     Shift_Flag0 = 1'b1;
	     case(ALU_FUN)
		     2'b00 : Shift_OUT0 = A>>1'b1;
			 2'b01 : Shift_OUT0 = A<<1'b1;
			 2'b10 : Shift_OUT0 = B>>1'b1;
			 2'b11 : Shift_OUT0 = B<<1'b1;
		  endcase
	 end
	 else
	   begin
	     Shift_OUT0  = 'b0;
		 Shift_Flag0 = 1'b0;
	   end
  end


endmodule