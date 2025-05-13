module Auto_Door(
  input wire UP_Max,
  input wire DN_Max,
  input wire Activate,
  input wire CLK,
  input wire RST,
  
  output reg UP_M,
  output reg DN_M
  
);
  localparam  IDEAL = 2'b00,
              MV_UP = 2'b01,
			  MV_DN = 2'b10;
			  
			  
  reg [1:0] current_state, next_state;

always @(posedge CLK or negedge RST)
  begin
    if(!RST)
	  begin
	   current_state <= IDEAL;
	  end
    else
	  begin
	   current_state <= next_state;
	  end
  end
   
always @(*)
  begin
    case(current_state)
	  IDEAL : begin
	           
			    if(Activate && UP_Max && !DN_Max )
			     begin
				    next_state = MV_DN;
				 end
			    else if(Activate && DN_Max && !UP_Max)
				 begin
				    next_state = MV_UP;
				 end
				else 
				 begin
				    next_state = IDEAL;
				 end
				
		      end
			  
	  MV_UP : begin
               
			    if(UP_Max)
				 begin
				    next_state = IDEAL;
				 end
				else
				 begin
				    next_state = MV_UP;
				 end
              end
			  
	  MV_DN : begin
               
			    if(DN_Max)
				 begin
				    next_state = IDEAL;
				 end
				else
				 begin
				    next_state = MV_DN;
				 end
              end
    default : begin
                    next_state = IDEAL;
	          end
    endcase
  end
always @(*)
 begin
  case(current_state)
  IDEAL     : begin
              UP_M = 1'b0;
			  DN_M = 1'b0;		  
             end
  MV_UP    : begin
              UP_M = 1'b1;
			  DN_M = 1'b0;
             end	
  MV_DN    : begin
              DN_M = 1'b1;
              UP_M = 1'b0;		  
             end
  	
  default  : begin
              UP_M = 1'b0;
			  DN_M = 1'b0;
             end			  
  endcase
  end
  
 
endmodule