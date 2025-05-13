module LOGIC_UNIT #(parameter width = 16 , Logic_width = width)(
input wire  [width-1:0] A,
input wire  [width-1:0] B, 
input wire [1:0] ALU_FUN,
input wire Logic_Enable,
input wire CLK,
input wire RST,


output reg [Logic_width-1:0] Logic_OUT,
output reg         Logic_Flag
);

reg [Logic_width-1:0] Logic_OUT0; 
reg                   Logic_Flag0 ;

always @(posedge CLK, negedge RST)
  begin
    if(!RST)
	 begin
	    Logic_OUT <= 'b0;
		Logic_Flag<= 1'b0;
	 end
	else
	 begin
	  Logic_OUT <= Logic_OUT0;
		Logic_Flag<= Logic_Flag0;
	 end
  end


always @(*)
  begin
     if(Logic_Enable)
	 begin
	     Logic_Flag0 = 1'b1;
	     case(ALU_FUN)
		   2'b00 : Logic_OUT0 = A&B;
			 2'b01 : Logic_OUT0 = A|B;
			 2'b10 : Logic_OUT0 = ~(A&B);
			 2'b11 : Logic_OUT0 = ~(A|B);
		  endcase
	 end
	 else
	   begin
	     Logic_OUT0  = 'b0;
		 Logic_Flag0 = 1'b0;
	   end
  end

endmodule