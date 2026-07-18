module top_module (
    input clock,
    input a,
    output p,
    output q );

    // Latch: mirrors 'a' when clock is high
    always @(*) begin
        if (clock) begin
            p = a;
        end
    end

    // Flip-flop: captures 'p' on the negative edge of the clock
    always @(negedge clock) begin
        q <= p;
    end

endmodule