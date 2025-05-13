`timescale 1us/1ns

module Register_File_tb();
reg [15 : 0] WrData_tb;
reg  [15 : 0] Address_tb;
reg  WrEn_tb;
reg  RdEn_tb;
reg  CLK_tb;
reg  RST_tb;

wire [15 : 0] RdData_tb;

Register_File DUT(
.WrData(WrData_tb),
.Address(Address_tb),
.WrEn(WrEn_tb),
.RdEn(RdEn_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.RdData(RdData_tb)
);

always #5 CLK_tb = ~CLK_tb; // for F = 100KHz

initial
  begin
    $dumpfile("Register.vcd");
    $dumpvars;
     RST_tb    = 1'b0;
	 CLK_tb    = 1'b0;
	 WrEn_tb   = 1'b0;
     RdEn_tb   = 1'b0;
	 Address_tb = 16'b0;
	 WrData_tb = 16'b0;
	
	$display (" Test case 1 for test write Data when WrEn is High  ");
	#10
	RST_tb     =1'b1;
	Address_tb = 16'b1;
	WrEn_tb    = 1'b1;
	WrData_tb  = 16'b11;
	#10
	WrEn_tb = 1'b0;
	RdEn_tb = 1'b1;
	#10
	if (RdData_tb == 16'b11)
	  $display("test case1 is PASSED ");
	  
	else
	  $display("test case1 is FAILED ");
	  
	$display (" Test case 2 for Test write Data when WrEn is low and RdEn is High ");
	#10
	Address_tb = 16'b1;
	WrEn_tb    = 1'b0;
	WrData_tb  = 16'b101;
	#10
	WrEn_tb = 1'b0;
	RdEn_tb = 1'b1;
	#10
	if (RdData_tb == 16'b11) // return the old value not new value of WrData
	  $display("test case2 is PASSED ");
	  
	else
	  $display("test case2 is FAILED ");
	  
	  
	  $display (" Test case 3 for Test Read when RdEn is low and WrEn is High ");
	#10
	Address_tb = 16'b11;
	WrEn_tb    = 1'b1;
	WrData_tb  = 16'b111;
	#10
	WrEn_tb = 1'b0;
	RdEn_tb = 1'b0;
	#10
	if (RdData_tb == 16'b11) // return the same old value
	  $display("test case3 is PASSED ");
	  
	else
	  $display("test case3 is FAILED ");
	  
	  $display (" Test case 4 for Test Read when RdEn is High ");
	#10
	RdEn_tb = 1'b1;
	#10
	if (RdData_tb == 16'b111) // return new value
	  $display("test case4 is PASSED ");
	  
	else
	  $display("test case4 is FAILED ");
	  
	  #400
	  $stop; 
  end

endmodule