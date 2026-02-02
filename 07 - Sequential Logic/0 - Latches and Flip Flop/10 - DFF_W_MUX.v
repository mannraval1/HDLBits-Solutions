module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    always@(posedge clk) begin
        case(L) 
            0 : Q <= q_in;
            1 : Q <= r_in;
        endcase
    end

endmodule
