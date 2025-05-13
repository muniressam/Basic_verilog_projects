library verilog;
use verilog.vl_types.all;
entity baudGen is
    generic(
        freq            : integer := 50000000
    );
    port(
        clock           : in     vl_logic;
        rst             : in     vl_logic;
        baud_rate       : in     vl_logic_vector(1 downto 0);
        baud_out        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of freq : constant is 1;
end baudGen;
