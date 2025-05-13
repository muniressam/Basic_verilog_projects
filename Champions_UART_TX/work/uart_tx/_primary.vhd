library verilog;
use verilog.vl_types.all;
entity uart_tx is
    port(
        clock           : in     vl_logic;
        rst             : in     vl_logic;
        send            : in     vl_logic;
        baud_rate       : in     vl_logic_vector(1 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        parity_type     : in     vl_logic_vector(1 downto 0);
        stop_bits       : in     vl_logic;
        data_length     : in     vl_logic;
        data_out        : out    vl_logic;
        p_parity_out    : out    vl_logic;
        tx_active       : out    vl_logic;
        tx_done         : out    vl_logic
    );
end uart_tx;
