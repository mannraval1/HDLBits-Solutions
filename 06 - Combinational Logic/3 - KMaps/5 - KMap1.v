module top_module (
    input [4:1] x, 
    output f );

    // Term 1: ~x[1] & x[3] (Covers the bottom-left 1s)
    // Term 2: x[2] & x[4]  (Covers the remaining 1s using don't-cares)
    assign f = (~x[1] & x[3]) | (x[2] & x[4]);

endmodule