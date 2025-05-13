module Register_File #(parameter Addr  = 4,
                       parameter width = 8,
					   parameter depth = 16
)(
input wire [width-1:0]  WrData,
input wire [Addr -1:0]  Address,
input wire              WrEn,
input wire              RdEn,
input wire              CLK,
input wire              RST,

output reg              RdData_Valid,
output reg  [width-1:0] RdData,
output wire [width-1:0] REG0,
output wire [width-1:0] REG1,
output wire [width-1:0] REG2,
output wire [width-1:0] REG3

);

reg [width-1:0] Reg_File [depth-1:0] ;
integer i;

always @(posedge CLK , negedge RST)
begin
if(!RST)
 begin
 RdData   <= 'b0 ;
 RdData_Valid <= 1'b0;
  for(i=0 ; i<depth ; i=i+1) begin
     if(i==2) begin
	     Reg_File[i] <= 'b100000_01;//par_en = 1 , par_type = 0 , prescale = 32
	 end else if (i==3) begin
	     Reg_File[i] <= 'b10_0000;
	 end else begin
	     Reg_File[i] <= 'b0;
	 end
  end
 end
else
 begin
    if(WrEn & !RdEn)
	  begin
	     Reg_File[Address] <= WrData;
	  end
	else if(RdEn & !WrEn)
	  begin
	     RdData <= Reg_File[Address] ;
		 RdData_Valid <= 1'b1;
	  end

 end
 end
 
assign REG0 = Reg_File[0];
assign REG1 = Reg_File[1];
assign REG2 = Reg_File[2];
assign REG3 = Reg_File[3];

 endmodule