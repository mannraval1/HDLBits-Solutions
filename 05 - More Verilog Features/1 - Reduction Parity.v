module top_module (
    input [7:0] in,
    output parity); 
/*
	The Even parity is calculated by XORing all the input bits
*/
    assign parity = ^ in;
    
endmodule
