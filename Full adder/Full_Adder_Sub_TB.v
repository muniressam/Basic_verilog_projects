
module Full_Adder_Sub_TB #(parameter width_tb = 8)();
 reg [width_tb - 1 : 0] A_tb;
 reg [width_tb - 1 : 0] B_tb;
 reg                 Cin_tb;
 wire [width_tb - 1 : 0] Sum_tb;
 wire                 Cout_tb;
 
 Full_Adder_Sub #(.width(width_tb)) DUT(
     .A(A_tb),
	 .B(B_tb),
	 .Cin(Cin_tb),
	 .Sum(Sum_tb),
	 .Cout(Cout_tb)
 
 );
 
 initial
 begin
 $dumpfile("Full_Adder_Sub.vcd");
 $dumpvars;
    
    A_tb   =8'b1010; //A=10
    B_tb   =8'b0101; //B=5
	Cin_tb = 1'b0;
	
	#100
	if(Sum_tb==8'b1111 && Cout_tb == 1'b0)
	 $display("Test Sum A+B = %b + %b Passed with Value = %b at time = %0t ",A_tb ,B_tb , Sum_tb , $time  );
    else
     $display("Test Sum A+B = %b + %b Failed with Value = %b at time = %0t ",A_tb ,B_tb , Sum_tb , $time  );
	 
	 
	A_tb   =8'b0011_1011; //A=10
    B_tb   =8'b0110_0101; //B=5
	Cin_tb = 1'b1;
	#100
	
	if(Sum_tb==8'b1101_0110 && Cout_tb == 1'b1 )
	 $display("Test Sub A-B = %b - %b Passed with Value = %b at time = %0t ",A_tb ,B_tb , Sum_tb , $time  );
    else
     $display("Test Sub A-B = %b - %b Failed with Value = %b at time = %0t ",A_tb ,B_tb , Sum_tb , $time  );
	
	
	A_tb   =8'b1011; //A=10
    B_tb   =8'b1101; //B=5
	Cin_tb = 1'b0;
	#100
	if(Sum_tb==8'b11000 && Cout_tb == 1'b0)
	 $display("Test Sum A+B = %b + %b Passed with Value = %b at time = %0t ",A_tb ,B_tb , Sum_tb , $time  );
    else
     $display("Test Sum A+B = %b + %b Failed with Value = %b at time = %0t ",A_tb ,B_tb , Sum_tb , $time  );
	 
	 
	 
  #400
 $stop;
 end
 
 endmodule