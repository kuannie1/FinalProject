`include "instructiondecode.v"
/*
	Process the instruction content
	input: shape, coordinates, and op_code
	output: 
		vector of bits containing the resulting coordinates
*/ 

// shapes:
`define square 1'b0;
`define triangle 1'b1;

// op_code defines:


module processInstruction #( 
	parameter width = 4,
	parameter height = 3,
	parameter misc_amt = 9,
	parameter op_size = 2
) (	
	input [3*(width+height) + 25 + op_size + misc_amt - 1:0] instruction,
	output [4*(width + height)-1:0] points
	);

	wire shape;
	wire [3:0] x1, x2, x3;
	wire [2:0] y1, y2, y3;
	wire [7:0] r, g, b;
	wire[8:0] misc;
	wire[1:0] op_code;

	instructiondecode #(width, height, misc_amt, op_size) idecoder1( .instruction(instruction), 
									.shape(shape),
									.x1(x1), .y1(y1),
									.x2(x2), .y2(y2),
									.x3(x3), .y3(y3),
									.r(r), .g(g), .b(b), 
									.misc(misc), 
									.op_code(op_code) 
									);
	// calculate 4th point if 

	// use op_code figure out how to process the points to get what you need


endmodule