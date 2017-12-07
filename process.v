`include "instructiondecode.v"
/*
	Process the instruction content
	input: shape, coordinates, and op_code
	output: 
		vector of bits containing the resulting coordinates
*/ 

// shapes:
`define triangle 1'b0;
`define square 1'b1;


module processInstruction #( 
	parameter width = 4,
	parameter height = 3,
	parameter misc_amt = 9,
	parameter op_size = 2,
	parameter shape=0
) (	

	input [width-1:0] x1,
	input [width-1:0] x2,
	input [width-1:0] x3,
	input [height-1:0] y1,
	input [height-1:0] y2,
	input [height-1:0] y3,
	output [shape+1:0][1:0] points //2-D array

	);
	points[0]<=[x1,y1];
	points[1]<=[x2,y2];
	points[2]<=[x3,y3];
	
	always @(shape)begin
		0: begin //return points
		end

		1: begin 
		points[3]<=[x2,y3]; //return additional coordinate
		end

	end


endmodule