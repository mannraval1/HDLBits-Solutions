module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;
    // reg [1:0] state, next_state;
    // State transition logic: next_state = f(state, in)
    always@(*) begin
        case(state)
            A: begin
                if (in == 0) begin
                   next_state = A;
                end else begin
                    next_state = B;
                end
            end
            
            B: begin
                if (in == 0) begin
                   next_state = C;
                end else begin
                    next_state = B;
                end
            end
            
            C: begin
                if (in == 0) begin
                   next_state = A;
                end else begin
                    next_state = D;
                end
            end
            
            D: begin
                if (in == 0) begin
                   next_state = C;
                end else begin
                    next_state = B;
                end
            end
            
            default : next_state = A;
        endcase
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state == D);
endmodule
