/*
    For hardware synthesis purposes, there are two types of always block which are relavent
    -> Combinational: always@(*)
    -> Clocked: always@(posedge clk)

    The clocked always block create a blob of combinational logic just like combinational always block
    This creates a set of flip-flops at the output of the combinational logic. 
    The output of the combinational logic is sampled at the rising edge of the clock signal which are visible at the positive edge of the clock signal
    
    There are three type of assignment in verilog
    -> Continious assignment: (assign x = y;) This cannot be used inside a procedural always block
    -> Procedural Blocking assignment (x = y;) This can be used inside a procedural block 
    -> Procedural Non-Blocking assignment (x <= y;) This can be used inside a procedural block 

    In combinational always block, use blocking assignment.
    In clocked always block, use non-blocking assignment.

    It is good practice as not following it may result in extremely hard in finding the errors
    which differs in the simulation and the hardware after synthesis
*/

/*
    Problem Statement:
    Build an XOR gate three ways, using an assign statement, a combinational always block, and a clocked always block
*/

// synthesis verilog_input_version verilog_2001
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );
    
    assign out_assign = a ^ b;
    
    always@(*) begin
    out_always_comb = a ^ b;
    end
    
    always@(posedge clk) begin
    out_always_ff <= a ^ b;
    end
    

endmodule
