module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    integer r, c;
    integer ru, rd, cl, cr;
    integer count;
    reg [255:0] next_q;

    always @(*) begin
        next_q = q;

        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                // Wrap-around row/column indices
                ru = (r == 0)  ? 15 : r - 1;
                rd = (r == 15) ? 0  : r + 1;
                cl = (c == 0)  ? 15 : c - 1;
                cr = (c == 15) ? 0  : c + 1;

                // Count 8 neighbors
                count =
                    q[ru*16 + cl] + q[ru*16 + c] + q[ru*16 + cr] +
                    q[r *16 + cl]                + q[r *16 + cr] +
                    q[rd*16 + cl] + q[rd*16 + c] + q[rd*16 + cr];

                // Apply rules
                case (count)
                    2: next_q[r*16 + c] = q[r*16 + c];
                    3: next_q[r*16 + c] = 1'b1;
                    default: next_q[r*16 + c] = 1'b0;
                endcase
            end
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule