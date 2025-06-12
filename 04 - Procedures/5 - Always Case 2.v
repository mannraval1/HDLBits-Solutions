
// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*) begin
        if (in[0]==1'b1)
            pos = 0;
        else if (in[1]==1'b1)
            pos = 1;
        else if (in[2]==1'b1)
            pos = 2;
        else if (in[3]==1'b1)
            pos = 3;
        else
            pos = 0;
    end
endmodule
/*
 Build a 4-bit priority encoder. For this problem, if none of the input bits are high (i.e., input is zero), output zero. 
 Note that a 4-bit number has 16 possible combinations.
*/