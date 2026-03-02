module top_module (
    input  [2:0] SW,      // r
    input  [1:0] KEY,     // KEY[0]=clk, KEY[1]=L
    output [2:0] LEDR     // Q
);

    reg [2:0] Q;

    always @(posedge KEY[0]) begin
        if (KEY[1]) begin
            Q <= SW;                       // load: Q2Q1Q0 = r2r1r0
        end else begin
            Q <= { Q[1] ^ Q[2],            // Q2_next = Q1 XOR Q2
                   Q[0],                   // Q1_next = Q0
                   Q[2] };                 // Q0_next = Q2
        end
    end

    assign LEDR = Q;

endmodule
