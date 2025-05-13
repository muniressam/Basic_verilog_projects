module CRC #(
    parameter width = 8, SEED  = 8'hd8) (
    input  wire Data,
    input  wire Active,
    input  wire CLK,
   	input  wire RST,
	
	output reg  valid,
    output reg  CRC
    
);

    reg [width-1:0] LFSR;
    reg [3:0]       Counter;
    wire            Feedback;

      

    assign Feedback = LFSR[0]^Data;

    always @(posedge CLK or negedge RST) begin
        if (!RST)
            begin
                LFSR  <= SEED ;
                CRC   <= 1'b0 ;
                valid <= 1'b0 ;
            end
        else
            begin
            if(Active)
               begin
	             LFSR[0]<=LFSR[1];
	             LFSR[1]<=LFSR[2];
		         LFSR[2]<=LFSR[3]^Feedback;
		         LFSR[3]<=LFSR[4];
		         LFSR[4]<=LFSR[5];
		         LFSR[5]<=LFSR[6];
		         LFSR[6]<=LFSR[7]^Feedback;
		         LFSR[7]<=Feedback;
		         valid <= 1'b0;
			
                   
               end
            else if (Counter != 4'b1000)
                begin
                  
                    {LFSR[6:0],CRC} <= LFSR;
                 
                     valid = 1'b1;
                end     
                    
    end
    end

    always @(posedge CLK or negedge RST) begin
        if(!RST)
            begin
                Counter <= 4'b1000;
            end
        else if (!Active)
            begin
                 Counter <= Counter + 4'b0001;
            end   
        else
            begin
                Counter <= 4'b0000;
            end     

    end
    
endmodule