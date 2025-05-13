
module ALU_tb #(parameter width_tb = 8)();
 reg  [width_tb - 1:0] A_tb;
 reg  [width_tb - 1:0] B_tb;
 reg  [2:0]  opcode_tb;

 wire [width_tb - 1:0] ALU_OUT_tb;
 wire        C_Flag_tb;
 wire        Cout_tb; 

  ALU DUT(
  .A(A_tb),
  .B(B_tb),
  .opcode(opcode_tb),
  .ALU_OUT(ALU_OUT_tb),
  .C_Flag(C_Flag_tb),
  .Cout(Cout_tb)
  );
  
  
initial
 begin
 $dumpfile("ALU.vcd");
 $dumpvars;
   
   A_tb   =8'b1010; //A=10
   B_tb   =8'b0101; //B=5
   
 $display("Test Sum");
   #10
   opcode_tb=3'b000 ;
   #10
   if (ALU_OUT_tb == 8'b1111)// 15
     $display("Test sum Passed with Value = %b at time = %0t   " , ALU_OUT_tb , $time  );
   else
     $display("Test sum Failed with Value = %b at time = %0t   " , ALU_OUT_tb , $time  );
     
     
$display("Test Sub");
   #10
   opcode_tb=3'b001 ;
   #10
   if (ALU_OUT_tb == 8'b0101)//5
     $display("Test sub Passed with Value = %b at time = %0t   " , ALU_OUT_tb , $time );
   else
     $display("Test sub Failed with Value = %b at time = %0t   " , ALU_OUT_tb , $time );
     
     
$display("Test Logical AND");
   #10
   opcode_tb=3'b010 ;
   #10
   if (ALU_OUT_tb == 8'b0000)
     $display("Test Logical AND Passed with Value = %b at time = %0t  " , ALU_OUT_tb , $time  );
   else
     $display("Test Logical AND Failed with Value = %b at time = %0t  " , ALU_OUT_tb , $time  );
     
     
$display("Test Logical OR");
   #10
   opcode_tb=3'b011 ;
   #10
   if (ALU_OUT_tb == 8'b1111)
     $display("Test Logical OR Passed with Value = %b at time = %0t  " , ALU_OUT_tb , $time  );
   else
     $display("Test Logical OR Failed with Value = %b at time = %0t  " , ALU_OUT_tb , $time  );
      
     
 $display("Test A > B ");
   #10
   opcode_tb=3'b101 ;
   A_tb =16'b1111 ;
   B_tb =16'b1001 ;
   #10
   if (C_Flag_tb == 1'b1 && ALU_OUT_tb == 8'b0)
     $display("Test Greater  Passed and C_Flag = %b at time = %0t  " , C_Flag_tb , $time  );
   else
     $display("Test Greater  Failed and C_Flag = %b at time = %0t  " , C_Flag_tb , $time  );
	 
	 
 $display("Test Shift Left A ");
   #10
   opcode_tb = 3'b110 ;
   A_tb =8'b0101_1110 ;
   #10
   if (ALU_OUT_tb == 8'b1011_1100)
     $display("Test Shift Left for A %b Passed with Value = %b at time = %0t ",A_tb , ALU_OUT_tb , $time  );
   else
     $display("Test Shift Left for A %b Failed with Value = %b at time = %0t ",A_tb , ALU_OUT_tb , $time  );
      
	  
  $display("Test Shift Left B ");
   #10
   opcode_tb = 3'b111 ;
   B_tb = 8'b0111 ;
   #10
   if (ALU_OUT_tb == 8'b0000_1110)
     $display("Test Shift Left for B %b  Passed with Value = %b at time = %0t " ,B_tb, ALU_OUT_tb , $time  );
   else
     $display("Test Shift Left for B %b  Failed with Value = %b at time = %0t " ,B_tb, ALU_OUT_tb , $time  );
	 
 #400
 $stop; 
end  
endmodule