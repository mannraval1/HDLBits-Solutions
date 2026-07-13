module top_module (
    input  clk,
    input  areset,
    input  x,
    output reg z
);

    reg state, next_state;

    localparam COPY   = 1'b0;
    localparam INVERT = 1'b1;

    // Next-state and Mealy output logic
    always @(*) begin
        // Default assignments
        next_state = state;
        z = 1'b0;

        case (state)

            // Copy bits until and including the first 1
            COPY: begin
                z = x;

                if (x == 1'b1)
                    next_state = INVERT;
                else
                    next_state = COPY;
            end

            // Invert every bit after the first 1
            INVERT: begin
                z = ~x;
                next_state = INVERT;
            end

            default: begin
                z = 1'b0;
                next_state = COPY;
            end

        endcase
    end

    // State register with asynchronous active-high reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= COPY;
        else
            state <= next_state;
    end

endmodule