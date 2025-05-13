module baud_gen(
    input rst,
    input clock,
    input [1:0] baud_rate,
    output reg baud_out
);

    reg [31:0] counter;
    reg [31:0] threshold;

    always @(posedge clock or posedge rst) begin
        if (rst) begin
            counter <= 0;
            baud_out <= 0;
        end else begin
            if (counter >= threshold) begin
                counter <= 0;
                baud_out <= ~baud_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    always @(*) begin
        case (baud_rate)
            2'b00: threshold = 16'd1301;  // 2400 baud
            2'b01: threshold = 16'd650;  // 4800 baud
            2'b10: threshold = 16'd325;   // 9600 baud
            2'b11: threshold = 16'd162;   // 19.2K baud
            default: threshold = 16'd325; // Default to 9600 baud
        endcase
    end
endmodule