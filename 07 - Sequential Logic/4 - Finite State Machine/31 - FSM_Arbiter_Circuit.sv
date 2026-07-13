module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    reg [1:0] state, next_state;
    
    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    
    always @(*) begin
        case(state) 
            A : begin
                if(!r[1] && !r[2] && !r[1]) begin
                    next_state = A;
                end if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            
            B : begin
                if(r[1] == 0) begin
                    next_state = A;
                end else begin
                   next_state =  B;
                end
            end
            
            C : begin
                if(r[2] == 0) begin
                   next_state = A;
                end else begin
                   next_state = C; 
                end
            end
            
            D : begin
                if(r[3] == 0) begin
                   next_state = A;
                end else begin
                   next_state = D; 
                end
            end
            
            default : next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        if(!resetn) begin
            state <= A;
        end else begin
           state <= next_state; 
        end
    end

    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);
endmodule
