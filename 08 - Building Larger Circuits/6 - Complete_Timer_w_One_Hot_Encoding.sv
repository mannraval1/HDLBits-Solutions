module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

    // State bit positions
    parameter S     = 0,
              S1    = 1,
              S11   = 2,
              S110  = 3,
              B0    = 4,
              B1    = 5,
              B2    = 6,
              B3    = 7,
              Count = 8,
              Wait  = 9;

    // Next-state logic

    // B3 is reached unconditionally from B2.
    assign B3_next = state[B2];

    // S is reached from:
    // S when d=0
    // S1 when d=0
    // S110 when d=0
    // Wait when ack=1
    assign S_next = (state[S]    & ~d) |
                    (state[S1]   & ~d) |
                    (state[S110] & ~d) |
                    (state[Wait] & ack);

    // S1 is reached from S when d=1.
    assign S1_next = state[S] & d;

    // Count is reached from:
    // B3 unconditionally
    // Count itself when counting is not finished
    assign Count_next = state[B3] |
                        (state[Count] & ~done_counting);

    // Wait is reached from:
    // Count when counting is finished
    // Wait itself while ack=0
    assign Wait_next = (state[Count] & done_counting) |
                       (state[Wait]  & ~ack);

    // Output logic
    assign done     = state[Wait];
    assign counting = state[Count];

    // Shift during states B0, B1, B2, and B3.
    assign shift_ena = state[B0] |
                       state[B1] |
                       state[B2] |
                       state[B3];

endmodule