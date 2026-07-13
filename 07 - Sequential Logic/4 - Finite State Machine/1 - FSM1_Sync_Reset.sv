

module top_module(
    input clk,
    input reset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case(state) 
            A : begin
                if(in == 0) begin
                   next_state = B;
                  // out = 0
                end else begin
                   next_state = A;
                  // out = 0;
                end
            end
            
            B : begin
               if(in == 0) begin
                   next_state = A;
                  // out = 0
                end else begin
                   next_state = B;
                  // out = 0;
                end 
            end
            
            default: next_state = B;
            
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(reset) begin
           state <= B; 
        end else 
			state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state == B);
endmodule

