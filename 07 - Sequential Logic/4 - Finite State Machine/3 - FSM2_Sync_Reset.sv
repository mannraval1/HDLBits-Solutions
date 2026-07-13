module top_module(
    input clk,
    input reset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out
);

    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next_state;

    // Next-state logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end

            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end

            default: next_state = OFF;
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Moore output
    assign out = (state == ON);

endmodule