module OneBit_Full_Adder (
 input wire A,
 input wire B,
 input wire Cin,
 
 output wire sum,
 output wire Cout

);

 assign sum  = A^B^Cin;
 assign Cout = A&B | Cin(A|B);
 
endmodule
 
 