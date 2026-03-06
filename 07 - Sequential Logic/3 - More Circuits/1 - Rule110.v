module top_module(
    input  clk,
    input  load,
    input  [511:0] data,
    output reg [511:0] q
);

    wire [511:0] L = {1'b0, q[511:1]};   // L[i] = q[i-1], L[0]=0
    wire [511:0] R = {q[510:0], 1'b0};   // R[i] = q[i+1], R[511]=0

    wire [511:0] next = ((~L) & q) | (q ^ R) | ((~q) & R);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next;
    end

endmodule