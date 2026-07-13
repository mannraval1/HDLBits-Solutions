module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

   // Define 4 distinct states
    parameter SEARCH = 2'b00;
    parameter BYTE2  = 2'b01;
    parameter BYTE3  = 2'b10;
    parameter DONE   = 2'b11;
    
    reg [1:0] state, next_state;
    wire [23:0] packet;
    
    // State transition logic
    always @(*) begin
        case(state)
            SEARCH: begin
                if (in[3]) begin
                     next_state = BYTE2;
                end
                else begin
                    next_state = SEARCH;
                end
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
        
        case(state)
            SEARCH: begin
                    if (in[3])
                        packet[23:16] <= in;
                end

                BYTE2: begin
                    packet[15:8] <= in;
                end

                BYTE3: begin
                    packet[7:0] <= in;
                end

                DONE: begin
                    if (in[3])
                        packet[23:16] <= in;
                end
        endcase
    end
    
    // Output logic - done is high ONLY when we are successfully in the DONE state
    assign done = (state == DONE);
    assign out_bytes = packet;

    
    

endmodule
