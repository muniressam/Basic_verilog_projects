library verilog;
use verilog.vl_types.all;
entity parity is
    generic(
        width           : integer := 8
    );
    port(
        rst             : in     vl_logic;
        data_in         : in     vl_logic_vector;
        parity_type     : in     vl_logic_vector(1 downto 0);
        parity_out      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 2;
end parity;
