`default_nettype none     // Disable implicit nets. Reduces some types of bugs.
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
    /*
	The unpacked dimensions are mentioned after the variable name. 
	They are used in memory array.
	For Example
	reg [7:0] out1 [15:0];
	This means that the 16 register each 8-bits wide
    */
   assign out_hi =  in[15:8];
   assign out_lo =  in[7:0];

endmodule
