module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire wire1;
    wire [31:0] bXOR;
    wire cout;

    assign bXOR = b ^ ({32{sub}});
    assign cout = sub ? (a[31] ^ bXOR[31]) : (a[31] ^ b[31]);

    adder1 add16(a[15:0], bXOR[15:0], sub, sum[15:0], wire1);
    adder2 add16(a[31:16], bXOR[31:16], wire1, sum[31:16], cout);

endmodule bXOR = b ^ {32{sub}};

    adder1 add16(a[15:0], bXOR[15:0], sub, sum[15:0], wire1);
    adder2 add16(a[31:16], bXOR[31:16], wire1, sum[31:16], cout);

endmodule


/*
    An adder-subtractor can be built from an adder by optionally negating one of the inputs, which is equivalent to inverting the input then adding 1.
    The net result is a circuit that can do two operations: 
    (a + b + 0) and (a + ~b + 1).
    Use a 32-bit wide XOR gate to invert the b input whenever sub is 1. (This can also be viewed as b[31:0] XORed with sub replicated 32 times
*/