`include "instructiondecode.v"
/*
	Process the instruction content
	input: shape, coordinates, and op_code
	output: 
		vector of bits containing the resulting coordinates
*/ 

// shapes:
`define triangle 1'b0;
`define rectangle 1'b1;


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
	output [3*(width + height)-1:0] points
	);
	
	assign points[width-1:0] = x1;
	assign points[width + height - 1: width] = y1;

	assign points[2*width + height -1 : width + height] = x2;
	assign points[2 * (width + height) - 1: 2*width + height] = y2;

	assign points[2*(width + height) + width - 1 : 2*(width + height)] = x3;
	assign points[3*(width + height) - 1: 2*(width + height) + width] = y3;


	// TODO: Calculate the 4th point if we get a rectangle & assign it to rightmost part of the points vector


	// assign points[3*(width + height) + width: 3*(width + height)] = 
	
	// always @(shape) begin
	// 	`triangle: begin //return points
	// 	end

	// 	`square: begin 

	// 	// points[3]<=[x2,y3]; //return additional coordinate
	// 	end

	// end


endmodule




module calc_pt4 #(
	parameter width = 4,
	parameter height = 3
) (
	input [width-1:0] x1,
	input [width-1:0] x2,
	input [width-1:0] x3,
	input [height-1:0] y1,
	input [height-1:0] y2,
	input [height-1:0] y3,
	output [width-1:0] x4,
	output [height-1:0] y4
)
	// compare x & y displacements to see which one would get the bigger "distance" 
	// we're doing this stupid thing because square roots are a pain

	wire[width-1:0] x1x2_displacement;
	wire[width-1:0] x1x3_displacement;
	wire[width-1:0] x2x3_displacement;	

	// assign [width-1:0] to x displacement from pt 1 to pt 2
	get_x_displacement deltax_x1x2 #(width) (x1, x2, x1x2_displacement);

	// assign [2*width-1:width] to x displacement from pt 1 to pt 3
	get_x_displacement deltax_x1x3 #(width) (x1, x3, x1x3_displacement);

	// assign [3*width-1: 2*width] to 
	get_x_displacement deltax_x1x3 #(width) (x2, x3, x2x3_displacement);

	// assign [height-1:0] to y displacement from pt 1 to pt 2
	get_y_displacement deltax_y1y2 #(height) (y1, y2, y1y2_displacement);

	// assign [2*height-1:height] to x displacement from pt 1 to pt 3
	get_y_displacement deltax_y1y3 #(height) (y1, y3, y1y3_displacement);

	// assign [3*height-1: 2*height] to 
	get_y_displacement deltax_y1y3 #(height) (y2, y3, y2y3_displacement);


	//TODO: sign-extend the height displacements to width displacement dimensions 
		// so we obtain the pair of points that have max distance from each other

	// the pair of points with maximum "distance" from each other 
		// will be the ones "adjacent" to pt. 4

	// calculate slope & apply it to one of the paired points to get pt. 4


	assign x4 = 4'b0;
	assign y4 = 3'b0;

endmodule



// 

module get_x_displacement #(parameter width = 4) (
	input[width-1:0] x_1,
	input[width-1:0] x_2,
	output[width-1:0] x_disp
)
	// wire[width-1:0] temp;
	// calculate x_1 - x_2 and check if it's negative. if it isn't then assign to output
	// assign temp = x_1 - x_2;
	// if it is then return x_2 - x_1 as output
	if ((x_1 - x_2) > (x_2 - x_1)) begin
		x_disp <= x_1 - x_2;
	end
	else begin
		x_disp <= x_2 - x_1;
	end

	// // temporary output
	// x_disp = width'b0;
endmodule


module get_y_displacement #(parameter height = 3) (
	input[height-1:0] y_1,
	input[height-1:0] y_2,
	output[height-1:0] y_disp
)

	// calculate x_1 - x_2 and check if it's negative. if it isn't then assign to output
	// assign temp = x_1 - x_2;
	// if it is then return x_2 - x_1 as output
	if ((x_1 - x_2) > (x_2 - x_1)) begin
		x_disp <= x_1 - x_2;
	end
	else begin
		x_disp <= x_2 - x_1;
	end

	// // temporary output
	// y_disp = height'b0;
endmodule