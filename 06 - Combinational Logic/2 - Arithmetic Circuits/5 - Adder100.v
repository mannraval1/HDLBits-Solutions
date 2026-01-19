module top_module (
    input  [99:0] a,
    input  [99:0] b,
    input         cin,
    output [99:0] sum,
    output        cout
);

    wire [100:0] tmp;

    assign tmp  = {1'b0, a} + {1'b0, b} + cin;
    assign sum  = tmp[99:0];
    assign cout = tmp[100];

endmodule
