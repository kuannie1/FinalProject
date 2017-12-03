// ALU - Check if Not Equal (CNE) Feature

// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30

 /* 
Module: CNE
Checks whether a and b are equal by seeing if the xor result is 1. 
If the result is not all 1s then return all 0s. 
*/
module CNE 
(
	input[31:0] a, b,
	output[31:0] result
);

wire[31:0] xor_output;
wire isEqual, isNotEqual;

xor32 getXOR(xor_output, a, b);

zero_check checkEqual(isEqual, xor_output); // check if the xor output is all zeroes (all the same)

// if operands A and B are completely the same, we want to return false
`NOT notEqual(isNotEqual, isEqual);
assign result = {31'b0, isNotEqual};

endmodule