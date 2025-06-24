module top_module( 
    input [254:0] in,
    output [7:0] out );

    /*
   		A "population count" circuit counts the number of '1's in an input vector.
        Build a population count circuit for a 255-bit input vector.
    */
    int i; 
    
    always@(*) begin
    	out = 8'd0;
        for(i = 0; i < 255; i++) begin
            out = out + in[i]; 
        end
    end
    
endmodule
