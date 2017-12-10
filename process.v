/*
	Process the instruction content
	input: shape, coordinates, and op_code
	output: 
		vector of bits containing the resulting coordinates
*/ 

// shapes:
`define triangle 1'b0;
`define square 1'b1;

`define opFILL 2'b1; // the first op instruction is to fill


module processInstruction #( 
	parameter width = 4,
	parameter height = 3
	// // only needed if we do transformations on the points
	// parameter misc_amt = 9,
	// parameter op_size = 2
) (	

	input [width-1:0] x1,
	input [width-1:0] x2,
	input [width-1:0] x3,
	input [height-1:0] y1,
	input [height-1:0] y2,
	input [height-1:0] y3,
	input shape,
	output reg [4*(width + height)-1:0] points
);
	wire[width-1:0] x4;
	wire[height-1:0] y4;

	get4thpt #(.width(width), .height(height)) getpt(x1, x2, x3, y1, y2, y3, x4, y4);

	always @(shape) begin
		case(shape) 
			1: begin 
				points[3*(width+height)+width-1 : 3*(width+height)] = x4;
				points[4*(width+height)-1:3*(width+height) + width] = y4;
				points[3*(width+height)-1:0] = {y3, x3, y2, x2, y1, x1};
			end

			0: begin //return points
				points[4*(width+height)-1:0] = {{height{1'b0}}, {width{1'b0}}, y3, x3, y2, x2, y1, x1};
			end
		endcase
	end


endmodule




module get4thpt#( 
	parameter width = 4,
	parameter height = 3
) (	

	input [width-1:0] x1,
	input [width-1:0] x2,
	input [width-1:0] x3,
	input [height-1:0] y1,
	input [height-1:0] y2,
	input [height-1:0] y3,

	output [width-1:0]  x4,
	output [height-1:0] y4
	);

	// wire[3:0] x4;
	// wire[2:0] y4;

	initial begin
		$function(x1);
		$function(y1);		
		$function(x2);
		$function(y2);		
		$function(x3);
		$function(y3);
		$function(x4);
		$display("x4: %d", x4);
		$function(y4);
		$display("y4: %d", y4);
	end
endmodule