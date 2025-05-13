module FSM_RX (
 input wire RX_IN,
 input wire PAR_EN,
 input wire [5:0] PRESCALE, 
 input wire [5:0] edge_cnt,
 input wire [3:0] bit_cnt,
 input wire clk,
 input wire rst,
 input wire par_err,
 input wire strt_glitch,
 input wire stp_err,
 
 output reg dat_samp_en,
 output reg enable_count,
 output reg deser_en,
 output reg DATA_VALID,
 output reg stp_chk_en,
 output reg strt_chk_en, 
 output reg par_chk_en

);

localparam       IDEAL  = 3'b000,
                 START  = 3'b001,
		         DATA   = 3'b010,
		         PARTY  = 3'b011,
		         STOP   = 3'b100;
				 
reg data_valid_RX;
reg [2:0] current_state , next_state ;

wire[5:0] check_edge ;

assign check_edge = PRESCALE - 6'b1;
always @(posedge clk or negedge rst)
begin
 if (!rst) begin
     current_state <= IDEAL;
	 DATA_VALID    <= 1'b0;
 end else begin
     current_state <= next_state;
	 DATA_VALID    <= data_valid_RX;
 end
end
 
always @(*)
begin
 case(current_state)
    IDEAL : begin
	         if(!RX_IN) begin    // check if IN change from 1 ideal case
			  next_state = START;
			 end else begin
			  next_state = IDEAL;
			 end
	        end
	START : begin
			 if(bit_cnt == 'b0 && edge_cnt == check_edge) begin // Trigger bit_cnt to access next state and en flags
			    if(!strt_glitch) begin // if there is glitch stay in ideal not go to start
			      next_state = DATA;
			    end else begin
			      next_state = IDEAL; 
			    end
				
			 end else begin
			    next_state = START;
			 end
			 
	        end
	DATA  : begin 
	         if(bit_cnt == 'b1000 && edge_cnt == check_edge ) begin
			    if(PAR_EN) begin       // check if there is parity or go to STOP state
			     next_state = PARTY;
			    end else begin
			     next_state = STOP;
			    end 
			 end else begin
			    next_state = DATA;
			 end
			end
    PARTY : begin
	        if(bit_cnt == 'b1001 && edge_cnt == check_edge) begin
	           if(par_err) begin      // check if there is error in parity or not
			    next_state = IDEAL;
			   end else begin
			    next_state = STOP;
			    end 
			end else begin
			   next_state = PARTY;
			end
			
	        end
	STOP  : begin
	         if(stp_err) begin     // check if there is error in stop bit or not
			  next_state = IDEAL;
			 end else begin
			   if(PAR_EN) begin
			     if(bit_cnt == 'b1010 && edge_cnt == (check_edge- 6'd1)) begin
				     if (!RX_IN)
			          next_state = START;
			         else
			          next_state = IDEAL;
				 end else begin
				     next_state = STOP;
				 end
		
			   end else begin
			     if(bit_cnt == 'b1001 && edge_cnt == (check_edge- 6'd1)) begin
				     if (!RX_IN)
			          next_state = START;
			         else
			          next_state = IDEAL;
				 end else begin
				     next_state = STOP;
				 end
			   end 
			 end
	        end
  default : begin
              next_state = IDEAL;	 
	        end	  
 endcase
end

always @(*) 
begin
	         dat_samp_en = 1'b0;
             enable_count= 1'b0;
             deser_en    = 1'b0;
             data_valid_RX  = 1'b0;
             stp_chk_en  = 1'b0;
             strt_chk_en = 1'b0; 
             par_chk_en  = 1'b0;
 case (current_state)
    IDEAL : begin
	         if(!RX_IN) begin
			 enable_count= 1'b1;
	         dat_samp_en = 1'b1;
			 strt_chk_en = 1'b1;
			 end
	         dat_samp_en = 1'b0;
             enable_count= 1'b0;
             deser_en    = 1'b0;
             data_valid_RX  = 1'b0;
             stp_chk_en  = 1'b0;
             strt_chk_en = 1'b0; 
             par_chk_en  = 1'b0;
	        end
	START : begin
	         enable_count= 1'b1;
			 deser_en    = 1'b1;
	         dat_samp_en = 1'b1;
			 strt_chk_en = 1'b1;
			// strt_chk_en = (bit_cnt == 'b0) ? 1'b1 : 1'b0;
	        end
	DATA  : begin 
	         enable_count= 1'b1;
			 dat_samp_en = 1'b1;
	         deser_en    = 1'b1;
			 
			end
    PARTY : begin
	         enable_count= 1'b1;
			 dat_samp_en = 1'b1;
			 par_chk_en  = 1'b1;
			 //par_chk_en  = (bit_cnt == 'b1010) ? 1'b1 : 1'b0;
			 
	        end
	STOP  : begin
	         enable_count= 1'b1;
			 dat_samp_en = 1'b1;
			 stp_chk_en  = 1'b1;
			 
			 
			 /*if (PAR_EN) begin
			 stp_chk_en  = (bit_cnt == 'b1011) ? 1'b1 : 1'b0;
			 end else begin
			 stp_chk_en  = (bit_cnt == 'b1010) ? 1'b1 : 1'b0;
			 end*/
			 
			 data_valid_RX  = (stp_err | par_err ) ? 1'b0 : 1'b1;
	        end
  default : begin
             dat_samp_en = 1'b0;
             enable_count= 1'b0;
             deser_en    = 1'b0;
             data_valid_RX  = 1'b0;
             stp_chk_en  = 1'b0;
             strt_chk_en = 1'b0; 
             par_chk_en  = 1'b0;	 
	        end	  
 
 endcase
end
endmodule