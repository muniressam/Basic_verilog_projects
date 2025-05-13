library verilog;
use verilog.vl_types.all;
entity piso is
    port(
        rst             : in     vl_logic;
        frame_out       : in     vl_logic_vector(10 downto 0);
        parity_type     : in     vl_logic_vector(1 downto 0);
        stop_bits       : in     vl_logic;
        data_length     : in     vl_logic;
        send            : in     vl_logic;
        baud_out        : in     vl_logic;
        data_out        : out    vl_logic;
        p_parity_out    : out    vl_logic;
        tx_active       : out    vl_logic;
        tx_done         : out    vl_logic
    );
end piso;
