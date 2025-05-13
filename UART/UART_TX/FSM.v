
module FSM (
 input wire PAR_EN,
 input wire DATA_VALID,
 input wire ser_done,
 input wire CLK,
 input wire RST,
 
 output reg ser_en,
 output reg [1:0] mux_sel,
 output reg Busy
 
);
localparam IDLE        = 3'b000,
           START       = 3'b001,
		   DATA        = 3'b010,
		   PARTY       = 3'b011,
		   STOP        = 3'b100;
		   


reg [2:0] current_state , next_state;
reg Busy_TX;

always @(posedge CLK or negedge RST)
  begin
    if(!RST)
	  begin
	   current_state <= IDLE;
	   Busy <= 1'b0;
	  end
    else
	  begin
	   current_state <= next_state;
	   Busy <= Busy_TX;
	  end
  end
  
always @(*)
  begin
     case(current_state)
	    IDLE  : begin
		         if(DATA_VALID)
			       begin
				     next_state = START;
				   end
	             else	   
				   begin
				     next_state = IDLE;
				   end
			    end
			      
		START : begin
				  next_state = DATA;
                end	
        DATA  : begin
                 if(ser_done)
				   begin
				    if(PAR_EN)
					  begin
				        next_state = PARTY;
				      end
				    else
				      begin
				        next_state = STOP;
				      end
				   end
				 else
				   begin
				     next_state = DATA;
				   end
                end		
	    PARTY : begin
	            
				     next_state = STOP;
				 
	            end
		STOP  : begin
		         if(DATA_VALID)
				     next_state = START;
				  else
				     next_state = IDLE;
		        end  
		 default : begin
		 
                     next_state = IDLE;
					 
	               end	   
	  endcase
  end
  
always @(*)
  begin
                 Busy_TX = 1'b0;
				 ser_en  = 1'b0;
				 mux_sel = 2'b00;		
     case(current_state)
	    IDLE  : begin
                 Busy_TX = 1'b0;
				 ser_en  = 1'b0;
				 mux_sel = 2'b11;			 
                end
				
        START : begin
                 Busy_TX = 1'b1;
				 ser_en  = 1'b0;
				 mux_sel = 2'b00;				
                end
				
        DATA  : begin
                 Busy_TX = 1'b1;
				 ser_en  = 1'b1;
                 mux_sel = 1'b01; 
                if (ser_done) 
		         begin
                  ser_en = 1'b0;
                 end
                else begin
                  ser_en = 1'b1;
                 end				
                end 
				
		PARTY : begin
                 Busy_TX = 1'b1;
				 ser_en  = 1'b0;
				 mux_sel = 2'b10;
                end	
				
		STOP  : begin
		         Busy_TX = 1'b1;
				 ser_en  = 1'b0;
				 mux_sel = 2'b11;				 
		        end
				
	  default : begin
	             Busy_TX = 1'b0;
				 ser_en  = 1'b0;
				 mux_sel = 2'b00;				 
				end
				
	 endcase
  end
  
endmodule