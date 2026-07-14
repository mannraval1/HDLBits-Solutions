module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack
);

    reg [3:0] state, next_state;
    reg [3:0] count_reg;
    reg [9:0] cycle_count;

    parameter A = 4'd0;  // Searching
    parameter B = 4'd1;  // Saw 1
    parameter C = 4'd2;  // Saw 11
    parameter D = 4'd3;  // Saw 110
    parameter E = 4'd4;  // Shift delay bit 1
    parameter F = 4'd5;  // Shift delay bit 2
    parameter G = 4'd6;  // Shift delay bit 3
    parameter H = 4'd7;  // Shift delay bit 4
    parameter I = 4'd8;  // Counting
    parameter J = 4'd9;  // Done

    wire shift_ena;
    wire thousand_done;
    wire count_ena;
    wire timer_finished;

    assign count = count_reg;

    assign shift_ena =
        (state == E) ||
        (state == F) ||
        (state == G) ||
        (state == H);

    assign counting = (state == I);
    assign done = (state == J);

    assign thousand_done = (cycle_count == 10'd999);

    assign count_ena =
        counting &&
        thousand_done &&
        (count_reg != 4'd0);

    assign timer_finished =
        counting &&
        thousand_done &&
        (count_reg == 4'd0);

    // Next-state logic
    always @(*) begin
        case (state)
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = data ? C : D;
            D: next_state = data ? E : A;

            E: next_state = F;
            F: next_state = G;
            G: next_state = H;
            H: next_state = I;

            I: next_state = timer_finished ? J : I;

            J: next_state = ack ? A : J;

            default: next_state = A;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Shift delay bits and decrement remaining count
    always @(posedge clk) begin
        if (reset) begin
            count_reg <= 4'd0;
        end else if (shift_ena) begin
            count_reg <= {count_reg[2:0], data};
        end else if (count_ena) begin
            count_reg <= count_reg - 1'b1;
        end
    end

    // Count each block of 1000 clock cycles
    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 10'd0;
        end else if (!counting) begin
            cycle_count <= 10'd0;
        end else if (thousand_done) begin
            cycle_count <= 10'd0;
        end else begin
            cycle_count <= cycle_count + 1'b1;
        end
    end

endmodule