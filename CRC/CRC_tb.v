`timescale 1ns/1ps

module crc_tb();

parameter CRC_width  = 8 ;
parameter Test_Cases = 10 ;
parameter CLK_PERIOD = 100 ;

reg  Data_tb;
reg  Active_tb;
reg  CLK_tb;
reg  RST_tb;
wire valid_tb;
wire CRC_tb;

integer operation;

reg [CRC_width-1:0] Data_Type     [Test_Cases-1:0];
reg [CRC_width-1:0]  EXP_OUT       [Test_Cases-1:0];



initial begin
    $dumpfile("crc.vcd");
    $dumpvars;

    $readmemh("DATA_h.txt",Data_Type);
    $readmemh("Expec_Out_h.txt",EXP_OUT);

    initialize();

    for(operation=0;operation<Test_Cases;operation=operation+1)
        begin
            Reset();
            Read_OP(Data_Type[operation]);
            OUT_OP(EXP_OUT[operation],operation);
        end

        #100
        $stop;
end

task initialize(); 
    begin
       Data_tb   = 1'b0;
       Active_tb = 1'b0;
       CLK_tb    = 1'b0;
       RST_tb    = 1'b0; 
    end
endtask

task Reset();
    begin
        RST_tb = 1'b1;
        #CLK_PERIOD
        RST_tb = 1'b0;
        #CLK_PERIOD
        RST_tb = 1'b1;  
    end
endtask

task Read_OP;
input   [CRC_width-1:0] Data_in;

integer i;

    begin
        Active_tb = 1'b1;
        for(i=0;i<CRC_width;i=i+1)
            begin
                Data_tb = Data_in[i];
                #CLK_PERIOD;
            end       
        Active_tb = 1'b0;

    end
endtask

task OUT_OP ;
    input          [CRC_width-1:0] Expec_OUT;
    input integer                  oper_num;

    reg            [CRC_width-1:0] Gener_OUT;

    integer i;

        begin
            @(posedge valid_tb)
            for(i=0;i<CRC_width;i=i+1)
                begin
                    #CLK_PERIOD    Gener_OUT[i] = CRC_tb;
                end
            if (Gener_OUT == Expec_OUT)
                begin
                    $display("Test %d is Passed OUT %h and EXP OUT %h",oper_num,Gener_OUT,Expec_OUT);
                end    
            else
                begin
                    $display("Test %d is Failed OUT %h and EXP OUT %h",oper_num,Gener_OUT,Expec_OUT);
                end    
        end
endtask

always #(CLK_PERIOD/2) CLK_tb = ~CLK_tb;

CRC DUT (
    .Data(Data_tb),
    .Active(Active_tb),
    .CLK(CLK_tb),
    .RST(RST_tb),
    .valid(valid_tb),
    .CRC(CRC_tb)
);

endmodule