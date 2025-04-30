`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 

	/*
	   Create two wermediate wires and connect AND and OR gates together
	   The wire feeds the NOT gate is wire out 
	   The second wire is the inverted output
	*/
    wire w1, w2;

	assign w1 = a & b;
	assign w2 = c & d;
	
	assign out = w1 | w2;
	assign out_n = ~out;

endmodule
