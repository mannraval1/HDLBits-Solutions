module top_module( 
    input a, 
    input b, 
    output out );
// Implement a XNOR Gate 
    assign out = ~(a ^ b);
endmodule
