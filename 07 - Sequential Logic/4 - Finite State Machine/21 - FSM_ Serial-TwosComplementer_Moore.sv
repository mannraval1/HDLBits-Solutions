module top_module (
    input  clk,
    input  areset,
    input  x,
    output z
);

    reg [1:0] state;
    reg [1:0] next_state;

    localparam WAIT_FOR_ONE = 2'd0;
    localparam OUTPUT_ONE   = 2'd1;
    localparam OUTPUT_ZERO  = 2'd2;

    // Next-state combinational logic
    always @(*) begin
        case (state)

            // First 1 has not been received yet.
            WAIT_FOR_ONE: begin
                if (x == 1'b0)
                    next_state = WAIT_FOR_ONE;
                else
                    next_state = OUTPUT_ONE;
            end

            // First 1 has already been received.
            OUTPUT_ONE: begin
                if (x == 1'b0)
                    next_state = OUTPUT_ONE;
                else
                    next_state = OUTPUT_ZERO;
            end

            // First 1 has already been received.
            OUTPUT_ZERO: begin
                if (x == 1'b0)
                    next_state = OUTPUT_ONE;
                else
                    next_state = OUTPUT_ZERO;
            end

            default: begin
                next_state = WAIT_FOR_ONE;
            end

        endcase
    end

    // State register with asynchronous active-high reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WAIT_FOR_ONE;
        else
            state <= next_state;
    end

    // Moore output logic: z depends only on the current state
    assign z = (state == OUTPUT_ONE);

endmodule
