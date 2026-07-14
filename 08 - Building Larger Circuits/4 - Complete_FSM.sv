module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    reg [3:0] state, next_state;
    
    parameter A = 4'd1;
    parameter B = 4'd2;
    parameter C = 4'd3;
    parameter D = 4'd4;
    parameter E = 4'd5;
    parameter F = 4'd6;
    parameter G = 4'd7;
    parameter H = 4'd8;
    parameter I = 4'd9;
    parameter J = 4'd10;
    parameter K = 4'd11;

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
               next_state = F; 
            end
            
            F : begin
               next_state = G; 
            end
            
            G : begin
               next_state = H; 
            end
            
            H : begin
               next_state = I;
            end
            
            I : begin
               next_state = done_counting ? J : I; 
            end
            
            J : begin
               next_state = ack ? A : J; 
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
    
    assign shift_ena = (state == E) || (state == F) || (state == G) || (state == H);
    
    assign counting = (state == I);
    
    assign done = (state == J);
    
endmodule
