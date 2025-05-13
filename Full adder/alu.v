module ALU #(parameter width = 8 )(
input wire [width - 1:0]  A,
input wire [width - 1:0]  B,
input wire [2:0]          opcode,

output reg [width - 1 :0] ALU_OUT,
output reg                Cout,
output reg                C_Flag
);
 
wire [width - 1 :0] OUT_SUM;
wire [width - 1 :0] OUT_SUB;
wire carry_out;

Full_Adder_Sub #(.width(width)) u_add(.A(A),
	                                  .B(B),
	                                  .Cin(1'b0),
	                                  .Sum(OUT_SUM),
	                                  .Cout(carry_out)) ; 
												 
Full_Adder_Sub #(.width(width)) u_sub(.A(A),
	                                  .B(B),
	                                  .Cin(1'b1),
	                                  .Sum(OUT_SUB),
	                                  .Cout(carry_out)) ;

always @(*)
 begin											   
  case (opcode)
    3'b000 :begin	         
	         ALU_OUT = OUT_SUM ;
             Cout = carry_out;			 
			end
			
    3'b001 : begin
	         ALU_OUT = OUT_SUB ;
			 Cout = carry_out;
	         end
			 
    3'b010 : ALU_OUT = A&B ;
    3'b011 : ALU_OUT = A|B ;
    3'b100 : ALU_OUT = A^B ;
	
	3'b101 : begin
            	ALU_OUT = 8'b0 ;
				if(A>B)
				C_Flag = 1'b1;
				else
				C_Flag = 1'b0;
			 end	
			 
	3'b110 : ALU_OUT = A<<1;	
	3'b111 : ALU_OUT = B<<1;
 
      default begin
	  ALU_OUT = 8'b0 ; 
	  C_Flag = 1'b0 ;
	  
	  end
  endcase
end
endmodule
