module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout1, cout2;
    add16 add1(a[15:0],b[15:0],0, sum[15:0],cout1);
    add16 add2(a[31:16],b[31:16],cout1, sum[31:16],cout2);    
    

endmodule

/*
a module add16 that performs a 16-bit addition.
Instantiate two of them to create a 32-bit adder. 
One add16 module computes the lower 16 bits of the addition result, 
while the second add16 module computes the upper 16 bits of the result, 
after receiving the carry-out from the first adder. 
Your 32-bit adder does not need to handle carry-in (assume 0) or carry-out (ignored), 
but the internal modules need to in order to function correctly. 
(In other words, the add16 module performs 16-bit a + b + cin, while your module performs 32-bit a + b).
*/
