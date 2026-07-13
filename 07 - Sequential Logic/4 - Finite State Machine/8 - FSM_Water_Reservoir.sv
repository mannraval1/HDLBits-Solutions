module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 

    // State encoding based on your state diagram
    // S0: Above S3, S1: Level falling to S2, S2: Level falling to S1, 
    // S3: Below S1, S4: Level rising to S1, S5: Level rising to S2
    parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5;
    reg [2:0] state, next_state;

    // State Transition Logic
    always @(*) begin
        case(state)
            S0: next_state = (s[3]) ? S0 : S1;
            S1: next_state = (s[3]) ? S0 : (s[2] ? S1 : S2);
            S2: next_state = (s[2]) ? S5 : (s[1] ? S2 : S3);
            S3: next_state = (s[1]) ? S4 : S3;
            S4: next_state = (s[2]) ? S5 : (s[1] ? S4 : S3);
            S5: next_state = (s[3]) ? S0 : (s[2] ? S5 : S2);
            default: next_state = S3;
        endcase
    end

    // Sequential Logic for Reset and State Update
    always @(posedge clk) begin
        if (reset)
            state <= S3; // Reset to "Below S1" as per requirements
        else
            state <= next_state;
    end

    // Output Logic (Moore Machine)
    always @(*) begin
        case(state)
            S0: {fr3, fr2, fr1, dfr} = 4'b0000;
            S1: {fr3, fr2, fr1, dfr} = 4'b0011;
            S2: {fr3, fr2, fr1, dfr} = 4'b0111;
            S3: {fr3, fr2, fr1, dfr} = 4'b1111;
            S4: {fr3, fr2, fr1, dfr} = 4'b0110;
            S5: {fr3, fr2, fr1, dfr} = 4'b0010;
            default: {fr3, fr2, fr1, dfr} = 4'b1111;
        endcase
    end

endmodule