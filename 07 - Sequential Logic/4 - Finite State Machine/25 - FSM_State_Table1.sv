module top_module (
    input        clk,
    input  [2:0] y,
    input        x,
    output       Y0,
    output       z
);

    // Y[0] of the next state
    assign Y0 = (~x & (y[0] | y[2])) |
                ( x & ~y[0] & ~y[2]);

    // z = 1 for present states 011 and 100
    assign z = (~y[2] &  y[1] &  y[0]) |
               ( y[2] & ~y[1] & ~y[0]);

endmodule