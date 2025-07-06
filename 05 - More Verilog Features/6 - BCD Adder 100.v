module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    /*
    	You are provided with a BCD one-digit adder named bcd_fadd that adds two BCD digits and carry-in,
        and produces a sum and carry-out.

        module bcd_fadd (
            input [3:0] a,
            input [3:0] b,
            input     cin,
            output   cout,
            output [3:0] sum );
		Instantiate 100 copies of bcd_fadd to create a 100-digit BCD ripple-carry adder. 
		Your adder should add two 100-digit BCD numbers (packed into 400-bit vectors)
        and a carry-in to produce a 100-digit sum and carry out.
    */
    	
    wire [100:0] carry;
    
    assign carry[0] = cin;
    assign cout = carry[100];
    
    genvar i; 
    
    generate 
        for(i = 0; i < 100; i++) begin : BCD_Stage
            bcd_fadd BCD_FullAdder(.a(a[4*i + 3:4*i]),
                                   .b(b[4*i + 3:4*i]),
                                   .cin(carry[i]),
                                   .cout(carry[i+1]),
                                   .sum(sum[4*i + 3:4*i])
                                  );
            
        end
    endgenerate
    
endmodule

    
