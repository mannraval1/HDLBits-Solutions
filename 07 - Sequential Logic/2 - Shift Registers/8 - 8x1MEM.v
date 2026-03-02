module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg [7:0] q;

    always @(posedge clk) begin
        if (enable) begin
            q[0] <= S;
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2];
            q[4] <= q[3];
            q[5] <= q[4];
            q[6] <= q[5];
            q[7] <= q[6];
        end
    end

    wire m0, m1, m2, m3;
    wire n0, n1;

    assign m0 = C ? q[1] : q[0];
    assign m1 = C ? q[3] : q[2];
    assign m2 = C ? q[5] : q[4];
    assign m3 = C ? q[7] : q[6];

    assign n0 = B ? m1 : m0;
    assign n1 = B ? m3 : m2;

    assign Z  = A ? n1 : n0;

endmodule