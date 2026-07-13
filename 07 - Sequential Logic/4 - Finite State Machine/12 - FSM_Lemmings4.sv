module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    parameter LEFT      = 3'd0;
    parameter RIGHT     = 3'd1;
    parameter FALL_L    = 3'd2;
    parameter FALL_R    = 3'd3;
    parameter DIG_L     = 3'd4;
    parameter DIG_R     = 3'd5;
    parameter SPLAT     = 3'd6;

    reg [2:0] state, next_state;
    reg [4:0] fall_count;

    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end

            RIGHT: begin
                if (!ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end

            DIG_L: begin
                if (!ground)
                    next_state = FALL_L;
                else
                    next_state = DIG_L;
            end

            DIG_R: begin
                if (!ground)
                    next_state = FALL_R;
                else
                    next_state = DIG_R;
            end

            FALL_L: begin
                if (ground) begin
                    if (fall_count > 5'd20)
                        next_state = SPLAT;
                    else
                        next_state = LEFT;
                end else begin
                    next_state = FALL_L;
                end
            end

            FALL_R: begin
                if (ground) begin
                    if (fall_count > 5'd20)
                        next_state = SPLAT;
                    else
                        next_state = RIGHT;
                end else begin
                    next_state = FALL_R;
                end
            end

            SPLAT: begin
                next_state = SPLAT;
            end

            default: begin
                next_state = LEFT;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 5'd0;
        end else begin
            state <= next_state;

            if (next_state == FALL_L || next_state == FALL_R) begin
                if (fall_count < 5'd21)
                    fall_count <= fall_count + 5'd1;
                else
                    fall_count <= 5'd21;   // saturate, don't wrap
            end else begin
                fall_count <= 5'd0;
            end
        end
    end

    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FALL_L || state == FALL_R);
    assign digging    = (state == DIG_L || state == DIG_R);

endmodule