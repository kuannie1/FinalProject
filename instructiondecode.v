/*
	Instruction decode module
	input: bit string instruction
	output: 
		square or triangle,
		x & y coordinates for pts. 1 - 3 (parameterized, but default 4 & 3 bits respectively),
		red value (8 bits),
		green value (8 bits),
		blue value (8 bits)	
*/ 


module instructiondecode
#(
	parameter width = 4,
	parameter height = 3,
	parameter misc_amt = 9, // there's usually an "amount" like # of degrees, pixel translation, etc.
	parameter op_size = 1
	
) (
	input [3*(width+height) + 25 + op_size + misc_amt - 1:0] instruction,
	
	output shape,

	output [width-1:0] x1,
	output [height-1:0] y1,

	output [width-1:0] x2,
	output [height-1:0] y2,	

	output [width-1:0] x3,
	output [height-1:0] y3,

	output [7:0] r,
	output [7:0] g,
	output [7:0] b,

	output [misc_amt - 1: 0] misc,

	output [op_size - 1: 0] op_code

	);
	
	// assign shape = instruction[4*(width+height) + 25 + op_bits - 1 : 4*(width+height) + 25 + op_bits - 2];
	assign shape = instruction[0];

	assign x1 = instruction[width : 1];
	assign y1 = instruction[width + height : width+1];

	assign x2 = instruction[height + 2*(width): width + height + 1];
	assign y2 = instruction[2 * (width + height): height + 2*(width) + 1];

	assign x3 = instruction[2 * (width + height) + width: 2 * (width + height) + 1];
	assign y3 = instruction[3 * (width + height): 2 * (width + height) + width + 1];

	assign r = instruction[3 * (width + height) + 8: 3 * (width + height) + 1];
	assign g = instruction[3 * (width + height) + 16: 3 * (width + height) + 8 + 1];
	assign b = instruction[3 * (width + height) + 24: 3 * (width + height) + 16 + 1];

	assign misc = instruction[3 * (width + height) + 24 + misc_amt : 3 * (width + height) + 24 + 1];

	assign op_code = instruction[3 * (width + height) + 24 + misc_amt + op_size: 3 * (width + height) + 24 + misc_amt + 1];


endmodule