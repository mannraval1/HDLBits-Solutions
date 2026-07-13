module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    reg [2:0] state, next_state;
    
    parameter S0 = 3'd0;
    parameter S1 = 3'd1;
    parameter S2 = 3'd2;
    parameter S3 = 3'd3;
    parameter S4 = 3'd4;
    
    always@(*) begin
        case(state) 
           S0 : begin
              next_state = x ? S1 : S0; 
           end
            
            S1 : begin
              next_state = x ? S4 : S1; 
           end
            
            S2 : begin
              next_state = x ? S1 : S2; 
           end
            
            S3 : begin
              next_state = x ? S2 : S1; 
           end
            
            S4 : begin
              next_state = x ? S4 : S3; 
           end
            default : next_state = S0;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin
           state <= S0;
        end else begin
           state <= next_state;
        end
    end
        
    assign z = (state == S3) || (state == S4);

endmodule
