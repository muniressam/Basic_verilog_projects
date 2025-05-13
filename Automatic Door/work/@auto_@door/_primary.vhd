library verilog;
use verilog.vl_types.all;
entity Auto_Door is
    port(
        UP_Max          : in     vl_logic;
        DN_Max          : in     vl_logic;
        Activate        : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        UP_M            : out    vl_logic;
        DN_M            : out    vl_logic
    );
end Auto_Door;
