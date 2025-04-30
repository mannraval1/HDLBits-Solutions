module top_module( 
    input a, 
    input b, 
    output out );
    // Implement a NOR Gate using a wire
    
    assign out = ~(a|b);
endmodule
