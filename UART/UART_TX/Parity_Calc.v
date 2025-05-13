module Parity_Calc #(parameter P_Width = 8)(
 input wire [P_Width - 1 : 0]  P_DATA,
 input wire                    DATA_VALID,
 input wire                    PAR_TYP,
 input wire                    PAR_EN,
 input wire                    CLK,
 input wire                    RST,
 input wire                    Busy,

 output reg                    par_bit
);

reg [P_Width - 1 : 0] DATA;


always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    DATA <= 'b0 ;
   end
  else if(DATA_VALID && !Busy )
   begin
    DATA <= P_DATA ;
   end 
 end
 
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
    begin
     par_bit <= 'b0 ;
    end
  else 
    begin
           if(PAR_EN) 
		     begin
		      case(PAR_TYP)
                 1'b0 : par_bit <= ~^DATA; //odd
				 1'b1 : par_bit <= ^DATA; //even
              endcase
		     end
		
    end 
 end
 
endmodule
  
  
  