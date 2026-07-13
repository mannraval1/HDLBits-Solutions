module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    reg [3:0] state, next_state;
    
    parameter A = 4'd0;
    parameter B = 4'd1;
    parameter C = 4'd2;
    parameter D = 4'd3;
    parameter E = 4'd4;
    parameter F = 4'd5;
    parameter G = 4'd6;
    parameter H = 4'd7;
    parameter I = 4'd8;
    
    always @(*) begin
        case (state)

            A: begin
                next_state = B;
            end
            
            B: begin
                next_state = C;
            end
            
            // No useful part of 101 detected
            C: begin
                next_state = x ? D : C;
            end
            
            // Received 1
            D: begin
                next_state = x ? D : E;
            end
            
            // Received 10
            E: begin
                next_state = x ? F : C;
            end
            
            // Received 101; g=1
            // First chance to check y
            F: begin
                next_state = y ? G : H;
            end
            
            // Permanent g=1 state
            G: begin
                next_state = G;
            end
            
            // Second and final chance to check y
            H: begin
                next_state = y ? G : I;
            end
            
            // Permanent g=0 state
            I: begin
                next_state = I;
            end
            
            default: begin
                next_state = A;
            end

        endcase
    end
    
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    assign f = (state == B);

    assign g = (state == F) ||
               (state == H) ||
               (state == G);

endmodule