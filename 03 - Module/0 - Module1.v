module top_module ( input a, input b, output out );

/*
	create one instance of module mod_a,
    then connect the module's three pins (in1, in2, and out) 
    to your top-level module's three ports (wires a, b, and out).
*/
    mod_a instance_1(a,b,out);
endmodule
