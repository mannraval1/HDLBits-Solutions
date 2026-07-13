module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter IDLE  = 3'b000;
    parameter START = 3'b001;
    parameter DATA  = 3'b010;
    parameter ERROR = 3'b011;
    parameter STOP  = 3'b100;
    
    reg [7:0] data_in;
    
    reg [2:0] state, next_state;
    reg [3:0] bit_count;

    // 1. Next State Combinational Logic
    always @(*) begin
        case(state)
            IDLE: begin
                if (in) next_state = IDLE;
                else    next_state = START; 
            end
            
            START: begin
                next_state = DATA;
            end
            
            DATA: begin
                // Transition to STOP lookahead exactly when bit_count reaches 7
                if (bit_count == 4'd7) begin
                    next_state = (in == 1'b1) ? STOP : ERROR;
                end else begin
                    next_state = DATA;
                end
            end
            
            STOP: begin
                if (in == 1'b1) next_state = IDLE;
                else            next_state = START; // Back-to-back start bit handling
            end
            
            ERROR: begin
                if (in) next_state = IDLE;
                else    next_state = ERROR;
            end
            default: next_state = IDLE;
        endcase
    end	
             
    // 2. Sequential Logic for State Transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // 3. Sequential Logic for the Counter
    always @(posedge clk) begin
        if (reset) begin
            bit_count <= 4'd0;
        end else if (next_state == DATA) begin
            if (state == DATA)
                bit_count <= bit_count + 1'b1;
            else
                bit_count <= 4'd0; // Clear immediately when entering from START
        end else begin
            bit_count <= 4'd0; 
        end
    end

    // 4. Output Assignment
    assign done = (state == STOP);

endmodule