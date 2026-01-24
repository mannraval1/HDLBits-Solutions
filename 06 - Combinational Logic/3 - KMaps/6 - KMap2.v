module top_module (
    input [4:1] x,
    output f 
);

    // Term 1: ~x[2] & ~x[4] (Wraparound corners)
    // Term 2: ~x[1] & x[3]  (Bottom-left 2x2 block)
    // Term 3: x[2] & x[3] & x[4] (To cover the 1 at 11,11)
    
    assign f = (~x[2] & ~x[4]) | (~x[1] & x[3]) | (x[2] & x[3] & x[4]);

endmodule