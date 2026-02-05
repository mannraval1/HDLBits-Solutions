module top_module (
    input        clk,
    input        reset,
    output       OneHertz,
    output [2:0] c_enable
);

    wire [3:0] q0, q1, q2;
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = c_enable[0] & (q0 == 4'd9);
    assign c_enable[2] = c_enable[1] & (q1 == 4'd9);

    assign OneHertz = c_enable[2] & (q2 == 4'd9);

    bcdcount c0 ( .clk(clk), .reset(reset), .enable(c_enable[0]), .Q(q0) );
    bcdcount c1 ( .clk(clk), .reset(reset), .enable(c_enable[1]), .Q(q1) );
    bcdcount c2 ( .clk(clk), .reset(reset), .enable(c_enable[2]), .Q(q2) );

endmodule
