module FIFO_TOP #(parameter width = 8 , parameter p_width = 4)
(
input wire [width-1:0] WR_DATA ,
input wire             W_INC   ,
input wire             W_CLK   ,
input wire             W_RST   ,
input wire             R_INC   ,
input wire             R_CLK   ,
input wire             R_RST   ,
 
output wire             FULL   ,
output wire             EMPTY  ,
output wire [width-1:0] RD_DATA

);
 wire [p_width-1:0] waddr, wptr, wq2_rptr;
 wire [p_width-1:0] raddr, rptr, rq2_wptr; 
 
 FIFO_MEM #(.width(width),.p_width(p_width)) U_MEM (
.wdata(WR_DATA),
.winc(W_INC),
.wfull(FULL),
.wclk(W_CLK),
.wrst_n(W_RST),
.waddr(waddr),
.raddr(raddr),
.rdata(RD_DATA)
 );
 
 DF_SYNC #(.p_width(p_width)) U_W2R (
.ptr(wptr),
.clk(W_CLK),
.rst(W_RST),
.sync_out(rq2_wptr)
 );
 
 DF_SYNC  #(.p_width(p_width)) U_R2W (
.ptr(rptr),
.clk(R_CLK),
.rst(R_RST),
.sync_out(wq2_rptr)
 );
 
 FIFO_WR  #(.p_width(p_width)) U_WR (
.winc(W_INC),
.wclk(W_CLK),
.wrst_n(W_RST),
.wq2_rptr(wq2_rptr),
.wptr(wptr),
.waddr(waddr),
.wfull(FULL) 
 
 );
 
 FIFO_RD  #(.p_width(p_width)) U_RD (
.rinc(R_INC),
.rclk(R_CLK),
.rrst_n(R_RST),
.rq2_wptr(rq2_wptr),
.rptr(rptr),
.raddr(raddr),
.rempty(EMPTY) 
 
 );
 
endmodule