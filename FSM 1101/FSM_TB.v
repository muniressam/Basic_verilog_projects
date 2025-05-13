`timescale 1us/1ns
module FSM_TB ();

 reg IN_TB;
 reg CLK_TB;
 reg RST_TB;

 wire OUT_TB;

FSM_Mealy DUT(

.IN(IN_TB),
.CLK(CLK_TB),
.RST(RST_TB),
.OUT(OUT_TB)

);
 
always #5 CLK_TB = ~CLK_TB ;

initial
 begin
  $dumpfile("FSM.vcd");
  $dumpvars;
 
 
 IN_TB = 1'b0;
 CLK_TB = 1'b0;
 RST_TB = 1'b0;
 
 #10
 RST_TB = 1'b1;
 IN_TB = 1'b0;
 #10
 IN_TB = 1'b1;
 #10
 IN_TB = 1'b1;
 #10
 IN_TB = 1'b0;
 #10
 IN_TB = 1'b1; // Output equal (1) 
  
 
 #10
 IN_TB = 1'b1;
 #10
 IN_TB = 1'b1;
 #10
 IN_TB = 1'b0;
 #10
 IN_TB = 1'b1; // Output equal (1) 
 
 
 #10
 IN_TB = 1'b0;
 
 
#100
$stop;
 
 
 end


endmodule
