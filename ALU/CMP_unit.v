module CMP_UNIT #(parameter width = 16 , CMP_width   = width )(
input wire  [width-1:0] A,
input wire  [width-1:0] B, 
input wire [1:0] ALU_FUN,
input wire CMP_Enable,
input wire CLK,
input wire RST,

 
output reg [CMP_width-1:0] CMP_OUT,
output reg         CMP_Flag
);

reg [CMP_width-1:0] CMP_OUT0;
reg                 CMP_Flag0 ;
reg [CMP_width-1:0] EQ ;
reg [CMP_width-1:0] GR ; 
reg [CMP_width-1:0] LW;

always @(posedge CLK , negedge RST)
  begin
    if(!RST)
	 begin
	    CMP_OUT <= 'b0;
		CMP_Flag<= 1'b0;
	 end
	else
	 begin
	    CMP_OUT <= CMP_OUT0;
		CMP_Flag<= CMP_Flag0;
	 end
  end


always @(*)
  begin
     if(A==B)
       EQ ='b1;
     else 
       EQ ='b0;
       
     if(A>B)
       GR ='b10;
     else 
       GR ='b0;
       
     if(A<B)
       LW ='b11;
     else 
       LW ='b0;
    
	 
     if(CMP_Enable)
	   begin
	     CMP_Flag0 = 1'b1;
	     case(ALU_FUN)
		     2'b00 : CMP_OUT0 = 'b0;
			 2'b01 : CMP_OUT0 = EQ;
			 2'b10 : CMP_OUT0 = GR;
			 2'b11 : CMP_OUT0 = LW;
		  endcase
	   end
	 else
	   begin
	     CMP_OUT0  = 'b0;
		 CMP_Flag0 = 1'b0;
	   end
  end

endmodule