module ARITHMETIC_UNIT #(parameter width = 16 , Arith_width = width + width )(
input wire signed [width-1:0] A,
input wire signed [width-1:0] B, 
input wire [1:0] ALU_FUN,
input wire Arith_Enable,
input wire CLK,
input wire RST,

output reg signed [Arith_width-1:0] Arith_OUT,
output reg        Carry_OUT,
output reg        Arith_Flag
);

reg [Arith_width-1:0] Arith_OUT0;
reg                   Carry_OUT0;
reg                   Arith_Flag0;

always @(posedge CLK, negedge RST)
  begin 
    if(!RST)
	 begin
	    Arith_OUT <= 'b0;
		Carry_OUT <= 16'b0;
		Arith_Flag<= 1'b0;
	 end
	else
	 begin
	    Arith_OUT <= Arith_OUT0;
		Carry_OUT <= Carry_OUT0;
		Arith_Flag<= Arith_Flag0;
	 end
  end


always @(*)
  begin
     if(Arith_Enable)
	 begin
	     Arith_Flag0 = 1'b1;
	     case(ALU_FUN)
		     2'b00 : {Carry_OUT0,Arith_OUT0} = A+B;
			 2'b01 : {Carry_OUT0,Arith_OUT0} = A-B;
			 2'b10 : {Carry_OUT0,Arith_OUT0} = A*B;
			 2'b11 : {Carry_OUT0,Arith_OUT0} = A/B;
		  endcase
	 end
	 else
	   begin
	     Arith_OUT0  = 'b0;
		 Arith_Flag0 = 1'b0;
	   end
  end

endmodule