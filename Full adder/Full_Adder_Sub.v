module Full_Adder_Sub #(parameter width = 8)(
 input  wire  [width - 1 : 0] A,
 input  wire  [width - 1 : 0] B,
 input  wire                  Cin,
 
 output wire [width - 1 : 0] Sum,
 output wire                 Cout

);

 wire [width - 1 : 0] carry;
 wire [width - 1 : 0] B_new;
 wire                 M;
 
 assign M = Cin;

 genvar i;
 
  generate 
      assign B_new[0] = B[0]^M;
        OneBit_Full_Adder U0(.A(A[0]),
                             .B(B_new[0]),
							 .Sum(Sum[0]),
                             .Cin(M),
                             .Cout(carry[0])
								  );       
								  
     for(i=1;i<width;i=i+1)
	  begin
	   assign B_new[i] = B[i]^M;
	    OneBit_Full_Adder U1(.A(A[i]),
                             .B(B_new[i]),
							 .Sum(Sum[i]),
                             .Cin(carry[i-1]),
                             .Cout(carry[i])
								  );	
	  end
	  
	 assign Cout = carry[width-1]^ M;

  endgenerate
  
endmodule

