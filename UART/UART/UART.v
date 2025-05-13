module UART #(parameter  width  = 8)
(
 input wire                   RST      ,
///////////inputs of RX//////  
 input wire                   CLK_RX   ,
 input wire                   RX_IN    ,
/////////////output of RX////
 output wire [width - 1 : 0]  RX_P_DATA,
 output wire                  RX_D_VLD ,
/////////////inputs of TX//// 
 input wire  [width - 1 : 0]  TX_P_DATA,
 input wire                   TX_D_VLD ,
 input wire                   CLK_TX   ,
/////////////output of TX////
 output wire                  TX_OUT   , 
 output wire                  Busy     ,
////////////confg inputs/////
 input wire   [5:0]           PRESCALE ,
 input wire                   PAR_EN   ,
 input wire                   PAR_TYP  ,
////////////confg outputs////
 output wire                  par_err  ,
 output wire                  stp_err      

);

UART_RX  #(.width(width)) U0_RX (
.RX_IN(RX_IN),
.PRESCALE(PRESCALE),
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.CLK_RX(CLK_RX),
.RST_RX(RST),
.DATA_VALID_RX(RX_D_VLD),
.P_DATA_RX(RX_P_DATA),
.par_err(par_err),
.stp_err(stp_err)

);


UART_TX #(.width(width)) U1_TX (
.P_DATA_TX(TX_P_DATA),
.DATA_VALID_TX(TX_D_VLD),
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.CLK_TX(CLK_TX),
.RST_TX(RST),
.TX_OUT(TX_OUT),
.Busy(Busy)

);

endmodule