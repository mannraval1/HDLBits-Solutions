module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    /*
    	
Port in mod_a	Port in top_module
output out1	out1
output out2	out2
input in1	a
input in2	b
input in3	c
input in4	d
    */
    mod_a inst1(.out1(out1), .out2(out2), .in1(a), .in2(b), .in3(c),.in4(d)); 

endmodule
