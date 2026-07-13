module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
); 
    
    // Define 4 distinct states
    parameter SEARCH = 2'b00;
    parameter BYTE2  = 2'b01;
    parameter BYTE3  = 2'b10;
    parameter DONE   = 2'b11;
    
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        case(state)
            SEARCH: begin
                if (in[3]) next_state = BYTE2;
                else       next_state = SEARCH;
            end
            
            BYTE2: begin
                next_state = BYTE3;
            end
            
            BYTE3: begin
                next_state = DONE;
            end
            
            DONE: begin
                // The byte received during the DONE state is the start of the next packet!
                if (in[3]) next_state = BYTE2;
                else       next_state = SEARCH;
            end
            
            default: next_state = SEARCH;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= SEARCH;
        else 
            state <= next_state;
    end
    
    // Output logic - done is high ONLY when we are successfully in the DONE state
    assign done = (state == DONE);

endmodule