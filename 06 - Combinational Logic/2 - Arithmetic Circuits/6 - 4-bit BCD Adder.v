module top_module ( 
    input  [15:0] a, b,
    input         cin,
    output        cout,
    output [15:0] sum
);

    wire c1, c2, c3;

    // Ones digit
    bcd_fadd u0 (.a(a[3:0]),   .b(b[3:0]),   .cin(cin), .cout(c1), .sum(sum[3:0]));
    // Tens digit
    bcd_fadd u1 (.a(a[7:4]),   .b(b[7:4]),   .cin(c1),  .cout(c2), .sum(sum[7:4]));
    // Hundreds digit
    bcd_fadd u2 (.a(a[11:8]),  .b(b[11:8]),  .cin(c2),  .cout(c3), .sum(sum[11:8]));
    // Thousands digit
    bcd_fadd u3 (.a(a[15:12]), .b(b[15:12]), .cin(c3),  .cout(cout), .sum(sum[15:12]));

endmodule
    
    
