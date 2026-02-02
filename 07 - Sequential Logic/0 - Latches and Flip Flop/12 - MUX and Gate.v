module top_module (
    input clk,
    input x,
    output z
); 

    reg q_top, q_mid, q_bot;

    always @(posedge clk) begin
        // Top FF: XOR feedback from Q
        q_top <= x ^ q_top;
        
        // Middle FF: AND feedback from Q_bar (~q_mid)
        q_mid <= x & ~q_mid;
        
        // Bottom FF: OR feedback from Q_bar (~q_bot)
        q_bot <= x | ~q_bot;
    end

    // Output is NOR of all three Q outputs
    assign z = ~(q_top | q_mid | q_bot);

endmodule