module top_module (
    input  clk,
    input  reset,   // Synchronous reset
    input  s,
    input  w,
    output reg z
);

    localparam A = 1'b0;
    localparam B = 1'b1;

    reg state;
    reg next_state;

    // Number of w samples already collected in the current group
    reg [1:0] cycle_count;

    // Number of 1s collected in the current group
    reg [1:0] ones_count;

    // Next-state combinational logic
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                // Once state B is entered, stay there permanently.
                next_state = B;
            end

            default: begin
                next_state = A;
            end
        endcase
    end

    // State register, counters, and output logic
    always @(posedge clk) begin
        if (reset) begin
            state       <= A;
            cycle_count <= 2'd0;
            ones_count  <= 2'd0;
            z           <= 1'b0;
        end
        else begin
            state <= next_state;

            if (state == A) begin
                // Do not examine w while waiting for s.
                cycle_count <= 2'd0;
                ones_count  <= 2'd0;
                z           <= 1'b0;
            end
            else begin
                // State B
                if (cycle_count == 2'd2) begin
                    // Current w is the third sample.
                    // Include it before determining the result.
                    if ((ones_count + w) == 2'd2)
                        z <= 1'b1;
                    else
                        z <= 1'b0;

                    // Begin a new group of three samples.
                    cycle_count <= 2'd0;
                    ones_count  <= 2'd0;
                end
                else begin
                    // First or second sample.
                    cycle_count <= cycle_count + 1'b1;
                    ones_count  <= ones_count + w;
                    z           <= 1'b0;
                end
            end
        end
    end

endmodule