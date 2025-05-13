
`timescale 1us/1ns

module UART_TX_TB #(parameter P_Width_tb = 8 )();

 reg [P_Width_tb - 1 : 0] P_DATA_tb;
 reg                      DATA_VALID_tb;
 reg                      PAR_EN_tb;
 reg                      PAR_TYP_tb;
 reg                      CLK_tb;
 reg                      RST_tb;
 
 wire                     TX_OUT_tb;
 wire                     Busy_tb;
 
 parameter CLK_PERIOD = 8.68055556 ;
 
 always #(CLK_PERIOD/2) CLK_tb = ~CLK_tb ;

UART_TX #(.width(P_Width_tb)) DUT (
 .P_DATA_TX(P_DATA_tb),
 .DATA_VALID_TX(DATA_VALID_tb),
 .PAR_EN(PAR_EN_tb),
 .PAR_TYP(PAR_TYP_tb),
 .CLK_TX(CLK_tb),
 .RST_TX(RST_tb),
 .TX_OUT(TX_OUT_tb),
 .Busy(Busy_tb)
);

initial 
  begin
     $dumpfile("UARTX.vcd");
	 $dumpvars;
	  
	  initialize();
	  Reset();
	  
	  
      DATA_VALID_tb = 1'b1;	  
	  P_DATA_tb     = 'hA5;
	  PAR_EN_tb     = 1'b1;
	  PAR_TYP_tb    = 1'b0;
	  
	  Start(DATA_VALID_tb);
	  Data(P_DATA_tb);
	  Parity(PAR_TYP_tb,PAR_EN_tb);
	  Stop();
	  
	  #100
	  
	  DATA_VALID_tb = 1'b1;
	  P_DATA_tb     = 'hF4;
	  PAR_EN_tb     = 1'b0;
	  PAR_TYP_tb    = 1'b1;
	 
	  Start(DATA_VALID_tb);
	  Data(P_DATA_tb); 
	  Parity(PAR_TYP_tb,PAR_EN_tb);
	  Stop();
	  
	  #100
	  
	  DATA_VALID_tb = 1'b1;
	  P_DATA_tb     = 'hF2;
	  PAR_EN_tb     = 1'b1;
	  PAR_TYP_tb    = 1'b1;
	 
	  Start(DATA_VALID_tb); 
   	  Data(P_DATA_tb); 
	  Parity(PAR_TYP_tb,PAR_EN_tb);
	  Stop();
	  
	  
  #100
  $stop;
  end

task initialize;
  begin
	 CLK_tb        = 1'b0;
	 RST_tb        = 1'b0;
	 DATA_VALID_tb = 1'b0;
	 P_DATA_tb     = 8'h00;
	 PAR_TYP_tb    = 1'b0;
	 PAR_EN_tb     = 1'b0;
  end
endtask
  
task Reset;
    begin
        RST_tb = 1'b1;
        #CLK_PERIOD
        RST_tb = 1'b0;
        #CLK_PERIOD
        RST_tb = 1'b1;  
    end
endtask


task Start ;
  input data_valid;
  
  begin
    if(data_valid && !Busy_tb)
	   begin
	    #CLK_PERIOD
		 if(TX_OUT_tb )
		   begin
		     $display(" Start bit is Succeded %b ",TX_OUT_tb);
		   end
		 else
		   begin
		     $display(" Start bit is Faild %b ",TX_OUT_tb);
		   end
	     end
	     else if(Busy_tb)
	      begin
		    $display("Data are in transmation you can not send Data now"); 
	      end
	 
	DATA_VALID_tb     = 1'b0;
	
  end
endtask

task Data;
  input  [P_Width_tb - 1 : 0] p_data;
  integer i;
  
  begin	 
  #CLK_PERIOD
	     for(i=0;i<P_Width_tb;i=i+1)
		   begin
           	#CLK_PERIOD	   
		     if(TX_OUT_tb == p_data[i])
			   begin 
			     $display(" Transmate %d bit is Succeded with OUT %b and P_Data %b " , i , TX_OUT_tb, p_data[i] );				 
			   end
			 else
			   begin
			     $display(" Transmate %d bit is Faild  with OUT %b and P_Data %b " , i , TX_OUT_tb, p_data[i] );	
			   end
		   end
 		   
  end
endtask

task Parity;
  input par_typ , par_en;
  
  begin
  #CLK_PERIOD
     if(par_en)
		   begin
		     if(par_typ == 1'b0)
			   begin
			     $display(" Test Parity even is Succeded %b ", PAR_TYP_tb ); 
			   end
			 else 
			   begin
			     $display(" Test Parity odd is Succeded %b ", PAR_TYP_tb );
			   end
			end 
  end
endtask

task Stop ;
  begin
  #CLK_PERIOD
     if(TX_OUT_tb == 1'b1)
       begin
		 $display(" Stop bit is Succeded %b ", TX_OUT_tb);
	   end
     else
       begin
		 $display(" Stop bit is Faild %b ", TX_OUT_tb);
	   end   
			 
  end
endtask

endmodule
