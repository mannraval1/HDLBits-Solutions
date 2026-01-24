module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 

    // Mapping derived from the K-map columns:
    assign mux_in[0] = c | d;   // Column ab=00
    assign mux_in[1] = 1'b0;    // Column ab=01
    assign mux_in[2] = ~d;      // Column ab=10
    assign mux_in[3] = c & d;   // Column ab=11

endmodule