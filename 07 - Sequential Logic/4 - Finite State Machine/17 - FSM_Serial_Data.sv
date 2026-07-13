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

    reg [2:0] state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data_in;

    always @(*) begin
        case (state)
            IDLE: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = DATA;   // start bit detected, next bit is data[0]
            end

            DATA: begin
                if (bit_count == 4'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in)
                    next_state = DONE;   // valid stop bit
                else
                    next_state = ERROR;  // bad stop bit
            end

            DONE: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = DATA;   // back-to-back new start bit
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
                data_in[bit_count] <= in;   // LSB first

                if (bit_count == 4'd7)
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