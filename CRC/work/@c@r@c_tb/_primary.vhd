library verilog;
use verilog.vl_types.all;
entity CRC_tb is
    generic(
        CRC_WD_tb       : integer := 8;
        CLK_PERIOD      : integer := 100;
        Test_Cases      : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CRC_WD_tb : constant is 1;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of Test_Cases : constant is 1;
end CRC_tb;
