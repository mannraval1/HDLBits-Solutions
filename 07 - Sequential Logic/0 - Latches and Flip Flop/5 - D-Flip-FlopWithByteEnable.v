module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

    always @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0;
        end
        else begin
            // Handle the lower byte (controlled by byteena[0])
            if (byteena[0]) begin
                q[7:0] <= d[7:0];
            end
            
            // Handle the upper byte (controlled by byteena[1])
            if (byteena[1]) begin
                q[15:8] <= d[15:8];
            end
        end
    end

endmodule