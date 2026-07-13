module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    reg state, next_state;
    parameter LEFT = 0, RIGHT = 1;
    

    always @(*) begin
        // State transition logic
        case(state) 
            LEFT : begin
                if(bump_left) begin
                   next_state = RIGHT; 
                end else begin
                   next_state = LEFT; 
                end
            end
            
            RIGHT : begin
                if(bump_right) begin
                   next_state = LEFT; 
                end else begin
                   next_state = RIGHT; 
                end
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) begin
           state = LEFT;
        end else begin
           state <= next_state; 
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    
    assign walk_right = (state == RIGHT);

endmodule
