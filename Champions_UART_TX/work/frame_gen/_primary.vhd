library verilog;
use verilog.vl_types.all;
entity frame_gen is
    port(
        rst             : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        parity_out      : in     vl_logic;
        parity_type     : in     vl_logic_vector(1 downto 0);
        stop_bits       : in     vl_logic;
        data_length     : in     vl_logic;
        frame_out       : out    vl_logic_vector(10 downto 0)
    );
end frame_gen;
