module top_module( 
    input a,b,c,
    output w,x,y,z );
// Problem Statement
// Make connections through the wires such that 
// The wires are internally connected and there is no need on making new connections
// a -> w
// b -> x
// b -> y
// c -> z

assign w = a;
assign x = b;
assign y = b;
assign z = c;
endmodule
