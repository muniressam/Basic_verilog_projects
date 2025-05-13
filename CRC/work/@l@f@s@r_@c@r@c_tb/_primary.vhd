library verilog;
use verilog.vl_types.all;
entity LFSR_CRC_tb is
    generic(
        CRC_width       : integer := 8;
        Test_Cases      : integer := 10;
        CLK_PERIOD      : integer := 100
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CRC_width : constant is 1;
    attribute mti_svvh_generic_type of Test_Cases : constant is 1;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
end LFSR_CRC_tb;
