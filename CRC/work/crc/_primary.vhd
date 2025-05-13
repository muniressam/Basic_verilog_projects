library verilog;
use verilog.vl_types.all;
entity crc is
    generic(
        width           : integer := 8;
        seed            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0);
        taps            : vl_logic_vector(0 to 6) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0)
    );
    port(
        data            : in     vl_logic;
        active          : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        crc             : out    vl_logic;
        valid           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of seed : constant is 1;
    attribute mti_svvh_generic_type of taps : constant is 1;
end crc;
