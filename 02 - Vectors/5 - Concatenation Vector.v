module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );//

/*
	Build a circuit which six 5-bits input and 2-bit 1 which makes up 32-bits and concatenating them
    the 32-bit word should be divided into four 8-bit 
*/
    wire [31:0] inter;
    assign inter = {a[4:0],b[4:0],c[4:0],d[4:0],e[4:0],f[4:0],2'b11};
    
   assign w = inter[31:24];
   assign x = inter[23:16];
   assign y = inter[15:8];
   assign z = inter[7:0];
    
endmodule
