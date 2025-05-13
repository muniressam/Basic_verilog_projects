module UART_RX  #(parameter width = 8) (
 input wire RX_IN,
 input wire [5:0] PRESCALE,
 input wire PAR_EN,
 input wire PAR_TYP,
 input wire CLK_RX,
 input wire RST_RX,
 
 output wire par_err,
 output wire stp_err,
 output wire DATA_VALID_RX,
 output wire [width - 1 : 0] P_DATA_RX

);

wire [3:0] bit_cnt;
wire [5:0] edge_cnt;
wire enable_count;
wire dat_samp_en ;
wire sampled_bit;
wire deser_en;
wire par_chk_en;
wire stp_chk_en;
wire strt_chk_en;
wire strt_glitch;


 
parity_check  u_parity_check(
.PAR_TYP(PAR_TYP),
.par_chk_en(par_chk_en),
.sampled_bit(sampled_bit),
.clk(CLK_RX),
.rst(RST_RX),
.par_err(par_err)

);

start_check u_start_check (
.strt_chk_en(strt_chk_en),
.sampled_bit(sampled_bit),
.clk(CLK_RX) ,
.rst(RST_RX),
.strt_glitch(strt_glitch)

);

stop_check u_stop_check (
.stp_chk_en (stp_chk_en),
.sampled_bit(sampled_bit),
.clk(CLK_RX),
.rst(RST_RX),
.stp_err(stp_err)

);

data_sampling u_data_sampling (
.RX_IN(RX_IN),
.dat_samp_en(dat_samp_en),
.edge_cnt(edge_cnt),
.PRESCALE(PRESCALE),
.clk(CLK_RX),
.rst(RST_RX),
.sampled_bit(sampled_bit)

);

deserializer #(.width(width)) u_deserializer  (
.deser_en(deser_en),
.sampled_bit(sampled_bit),
.clk(CLK_RX),
.rst(RST_RX),
.PRESCALE(PRESCALE),
.edge_cnt(edge_cnt),
.P_DATA(P_DATA_RX)

);

edge_bit_counter u_edge_bit_counter (
.enable_count(enable_count),
.clk(CLK_RX),
.rst(RST_RX),
.PRESCALE(PRESCALE),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt)

);

FSM_RX u_FSM_RX (
.RX_IN(RX_IN),
.PAR_EN(PAR_EN),
.PRESCALE(PRESCALE),
.edge_cnt(edge_cnt),
.bit_cnt(bit_cnt),
.clk(CLK_RX),
.rst(RST_RX),
.par_err(par_err),
.strt_glitch(strt_glitch),
.stp_err(stp_err),

.dat_samp_en(dat_samp_en),
.enable_count(enable_count),
.deser_en(deser_en),
.DATA_VALID(DATA_VALID_RX),
.stp_chk_en (stp_chk_en),
.strt_chk_en(strt_chk_en),
.par_chk_en(par_chk_en)

);

endmodule