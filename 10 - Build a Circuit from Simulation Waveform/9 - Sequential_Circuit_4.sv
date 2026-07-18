module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    // Combinational logic for the output
    assign q = a ^ b ^ state;

    // Sequential logic for the memory flip-flop
    always @(posedge clk) begin
        if (a == b) begin
            state <= a;
        end
    end

endmodule