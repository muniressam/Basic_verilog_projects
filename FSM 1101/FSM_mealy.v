module FSM_Mealy(
 input wire IN,
 input wire CLK,
 input wire RST,
 
 output reg OUT

);

localparam S0   = 2'b00,
           S1   = 2'b01,
		   S2   = 2'b10,
		   S3   = 2'b11;
		   
reg [1:0]current_state , next_state;


always @(posedge CLK or negedge RST)
 begin
     if(!RST)
	  current_state <= S0;
	 else 
	  current_state <= next_state;
 end
 
always @(*)
 begin
    case (current_state)
      S0: begin
	     
	     if(IN)begin
		  next_state = S1;
		  OUT = 1'b0;
		  end
		 else begin
		  next_state = S0;
		  OUT = 1'b0;
		  end
		  end
		  
	  S1: begin
	     
	     if(IN) begin
		  next_state = S2;
		  OUT = 1'b0;
		  end
		 else begin
		  next_state = S0;
		  OUT = 1'b0;
		  end
		  end
		  
	  S2: begin
	     
	     if(~IN) begin
		  next_state = S3;
		  OUT = 1'b0;
		  end
		 else begin
		  next_state = S2;
		  OUT = 1'b0;
		  end
		  end
		  
	  S3: begin
	     
	     if(IN) begin
		  next_state = S0;
		  OUT = 1'b1;
		  end
		 else begin
		  next_state = S0;
		  OUT = 1'b0;
		  end
		  end
	 
 endcase
 
 end

endmodule