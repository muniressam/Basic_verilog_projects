module Serializer #(parameter P_Width = 8)(
 input wire [P_Width - 1 : 0] P_DATA,
 input wire                   DATA_VALID,
 input wire                   ser_en,
 input wire                   Busy,
 input wire                   CLK,
 input wire                   RST,
 
 output wire                  ser_done,
 output wire                  ser_data

);
 reg [P_Width - 1 : 0] Get_DATA;
 reg [2:0] Counter;
 

 
 always @(posedge CLK or negedge RST)
   begin
     if(!RST)
	   begin
	     Get_DATA <= 1'b0;
	   end
	 else
	   begin
	     if(DATA_VALID && !Busy)
		   begin
		     Get_DATA <= P_DATA;
		   end
		 else if(ser_en)
		   begin
			    
			 Get_DATA <= Get_DATA >> 1;
      
			 
		   end
           
	   end
   end
   
always @(posedge CLK or negedge RST) 
    begin
        if(!RST)
            begin
                Counter <= 3'b000;
            end
        else 
         begin
         if (ser_en)
            begin
                 Counter <= Counter + 3'b001;
            end   
        else
            begin
                Counter <= 3'b000;
            end     
         end
    end

assign ser_data = Get_DATA[0];
assign ser_done = (Counter == 3'b111) ? 1'b1 : 1'b0 ;

				   
endmodule
