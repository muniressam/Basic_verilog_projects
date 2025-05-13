module ALU_Top #(parameter width = 16 ,
                   Arith_width = width + width ,
                   Logic_width = width,	
                   CMP_width   = width,
                   Shift_width = width)(
                   
input wire [width-1:0] A,
input wire [width-1:0] B,
input wire CLK,
input wire RST,
input wire [3:0] ALU_FUN,

output wire [Arith_width-1:0]  Arith_OUT,
output wire                    Carry_OUT,
output wire                    Arith_Flag,
output wire [Logic_width-1:0]  Logic_OUT, // out will be 1 or 0
output wire                    Logic_Flag,
output wire [CMP_width-1:0]    CMP_OUT,   // out will be 1 or 0
output wire                    CMP_Flag,
output wire [Shift_width-1:0]  Shift_OUT,
output wire                    Shift_Flag
);
wire Arith_Enable ,Logic_Enable , CMP_Enable , Shift_Enable;

DECODER u_decoder(
.ALU_FUN(ALU_FUN[3:2]),
.Arith_Enable(Arith_Enable),
.Logic_Enable(Logic_Enable),
.CMP_Enable(CMP_Enable),
.Shift_Enable(Shift_Enable)
);

ARITHMETIC_UNIT #(.width(width),.Arith_width(Arith_width)) u_arithmatic(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.CLK(CLK),
.RST(RST),
.Arith_Enable(Arith_Enable),
.Arith_OUT(Arith_OUT),
.Carry_OUT(Carry_OUT),
.Arith_Flag(Arith_Flag)
);

LOGIC_UNIT #(.width(width),.Logic_width(Logic_width)) u_logic(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.CLK(CLK),
.RST(RST),
.Logic_Enable(Logic_Enable),
.Logic_OUT(Logic_OUT),
.Logic_Flag(Logic_Flag)
);

CMP_UNIT #(.width(width),.CMP_width(CMP_width)) u_cmp(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.CLK(CLK),
.RST(RST),
.CMP_Enable(CMP_Enable),
.CMP_OUT(CMP_OUT),
.CMP_Flag(CMP_Flag)
);

SHIFT_UNIT #(.width(width),.Shift_width(Shift_width)) u_shift(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.CLK(CLK),
.RST(RST),
.Shift_Enable(Shift_Enable),
.Shift_OUT(Shift_OUT),
.Shift_Flag(Shift_Flag)
);

endmodule





