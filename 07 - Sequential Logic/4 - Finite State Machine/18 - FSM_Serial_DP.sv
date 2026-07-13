module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

    parameter IDLE  = 3'd0;
    parameter DATA  = 3'd1;
    parameter STOP  = 3'd2;
    parameter DONE  = 3'd3;
    parameter ERROR = 3'd4;

    wire odd;

    reg [2:0] state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data_in;

    wire parity_reset;

    assign parity_reset = reset || (state != DATA);

    parity parity1(
        .clk(clk),
        .reset(parity_reset),
        .in(in),
        .odd(odd)
    );

    always @(*) begin
        case (state)
            IDLE: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = DATA;
            end

            DATA: begin
                if (bit_count == 4'd8)
                    next_state = STOP;   // 8 data bits + parity bit
                else
                    next_state = DATA;
            end

            STOP: begin
                if (!in)
                    next_state = ERROR;
                else if (odd)
                    next_state = DONE;
                else
                    next_state = IDLE;
            end

            DONE: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = DATA;
            end

            ERROR: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end

            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'd0;
            data_in <= 8'd0;
        end else begin
            state <= next_state;

            if (state == DATA) begin
                if (bit_count < 4'd8)
                    data_in[bit_count] <= in;   // only store data bits

                if (bit_count == 4'd8)
                    bit_count <= 4'd0;
                else
                    bit_count <= bit_count + 1'b1;
            end else begin
                bit_count <= 4'd0;
            end
        end
    end

    assign done = (state == DONE);
    assign out_byte = done ? data_in : 8'bx;

endmodule