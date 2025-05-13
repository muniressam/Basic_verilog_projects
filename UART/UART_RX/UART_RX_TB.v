`timescale 1ns/1ps
module UART_RX_TB #(parameter width = 8 )();
 reg RX_IN_tb;
 reg [5:0]PRESCALE_tb;
 reg PAR_EN_tb;
 reg PAR_TYP_tb;
 reg RX_CLK_tb;
 reg RST_tb;
 
 wire par_err_tb;
 wire stp_err_tb;
 wire DATA_VALID_tb;
 wire[width - 1 : 0] P_DATA_tb;
 
 reg TX_CLK_tb ;

 parameter CLK_PERIOD_TX = 8.68;

UART_RX #(.width(width)) DUT (
.RX_IN(RX_IN_tb),
.PRESCALE(PRESCALE_tb),
.PAR_EN(PAR_EN_tb),
.PAR_TYP(PAR_TYP_tb),
.CLK_RX(RX_CLK_tb),
.RST_RX(RST_tb),
.par_err(par_err_tb),
.stp_err(stp_err_tb),
.DATA_VALID_RX(DATA_VALID_tb),
.P_DATA_RX(P_DATA_tb)

);

initial 
 begin
     $dumpfile("UART_RX.vcd");
     $dumpvars;
	 
	 initialize();
	 Reset();
	 // Inputs (PAR_EN,PAR_TYP,PRESCALE)
	 // Data(input data)
	 // Disp_OUT (input data,test_num)
	 
	 //Test 1
	 Inputs (1'b0,1'b1,6'd8);
	 Data(8'hAB); //1010_1011
	 Disp_OUT(8'hAB,1);
	 
	 //Test 2
	 Inputs (1'b1,1'b1,6'd16);
	 Data(8'hBB);
	 Disp_OUT(8'hBB,2);
	 
	 //Test 3
	 Inputs (1'b0,1'b0,6'd8);
	 Data(8'hFC);
	 Disp_OUT(8'hFC,3);
	 
	 //Test 4
	 Inputs (1'b0,1'b0,6'd32);
	 Data(8'h98);
	 Disp_OUT(8'h98,4);
	 
	 //Test 5
	 Inputs (1'b1,1'b1,6'd16);
	 Data(8'h55);
	 Disp_OUT(8'h55,5);
	 
     #400
	 $stop;
 end
 // generate CLK
 
 always #(CLK_PERIOD_TX/PRESCALE_tb/2) RX_CLK_tb = ~RX_CLK_tb ; 
 always #(CLK_PERIOD_TX /2) TX_CLK_tb  = ~TX_CLK_tb ;
 
task initialize;
  begin
	 RX_CLK_tb     = 1'b0;
	 TX_CLK_tb     = 1'b0;
	 RST_tb        = 1'b0;
	 RX_IN_tb      = 1'b1;
	 PRESCALE_tb   = 6'd32; 
	 PAR_TYP_tb    = 1'b0;
	 PAR_EN_tb     = 1'b0;
  end
endtask
  
task Reset;
    begin
	    RST_tb = 'b1;
        #(CLK_PERIOD_TX)
        RST_tb = 'b0;
        #(CLK_PERIOD_TX)
        RST_tb = 'b1;		
    end
endtask

task Inputs;
  input PAR_EN;
  input PAR_TYP;
  input [5:0] presc;
  
  begin
     PAR_EN_tb   = PAR_EN   ;
	 PAR_TYP_tb  = PAR_TYP  ;
     PRESCALE_tb = presc   ;
  end
endtask

task Data;
 input [width - 1 : 0 ] data_in;
 integer i;
 begin
     
	  #(CLK_PERIOD_TX)
	  RX_IN_tb = 1'b0 ;       // start bit
	for (i=0;i<width;i=i+1) begin	
	  #(CLK_PERIOD_TX)
	   RX_IN_tb = data_in[i];
	end
	
	if(PAR_EN_tb) begin
	  #(CLK_PERIOD_TX)
	   case(PAR_TYP_tb)
	   1'b0 : RX_IN_tb = ^data_in; //even parity
	   1'b1 : RX_IN_tb = ~^data_in; //odd parity
	   endcase
	end
	
	#(CLK_PERIOD_TX)
	RX_IN_tb = 1'b1;          // stop bit
 end
endtask

task Disp_OUT ;
 input  [width-1:0]  expected_out;
 input  [4:0]        test_num;
  
 begin
	//@(posedge DATA_VALID_tb)	
	#(CLK_PERIOD_TX)
	if(P_DATA_tb == expected_out) begin
	  $display("Test Case num %d is PASSED data = %h and expect out = %h ,",test_num,P_DATA_tb , expected_out );
	end else begin
	  $display("Test Case num %d is FAILED data = %h and expect out = %h ,",test_num,P_DATA_tb , expected_out );
	end
 end
endtask
 
endmodule

