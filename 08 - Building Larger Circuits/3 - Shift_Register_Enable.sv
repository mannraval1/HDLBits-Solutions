module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [2:0] state, next_state;
    
    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;
    
    always @(*) begin
        case(state)
            A : begin
                next_state = reset ? B : A;
            end
            
            B : begin
                next_state = C;
            end
            
            C : begin
                next_state = D;
            end
            
            D: begin
                next_state = E;
            end
            
            E : begin
               next_state = A; 
            end
            default next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)  begin
           state <= B;
        end else begin
            state <= next_state;
        end
    end
    
    assign shift_ena = (state == B) || (state == C) || (state == D) || (state == E);
endmodule
