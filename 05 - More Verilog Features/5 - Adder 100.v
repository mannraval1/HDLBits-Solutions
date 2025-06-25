module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);

    // First full adder (bit 0)
    full_adder fa0 (
        .a(a[0]), 
        .b(b[0]), 
        .cin(cin), 
        .sum(sum[0]), 
        .cout(cout[0])
    );

    // Generate block for bits 1 to 99
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_adders
            full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .cin(cout[i-1]),
                .sum(sum[i]),
                .cout(cout[i])
            );
        end
    endgenerate

endmodule


module full_adder(
    input a, input b, input cin,
    output sum, output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
