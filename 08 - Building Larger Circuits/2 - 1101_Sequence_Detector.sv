module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    reg [2:0] state, next_state;
    
    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;
    
    always @(*) begin
        case(state) 
            A : begin
             next_state = data ? B : A;   
            end
            
            B : begin
             next_state = data ? C : A;
            end
            
            C : begin
              next_state = data ? C : D;  
            end
            
            D : begin
              next_state = data ? E : A;  
            end
            
            E : begin
                next_state = E;
            end
            
            default : next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if(reset) begin
        	state <= A;    
        end else begin
           state <= next_state; 
        end
    end
    
    assign start_shifting = (state == E);
endmodule
