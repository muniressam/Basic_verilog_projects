library verilog;
use verilog.vl_types.all;
entity baud_gen is
    port(
        rst             : in     vl_logic;
        clock           : in     vl_logic;
        baud_rate       : in     vl_logic_vector(1 downto 0);
        baud_out        : out    vl_logic
    );
end baud_gen;
