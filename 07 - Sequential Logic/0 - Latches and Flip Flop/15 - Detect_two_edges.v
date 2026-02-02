module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] intm;
    
    always@(posedge clk) begin
        intm <= in;
        anyedge <= intm ^ in;
    end

endmodule
