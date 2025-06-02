/*
    
     For synthesis purposes,  two types of hardware blocks are relavent
    Combinational : always(*)
    assign : assign 

    The combinational always block is equivalent to the assign statements
    The syntax for the code inside the procedural block is differnt from the code that is outside. 
    The procedural block always have some richer set of statements which cannot contain continious assignment

    For Combinational always block, always use a sensitivity list
    Listing of the signals is error-prone and is ignored for hardware synthesis
    The hardware synthesized will behave as the signals mentioned in the (*) list which may or may not match with the hardware's behaviour

    Note on Reg and Wire:
    the LHS of the assign statement must be a net type 
    and 
    The LHS of the procedural statement should always be of the reg type. 

*/

// The problem statement
/*
    Build an AND gate using both an assign statement and a combinational always block
*/

// synthesis verilog_input_version verilog_2001
module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);
    assign out_assign = a & b;
    
    always@(*)
        begin
           out_alwaysblock = a & b;
            
        end

endmodule
