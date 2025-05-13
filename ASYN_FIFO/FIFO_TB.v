`timescale 1ns/1ps
module FIFO_TB #(parameter Data_width = 8 , parameter p_width = 4);

parameter wclk_period = 10 ;
parameter rclk_period = 25 ;

reg                      W_CLK  ;
reg                      W_RST  ;
reg                      R_CLK  ;
reg                      R_RST  ;
reg                      W_INC  ;
reg                      R_INC  ;
reg  [Data_width-1:0]    WR_DATA ;
wire [Data_width-1:0]    RD_DATA ;
wire                     FULL  ;
wire                     EMPTY ;

FIFO_TOP #(.width(Data_width), .p_width(p_width)) DUT (
.W_CLK(W_CLK),
.W_RST(W_RST),
.R_CLK(R_CLK),
.R_RST(R_RST),
.W_INC(W_INC),
.R_INC(R_INC),
.WR_DATA(WR_DATA),
.RD_DATA(RD_DATA),
.FULL(FULL),
.EMPTY(EMPTY)

);

always #(wclk_period/2) W_CLK = ~W_CLK ;
always #(rclk_period/2) R_CLK = ~R_CLK ;

initial begin
    $dumpfile("fifo.vcd");
    $dumpvars;

    Initialize();
    Reset();
	
    WriteData(8'hAA);
    WriteData(8'hBC);
    WriteData(8'h6F);
	WriteData(8'hFF);

    ReadData();
    ReadData();
    ReadData();
	ReadData();

    #(rclk_period)

    if (EMPTY) begin
        $display("FIFO is Empty");
    end
    else begin
        $display("FIFO isn't Empty");
    end

    WriteData(8'hA5);
    WriteData(8'hC3);
    WriteData(8'h32);
    WriteData(8'hFF);
    WriteData(8'h92);
    WriteData(8'hD7);
    WriteData(8'h55);
    WriteData(8'h4F);

    #(wclk_period)

    if (FULL) begin
       $display("FIFO is Full"); 
    end
    else begin
       $display("FIFO isn't Full");
    end

    #100
    $stop;
end


task Initialize();
    begin
        W_CLK = 1'b0 ;
        R_CLK = 1'b0 ;
        W_INC = 1'b0 ;
        R_INC = 1'b0 ;
    end
endtask

task Reset();
    begin
        #(wclk_period)
        W_RST = 1'b0 ;
        R_RST = 1'b0 ;
        #(wclk_period) 
        W_RST = 1'b1 ;
        R_RST = 1'b1 ;
    end
endtask

task WriteData;
    input [Data_width-1:0] WD ;
    begin
        #(2*wclk_period)
        WR_DATA= WD ;
        W_INC  = 1'b1    ;
        #(wclk_period)
        W_INC  = 1'b0    ;
    end
endtask

task ReadData();
    begin
        #(2*rclk_period)
        R_INC = 1'b1 ;
        #(rclk_period)
        R_INC = 1'b0 ;
    end
endtask
endmodule