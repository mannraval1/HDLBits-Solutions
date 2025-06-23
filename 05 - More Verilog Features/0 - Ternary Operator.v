module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    // assign intermediate_result1 = compare? true: false;
    wire [7:0] intWire1, intWire2;
    
    assign intWire1 = a < b ? a : b;
    assign intWire2 = c < d ? c : d;
    
    assign min = intWire1 < intWire2 ? intWire1 : intWire2;
    
endmodule
/*
	Given four unsigned numbers, find the minimum. 
    Unsigned numbers can be compared with standard comparison operators (a < b). 
    Use the conditional operator to make two-way min circuits, then compose a few of them to create a 4-way min circuit. 
    You'll probably want some wire vectors for the intermediate results.
*/
