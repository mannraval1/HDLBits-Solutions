module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output reg [31:0] q
);
    reg [31:0] next_q;
    wire fb = q[0];

    always @(*) begin
        next_q = q >> 1;              // shift right by 1

        if (fb) begin
            next_q[31] = next_q[31] ^ 1'b1;   // tap at 32
            next_q[21] = next_q[21] ^ 1'b1;   // tap at 22
            next_q[1]  = next_q[1]  ^ 1'b1;   // tap at 2
            next_q[0]  = next_q[0]  ^ 1'b1;   // tap at 1
        end
    end

    always @(posedge clk) begin
        if (reset)
            q <= 32'h00000001;
        else
            q <= next_q;
    end
endmodule
