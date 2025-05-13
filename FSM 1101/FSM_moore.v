module FSM_Moore (

  input wire IN,
  input wire CLK,
  input wire RST,
  output reg OUT
  
);

localparam S0   = 3'b000,
           S1   = 3'b001,
           S2   = 3'b010,
		   S3   = 3'b011,
		   S4   = 3'b100;
		  
 reg [2:0] current_state , next_state;

always @(posedge CLK or negedge RST)
  begin
    if(!RST)
	  begin
	   OUT <= 1'b0;
	   current_state <= S0;
	  end
    else
	  begin
	   current_state <= next_state;
	  end
  end
  
always @(*)
 begin
    case (current_state)
      S0: begin
	     OUT = 1'b0;
	     if(IN)
		  next_state = S1;
		 else 
		  next_state = S0;
		  end
	  S1: begin
	     OUT = 1'b0;
	     if(IN)
		  next_state = S2;
		 else
		  next_state = S0;
		  end
		  
	  S2: begin
	     OUT = 1'b0;
	     if(IN)
		  next_state = S2;
		 else
		  next_state = S3;
		  end
		  
	  S3: begin
	     OUT = 1'b0;
	     if(IN)
		  next_state = S4;
		 else
		  next_state = S0;
		  end
		  
	  S4: begin
	     OUT = 1'b1;
	     if(IN)
		  next_state = S1;
		 else
		  next_state = S0;
		  end
		  
default : begin
	      OUT = 1'b0;
		  next_state = S0;
	
	      end
 endcase
 
 end

endmodule