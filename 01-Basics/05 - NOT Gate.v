module top_module( input in, output out );
// Implmenet a circuit similar to wire, but with a slight difference 
    // When making connection form the wire in to the wire out, implement an inverter
    // instead of simple wire

    assign out = ~in;

endmodule
