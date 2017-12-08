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

	output reg [4*(width + height)-1:0] points
	);

	always @(shape) begin
		case(shape) 
			1: begin 
				points[3*(width+height)+width-1 : 3*(width+height)] = x2;
				points[4*(width+height)-1:3*(width+height) + width] = y3;
				points[3*(width+height)-1:0] = {y3, x3, y2, x2, y1, x1};
			end

			0: begin //return points
				points[4*(width+height)-1:0] = {{height{1'b0}}, {width{1'b0}}, y3, x3, y2, x2, y1, x1};

			end
		endcase


	end


endmodule