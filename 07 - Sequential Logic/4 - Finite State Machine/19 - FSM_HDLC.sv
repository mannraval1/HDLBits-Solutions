module top_module (
    input  clk,
    input  reset,    // Synchronous reset
    input  in,
    output disc,
    output flag,
    output err
);

    reg [3:0] state, next_state;

    localparam IDLE  = 4'd0;
    localparam S0    = 4'd1;  // One consecutive 1
    localparam S1    = 4'd2;  // Two consecutive 1s
    localparam S2    = 4'd3;  // Three consecutive 1s
    localparam S3    = 4'd4;  // Four consecutive 1s
    localparam S4    = 4'd5;  // Five consecutive 1s
    localparam S5    = 4'd6;  // Six consecutive 1s
    localparam S6    = 4'd7;  // Discard detected
    localparam S7    = 4'd8;  // Flag detected
    localparam ERROR = 4'd9;  // Seven or more consecutive 1s

    always @(*) begin
        // Default prevents inferred latches.
        next_state = state;

        case (state)
            IDLE: begin
                next_state = in ? S0 : IDLE;
            end

            S0: begin
                next_state = in ? S1 : IDLE;
            end

            S1: begin
                next_state = in ? S2 : IDLE;
            end

            S2: begin
                next_state = in ? S3 : IDLE;
            end

            S3: begin
                next_state = in ? S4 : IDLE;
            end

            // Five 1s have been received.
            S4: begin
                if (in)
                    next_state = S5;  // Sixth 1
                else
                    next_state = S6;  // 0111110: discard
            end

            // Six 1s have been received.
            S5: begin
                if (in)
                    next_state = ERROR; // Seventh 1
                else
                    next_state = S7;    // 01111110: flag
            end

            // The input that caused DISC was zero.
            S6: begin
                next_state = in ? S0 : IDLE;
            end

            // The input that caused FLAG was zero.
            S7: begin
                next_state = in ? S0 : IDLE;
            end

            // Remain in error while additional 1s arrive.
            ERROR: begin
                next_state = in ? ERROR : IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    assign disc = (state == S6);
    assign flag = (state == S7);
    assign err  = (state == ERROR);

endmodule