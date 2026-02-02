module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] capture;
    
    always@(posedge clk) begin
       capture <= in;
        if (reset) begin
           out <= 32'd0;
           capture <= in;
        end
        else begin
            out <= out | (capture & ~in);
            capture <= in;
        end
    end
    
endmodule
