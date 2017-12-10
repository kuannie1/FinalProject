`include "process.v"


module processTest();


	reg [3:0] x1, x2, x3;
	reg [2:0] y1, y2, y3;
	reg shape;
	wire[27:0] pts;

	// this is a square
	processInstruction testsquare(.x1(x1), .y1(y1), // 7 bits
								.x2(x2), .y2(y2), // 7 bits
								.x3(x3), .y3(y3), // 7 bits
								.shape(shape),
								.points(pts) // 28 bits
								); 

	// testing parameter changes
	reg[1:0] x1_new, x2_new, x3_new, y1_new, y2_new, y3_new;
	reg shape_new;
	wire[15:0] pts_new;

	// // another square
	// processInstruction #(.width(2), .height(2)) parameterchange(.x1(x1_new), .y1(y1_new), // 4 bits
	// 															.x2(x2_new), .y2(y2_new), // 4 bits
	// 															.x3(x3_new), .y3(y3_new), // 4 bits
	// 															.shape(shape_new),
	// 															.points(pts_new) // 16 bits
	// 															); // total: 


	initial begin
		$dumpfile("process0.vcd");
		$dumpvars();

		// given points (0,0), (0,1) and (1,0) get (1,1)
		$display("Test case 0");
		
		x1 = 4'b0; y1 = 3'b0; x3 = 4'b0; y3 = 3'b1; x2 = 4'b1; y2 = 3'b0; shape = 1'b1; #1000
		$display("pts: %b, size: %d", pts, $bits(pts));
		$display("x1: %d, y1: %d", pts[3:0], pts[6:4]);
		$display("x2: %d, y2: %d", pts[10:7], pts[13:11]);
		$display("x3: %d, y3: %d", pts[17:14], pts[20:18]);
		$display("x4: %d, y4: %d", pts[24:21], pts[27:25]); 
		end


	// initial begin
	// 	$dumpfile("process1.vcd");
	// 	$dumpvars();

	// 	// given points (0,0), (0,1) and (1,0) get (1,1) with parameter changes
	// 	$display("Test case 1");

	// 	x1_new = 2'b0; y1_new = 2'b0; x3_new = 2'b0; y3_new = 2'b1; x2_new = 2'b1; y2_new = 2'b0; shape_new = 1'b1; #1000000
	// 	$display("pts: %b, size: %d", pts_new, $bits(pts_new));
	// 	$display("x1: %d, y1: %d", pts_new[1:0], pts_new[3:2]);
	// 	$display("x2: %d, y2: %d", pts_new[5:4], pts_new[7:6]);
	// 	$display("x3: %d, y3: %d", pts_new[9:8], pts_new[11:10]);
	// 	$display("x4: %d, y4: %d", pts_new[13:12], pts_new[15:14]);

	// end


	// initial begin
	// 	$dumpfile("process3.vcd");
	// 	$dumpvars();

	// 	// given points (0,0), (0,1) and (1,0) and 
	// 	$display("Test case 2");

	// 	x1_new = 2'b0; y1_new = 2'b0; x3_new = 2'b0; y3_new = 2'b1; x2_new = 2'b1; y2_new = 2'b0; #1000000
	// 	$display("pts: %b, size: %d", pts_new, $bits(pts_new));
	// 	$display("x1: %d, y1: %d", pts_new[1:0], pts_new[3:2]);
	// 	$display("x2: %d, y2: %d", pts_new[5:4], pts_new[7:6]);
	// 	$display("x3: %d, y3: %d", pts_new[9:8], pts_new[11:10]);
	// 	$display("x4: %d, y4: %d", pts_new[13:12], pts_new[15:14]);

	// end

endmodule






// // shapes:
// `define triangle 1'b0;
// `define square 1'b1;

// `define opFILL 2'b1; // the first op instruction is to fill


// module processInstruction #( 
// 	parameter width = 4,
// 	parameter height = 3
// 	// // only needed if we do transformations on the points
// 	// parameter misc_amt = 9,
// 	// parameter op_size = 2
// ) (	

// 	input [width-1:0] x1,
// 	input [width-1:0] x2,
// 	input [width-1:0] x3,
// 	input [height-1:0] y1,
// 	input [height-1:0] y2,
// 	input [height-1:0] y3,
// 	input shape,
// 	output reg [4*(width + height)-1:0] points
// 	);
// 	wire[width-1:0] x4;
// 	wire[height-1:0] y4;

// 	get4thpt #(.width(width), .height(height)) getpt(x1, x2, x3, y1, y2, y3, x4, y4);

// 	always @(shape) begin
// 		case(shape) 
// 			1: begin 
// 				points[3*(width+height)+width-1 : 3*(width+height)] = x4;
// 				points[4*(width+height)-1:3*(width+height) + width] = y4;
// 				points[3*(width+height)-1:0] = {y3, x3, y2, x2, y1, x1};
// 			end

// 			0: begin //return points
// 				points[4*(width+height)-1:0] = {{height{1'b0}}, {width{1'b0}}, y3, x3, y2, x2, y1, x1};
// 			end
// 		endcase
// 	end


// endmodule




// module get4thpt#( 
// 	parameter width = 4,
// 	parameter height = 3
// ) (	

// 	input [width-1:0] x1,
// 	input [width-1:0] x2,
// 	input [width-1:0] x3,
// 	input [height-1:0] y1,
// 	input [height-1:0] y2,
// 	input [height-1:0] y3,

// 	output [width-1:0]  x4,
// 	output [height-1:0] y4
// 	);

// 	// wire[3:0] x4;
// 	// wire[2:0] y4;

// 	initial begin
// 		$function(x1);
// 		$function(y1);		
// 		$function(x2);
// 		$function(y2);		
// 		$function(x3);
// 		$function(y3);
// 		$function(x4);
// 		$display("x4: %d", x4);
// 		$function(y4);
// 		$display("y4: %d", y4);
// 	end
// endmodule