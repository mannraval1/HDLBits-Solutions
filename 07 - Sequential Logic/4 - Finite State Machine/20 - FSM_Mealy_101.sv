module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    reg [1:0] state, nextState;
    
    parameter S0 = 2'd0;
    parameter S1 = 2'd1;
    parameter S2 = 2'd2;
    
    always@(*) begin
        case(state)
            S0: begin
               nextState = x ? S1 : S0; 
            end
            
            S1: begin
               nextState = x ? S1 : S2; 
            end
            
            S2: begin
               nextState = x ? S1 : S0; 
            end
            default : begin
               nextState = S0; 
            end
        endcase
    end
    
    always@(posedge clk or negedge aresetn) begin
        if(!aresetn) begin
           state <= S0; 
        end
        else begin
           state <= nextState; 
        end
    end
    
    assign z = (state == S2) && x;
endmodule
