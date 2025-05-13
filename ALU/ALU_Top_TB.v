`timescale 1us/1ns

module ALU_Top_tb #(parameter width_tb =16,
                              Arith_width_tb = width_tb + width_tb,
                              Logic_width_tb = width_tb,	
                              CMP_width_tb   = width_tb,
                              Shift_width_tb = width_tb )();
 reg signed [width_tb-1:0] A_tb;
 reg signed [width_tb-1:0] B_tb;
 reg        [3:0]        ALU_FUN_tb;
 reg                     CLK_tb;
 reg                     RST_tb;

 wire signed [Arith_width_tb-1:0]    Arith_OUT_tb; 
 wire                              Carry_OUT_tb;
 wire                              Arith_Flag_tb;
 wire        [Logic_width_tb-1:0] Logic_OUT_tb;
 wire                              Logic_Flag_tb;
 wire        [CMP_width_tb-1:0]    CMP_OUT_tb; 
 wire                              CMP_Flag_tb;
 wire        [Shift_width_tb-1:0]  Shift_OUT_tb;
 wire                              Shift_Flag_tb;
 
 // clock Generator for frequency 100 KHz with duty cycle 40% low and 60% high

parameter CLK_period = 10 ;
parameter High_period = CLK_period * 0.6 ;
parameter Low_period  = CLK_period * 0.4 ;

 always 
  begin 
    # Low_period CLK_tb =~CLK_tb;
    # High_period  CLK_tb =~CLK_tb;
  end
  
ALU_Top #(.width(width_tb),
          .Arith_width(Arith_width_tb),
          .Logic_width(Logic_width_tb),	
          .CMP_width(CMP_width_tb),
          .Shift_width(Shift_width_tb) ) DUT (

.A(A_tb),
.B(B_tb),
.ALU_FUN(ALU_FUN_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.Arith_OUT(Arith_OUT_tb),
.Carry_OUT(Carry_OUT_tb),
.Arith_Flag(Arith_Flag_tb),
.Logic_OUT(Logic_OUT_tb),
.Logic_Flag(Logic_Flag_tb),
.CMP_OUT(CMP_OUT_tb),
.CMP_Flag(CMP_Flag_tb),
.Shift_OUT(Shift_OUT_tb),
.Shift_Flag(Shift_Flag_tb)
  );

initial
  begin
  $dumpfile("ALU_Top.vcd");
  $dumpvars;
   
   CLK_tb =1'b0;
   RST_tb =1'b0;
   A_tb   ='shFFFB; // -'d5
   B_tb   ='shFFF6; // -'d10
   ALU_FUN_tb= 4'b0000;
  
   $display(" **************** TEST CASES FOR SUMMING********************");// TEST CASES FOR SUMMING
   
   $display("Test case 1 Addition of NEG+NEG");
   RST_tb =1'b1;
  #CLK_period
  
   if (Arith_OUT_tb == -'d15 && Arith_Flag_tb == 1'b1 )
      $display("Addition %0d + %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Addition %0d + %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
 
   $display("Test case 2 Addition of POS+NEG");
   A_tb   ='sh0005; // +'d5
   B_tb   ='shFFF6; // -'d10
  #CLK_period
  
   if (Arith_OUT_tb == -'d5 && Arith_Flag_tb == 1'b1 )
      $display("Addition %0d + %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Addition %0d + %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period

   $display("Test case 3 Addition of NEG+POS");
    A_tb   ='shFFFB; // -'d5
    B_tb   ='sh000A; // +'d10
  #CLK_period
  
   if (Arith_OUT_tb == 'd5 && Arith_Flag_tb == 1'b1 )
      $display("Addition %0d + %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Addition %0d + %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
  
   $display("Test case 4 Addition of Pos+POS");
    A_tb   ='sh0005; // +'d5
    B_tb   ='sh000A; // +'d10
  #CLK_period
  
   if (Arith_OUT_tb == 'd15 && Arith_Flag_tb == 1'b1 )
      $display("Addition %0d + %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Addition %0d + %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
  
  
  
  $display(" **************** TEST CASES FOR SUBTRACTION ********************");// TEST CASES FOR SUBTRACTION
   
   $display("Test case 1 Subtraction of NEG-NEG");
    A_tb   ='shFFFB; // -'d5
    B_tb    ='shFFF6; // -'d10
   ALU_FUN_tb= 4'b0001;
  #CLK_period
  
   if (Arith_OUT_tb == 'd5 && Arith_Flag_tb == 1'b1 )
      $display("Subtraction %0d - %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Subtraction %0d - %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
 
   $display("Test case 2 Subtraction of POS-NEG");
   A_tb   ='sh0005; // +'d5
   B_tb   ='shFFF6; // -'d10
  #CLK_period
  
   if (Arith_OUT_tb == 'd15 && Arith_Flag_tb == 1'b1 )
      $display("Subtraction %0d - %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Subtraction %0d - %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period

   $display("Test case 3 Subtraction of NEG-POS");
    A_tb   ='shFFFB; // -'d5
    B_tb   ='sh000A; // +'d10
  #CLK_period
  
   if (Arith_OUT_tb == -'d15 && Arith_Flag_tb == 1'b1 )
      $display("Subtraction %0d - %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Subtraction %0d - %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
   
 
   $display("Test case 4 Subtraction of Pos-POS");
    A_tb   ='sh0005; // +'d5
    B_tb   ='sh000A; // +'d10
  #CLK_period
  
   if (Arith_OUT_tb == -'d5 && Arith_Flag_tb == 1'b1 )
      $display("Subtraction %0d - %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Subtraction %0d - %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
  
  
  
   $display(" **************** TEST CASES FOR MULTIBLICATION ********************");// TEST CASES FOR MULTIBLICATION
   
   $display("Test case 1 Multiplication of NEG*NEG");
    A_tb   ='shFFFB; // -'d5
    B_tb    ='shFFF6; // -'d10
   ALU_FUN_tb= 4'b0010;
  #CLK_period
  
   if (Arith_OUT_tb == 'd50 && Arith_Flag_tb == 1'b1 )
      $display("Multiplication %0d * %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Multiplication %0d * %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
 
   $display("Test case 2 Multiplication of POS*NEG");
   A_tb   ='sh0005; // +'d5
   B_tb   ='shFFF6; // -'d10
  #CLK_period
  
   if (Arith_OUT_tb == -'d50 && Arith_Flag_tb == 1'b1 )
      $display("Multiplication %0d * %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Multiplication %0d * %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period

   $display("Test case 3 Multiplication of NEG*POS");
    A_tb   ='shFFFB; // -'d5
    B_tb   ='sh000A; // +'d10
  #CLK_period
  
   if (Arith_OUT_tb == -'d50 && Arith_Flag_tb == 1'b1 )
      $display("Multiplication %0d * %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Multiplication %0d * %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
   
 
   $display("Test case 4 Multiplication of Pos*POS");
    A_tb   ='sh0005; // +'d5
    B_tb   ='sh000A; // +'d10
  #CLK_period
  
   if (Arith_OUT_tb == 'd50 && Arith_Flag_tb == 1'b1 )
      $display("Multiplication %0d * %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Multiplication %0d * %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
 
  
    $display(" **************** TEST CASES FOR DIVISION ********************");// TEST CASES FOR DIVISION
   
   $display("Test case 1 Division of NEG/NEG");
    A_tb   ='shFFF6; // -'d10
    B_tb    ='shFFFB; // -'d5
   ALU_FUN_tb= 4'b0011;
  #CLK_period
  
   if (Arith_OUT_tb == 'd2 && Arith_Flag_tb == 1'b1 )
      $display("Division %0d / %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Division %0d / %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
 
   $display("Test case 2 Division of POS/NEG");
   A_tb   ='shFFF6; // -'d10
   B_tb   ='sh0005; // +'d5
  #CLK_period
  
   if (Arith_OUT_tb == -'d2 && Arith_Flag_tb == 1'b1 )
      $display("Division %0d / %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Division %0d / %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period

   $display("Test case 3 Division of NEG/POS");
    A_tb   ='sh000A; // 'd10
    B_tb   ='shFFFB; // -'d5
  #CLK_period
  
   if (Arith_OUT_tb == -'d2 && Arith_Flag_tb == 1'b1 )
      $display("Division %0d / %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Division %0d / %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
   
 
   $display("Test case 4 Division of Pos/POS");
    A_tb   ='sh000A; // +'d10
    B_tb   ='sh0005; // +'d5
  #CLK_period
  
   if (Arith_OUT_tb == 'd2 && Arith_Flag_tb == 1'b1 )
      $display("Division %0d / %0d is PASSED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
   else 
	  $display("Division %0d / %0d is FAILED = %0d with carry = %0b ",A_tb,B_tb,Arith_OUT_tb, Carry_OUT_tb);
	  
  #CLK_period
  
  $display("***************************TEST LOGICAL OPERATION ***********************");
  
  A_tb = 'b1101_1001 ;
  B_tb = 'b1011_0010 ;
  ALU_FUN_tb = 4'b0100;
  $display("Test case 1 AND operation ");
  
  #CLK_period
  
  if (Logic_OUT_tb == 'b1001_0000 && Logic_Flag_tb == 1'b1 )
      $display("AND of %0b & %0b is PASSED = %0b",A_tb,B_tb,Logic_OUT_tb);
   else 
	  $display("AND of %0b & %0b is FAILED = %0b",A_tb,B_tb,Logic_OUT_tb);
	  
  #CLK_period	  
  
    $display("Test case 2 OR operation ");
    ALU_FUN_tb = 4'b0101;
  #CLK_period
  
  if (Logic_OUT_tb == 'b1111_1011 && Logic_Flag_tb == 1'b1 )
      $display("OR of %0b | %0b is PASSED = %0b",A_tb,B_tb,Logic_OUT_tb);
   else 
	  $display("OR of %0b | %0b is FAILED = %0b",A_tb,B_tb,Logic_OUT_tb);
	  
  #CLK_period	  
  
    $display("Test case 3 NAND operation ");
    ALU_FUN_tb = 4'b0110;
  #CLK_period
  
  if (Logic_OUT_tb == 'b1111_1111_0110_1111 && Logic_Flag_tb == 1'b1 )
      $display("NAND of ~(%0b & %0b) is PASSED = %0b",A_tb,B_tb,Logic_OUT_tb);
   else 
	  $display("NAND of ~(%0b & %0b )is FAILED = %0b",A_tb,B_tb,Logic_OUT_tb);
	  
  #CLK_period	  
  
      $display("Test case 4 NOR operation ");
    ALU_FUN_tb = 4'b0111;
  #CLK_period
  
  if (Logic_OUT_tb == 'b1111_1111_0000_0100 && Logic_Flag_tb == 1'b1 )
      $display("NAND of ~(%0b | %0b) is PASSED = %0b",A_tb,B_tb,Logic_OUT_tb);
   else 
	  $display("NAND of ~(%0b | %0b )is FAILED = %0b",A_tb,B_tb,Logic_OUT_tb);
	  
  #CLK_period	  
  
   $display("***************************TEST COMPARE OPERATION ***********************");
   
   
   $display("Test case 1 NOP in CMP");
   ALU_FUN_tb = 4'b1000;
  #CLK_period
  if (CMP_OUT_tb == 'b0 && CMP_Flag_tb == 1'b1 )
      $display("Test case NOP is PASSED = %0b",CMP_OUT_tb);
   else 
	  $display("Test case NOP is PASSED = %0b",CMP_OUT_tb);
	  
  #CLK_period
  
   $display("Test case 2 Equal in CMP");
   A_tb = 'h000A; // 10
   B_tb = 'h000A; // 10
   ALU_FUN_tb = 4'b1001;
   
  #CLK_period
  if (CMP_OUT_tb == 'b1 && CMP_Flag_tb == 1'b1 )
      $display("Test case Equal of A=%0d and B=%0d  is PASSED = %0d",A_tb,B_tb,CMP_OUT_tb);
   else 
	  $display("Test case Equal of A=%0d and B=%0d  is FAILED = %0d",A_tb,B_tb,CMP_OUT_tb);
	  
  #CLK_period
  
  
  $display("Test case 3 Greater in CMP");
   A_tb = 'h000A; // 10
   B_tb = 'h0004; // 4
   ALU_FUN_tb = 4'b1010;
   
  #CLK_period
  if (CMP_OUT_tb == 'b10 && CMP_Flag_tb == 1'b1 )
      $display("Test case Greater of A=%0d and B=%0d  is PASSED = %0d",A_tb,B_tb,CMP_OUT_tb);
   else 
	  $display("Test case Greater of A=%0d and B=%0d  is FAILED = %0d",A_tb,B_tb,CMP_OUT_tb);
	  
  #CLK_period
  
    $display("Test case 4 lower in CMP");
   A_tb = 'h0004; // 4
   B_tb = 'h000A; // 10
   ALU_FUN_tb = 4'b1011;
   
  #CLK_period
  if (CMP_OUT_tb == 'b11 && CMP_Flag_tb == 1'b1 )
      $display("Test case lower of A=%0d and B=%0d  is PASSED = %0d",A_tb,B_tb,CMP_OUT_tb);
   else 
	  $display("Test case lower of A=%0d and B=%0d  is FAILED = %0d",A_tb,B_tb,CMP_OUT_tb);
	  
  #CLK_period
  
  
  
   $display("***************************TEST SHIFTING OPERATION ***********************");
   
   $display("Test case 1 Shift Right of A ");
   A_tb = 'b1010; // 10
   ALU_FUN_tb = 4'b1100;
   
  #CLK_period
  if (Shift_OUT_tb == 'b0101 && Shift_Flag_tb == 1'b1 ) // shift right >> 1  equal to div by (2) = 10/2 =5
      $display("Test case Shifting Right of A=%0d  is PASSED = %0d",A_tb,Shift_OUT_tb);
   else 
	  $display("Test case Shifting Right of A=%0d  is FAILED = %0d",A_tb,Shift_OUT_tb);
	  
  #CLK_period
  
   $display("Test case 2 Shift Left of A ");
   A_tb = 'b0110; // 6
   ALU_FUN_tb = 4'b1101;
   
  #CLK_period
  if (Shift_OUT_tb == 'b1100 && Shift_Flag_tb == 1'b1 ) // shift left << 1  equal to mul by (2) = 6*2 =12
      $display("Test case Shifting Right of A=%0d  is PASSED = %0d",A_tb,Shift_OUT_tb);
   else 
	  $display("Test case Shifting Right of A=%0d  is FAILED = %0d",A_tb,Shift_OUT_tb);
	  
  #CLK_period
  
  $display("Test case 3 Shift Right of B ");
   B_tb = 'b0100; // 4
   ALU_FUN_tb = 4'b1110;
   
  #CLK_period
  if (Shift_OUT_tb == 'b0010 && Shift_Flag_tb == 1'b1 ) // shift right >> 1  equal to div by (2) = 4/2 =2
      $display("Test case Shifting Right of B=%0d  is PASSED = %0d",B_tb,Shift_OUT_tb);
   else 
	  $display("Test case Shifting Right of B=%0d  is FAILED = %0d",B_tb,Shift_OUT_tb);
	  
  #CLK_period
  
   $display("Test case 4 Shift Left of B ");
   B_tb = 'b0111; // 7
   ALU_FUN_tb = 4'b1111;
   
  #CLK_period
  if (Shift_OUT_tb == 'b1110 && Shift_Flag_tb == 1'b1 ) // shift left << 1  equal to mul by (2) = 7*2 =14
      $display("Test case Shifting Right of B=%0d  is PASSED = %0d",B_tb,Shift_OUT_tb);
   else 
	  $display("Test case Shifting Right of B=%0d  is FAILED = %0d",B_tb,Shift_OUT_tb);
	  
  #CLK_period
  
  
  
  $display("***************************TEST RESET (NOP) ***********************");
  #CLK_period
  RST_tb = 1'b0;
  #CLK_period
  if (Arith_OUT_tb  ==  'b0 &&
      Carry_OUT_tb  == 1'b0 &&
      Arith_Flag_tb == 1'b0 &&
      Logic_OUT_tb  ==  'b0 && 
      Logic_Flag_tb == 1'b0 &&
      CMP_OUT_tb    ==  'b0 &&
      CMP_Flag_tb   == 1'b0 &&
      Shift_OUT_tb  ==  'b0 &&
      Shift_Flag_tb == 1'b0 )
	  begin
	  $display("Test RST is PASSED Arith_OUT = %0b Carry_OUT = %0b Arith_Flag = %0b ",Arith_OUT_tb,Carry_OUT_tb,Arith_Flag_tb );
	  $display("Test RST is PASSED Logic_OUT = %0b Logic_Flag = %0b ",Logic_OUT_tb ,Logic_Flag_tb);
	  $display("Test RST is PASSED CMP_OUT = %0b CMP_Flag = %0b",CMP_OUT_tb,CMP_Flag_tb);
	  $display("Test RST is PASSED Shift_OUT = %0b  Shift_Flag = %0b",Shift_OUT_tb,Shift_Flag_tb);
     end
	 else
	   begin
	  $display("Test RST is FAILED Arith_OUT = %0b Carry_OUT = %0b Arith_Flag = %0b ",Arith_OUT_tb,Carry_OUT_tb,Arith_Flag_tb );
	  $display("Test RST is FAILED Logic_OUT = %0b Logic_Flag = %0b ",Logic_OUT_tb ,Logic_Flag_tb);
	  $display("Test RST is FAILED CMP_OUT = %0b CMP_Flag = %0b",CMP_OUT_tb,CMP_Flag_tb);
	  $display("Test RST is FAILED Shift_OUT = %0b  Shift_Flag = %0b",Shift_OUT_tb,Shift_Flag_tb);
	  end
#CLK_period
 $stop; 
end
endmodule
