/*
    Add two 16-bit numbers with carry-in and produces a carry-out and 16-bit sum. 
    You must instantiate three of these to build the carry-select adder, 
    using your own 16-bit 2-to-1 multiplexer.
*/
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
	wire cout1, cout2, cout3;
    wire [15:0] sum1, sum2;
    
    add16 adder1(a[15:0], b[15:0], 0, sum[15:0], cout1);
    add16 adder2(a[31:16], b[31:16], 0, sum1, cout2);
    add16 adder3(a[31:16], b[31:16], 1, sum2, cout3);
    
    assign sum[31:16] = cout1 ? sum2 : sum1;
endmodule
