module top_module (
    input  [3:0] SW,     // R[3:0]
    input  [3:0] KEY,    // KEY[0]=clk, KEY[1]=E, KEY[2]=L, KEY[3]=w
    output [3:0] LEDR    // Q[3:0]
);

    wire [3:0] Q;

    // 4-bit shift register made from 4 copies of MUXDFF
    // Bit 3 is the leftmost stage (gets serial input w).
    MUXDFF u3 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(KEY[3]), .R(SW[3]), .Q(Q[3]));
    MUXDFF u2 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(Q[3]),   .R(SW[2]), .Q(Q[2]));
    MUXDFF u1 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(Q[2]),   .R(SW[1]), .Q(Q[1]));
    MUXDFF u0 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(Q[1]),   .R(SW[0]), .Q(Q[0]));

    assign LEDR = Q;

endmodule


// Reuse of exams/2014_q4a: MUX -> MUX -> DFF
module MUXDFF (
    input  clk,
    input  E,
    input  L,
    input  w,
    input  R,
    output reg Q
);
    wire d_shift_or_hold = (E) ? w : Q;    // E=1 shift in w, E=0 hold
    wire d_next          = (L) ? R : d_shift_or_hold; // L=1 load R, else shift/hold

    always @(posedge clk) begin
        Q <= d_next;
    end
endmodule