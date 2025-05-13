module FIFO_MEM #(parameter width = 8 , parameter p_width = 4)
(
input wire  [width-1:0]  wdata ,
input wire               winc  ,
input wire               wfull ,
input wire               wclk  ,
input wire               wrst_n  ,
input wire  [p_width-1:0]waddr ,
input wire  [p_width-1:0]raddr ,

output wire [width-1:0] rdata
);

integer i ;
reg [width-1:0] MEM [width-1:0];
wire wclken ;

assign wclken = ~wfull & winc ;

always @(posedge wclk or negedge wrst_n) 
 begin
     if (!wrst_n) begin
	     for (i=0; i<width; i=i+1) begin
                MEM[i] <= {width{1'b0}};
         end
	 end else if(wclken) begin
	      MEM[waddr] <= wdata;
	 end
 
 end
 
assign rdata = MEM[raddr];
 
endmodule