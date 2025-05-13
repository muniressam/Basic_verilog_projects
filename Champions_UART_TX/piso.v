module piso (
    input wire       rst,
    input wire [10:0] frame_out,
    input wire [1:0]  parity_type,
    input wire       stop_bits,
    input wire       data_length,
    input wire       send,
    input wire       baud_out,
    
    output reg       data_out,
    output reg       p_parity_out,
    output reg       tx_active,
    output reg       tx_done
);

reg [10:0] shift_reg;
reg [3:0]  count;
reg        sending;

always @(posedge baud_out or posedge rst) begin
    if (rst) begin
        shift_reg    <= 11'b0;
        count        <= 4'b0;
        sending      <= 1'b0;
        
        data_out     <= 1'b1; // Idle state for UART is high
        p_parity_out <= 1'b0;
        tx_active    <= 1'b0;
        tx_done      <= 1'b0;
        
    end else if (send && !sending) begin
        shift_reg <= frame_out;
        count     <= (stop_bits ? (data_length ? 4'd10 : 4'd9) : (data_length ? 4'd9 : 4'd8));
        tx_active <= 1'b1;
        tx_done   <= 1'b0;
        sending   <= 1'b1;
        
    end else if (sending) begin
        data_out  <= shift_reg[0];
        shift_reg <= shift_reg >> 1;
        count     <= count - 1;
        
        if (count == 0) begin
            tx_active <= 1'b0;
            tx_done   <= 1'b1;
            sending   <= 1'b0;
        end
    end else begin
        tx_done <= 1'b0;
    end
end

// Calculate parity output for parallel odd parity
always @(posedge baud_out or posedge rst) begin
    if (rst) begin
        p_parity_out <= 1'b0;
    end else if (parity_type == 2'b11 && send && !sending) begin
        p_parity_out <= ^frame_out[8:1]; // Calculate odd parity for data bits
    end
end

endmodule