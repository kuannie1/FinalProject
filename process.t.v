`include "process.v"


module processTest();


	reg [3:0] x1, x2, x3;
	reg [2:0] y1, y2, y3;
	wire[27:0] pts;

	// this is a square
	processInstruction testsquare(
											.x1(x1), .y1(y1), // 7 bits
											.x2(x2), .y2(y2), // 7 bits
											.x3(x3), .y3(y3), // 7 bits
											.shape(1),
											.points(pts)
											); 

	// testing parameter changes
	reg[1:0] x1_new, x2_new, x3_new, y1_new, y2_new, y3_new;
	wire[15:0] pts_new;

	// another square
	processInstruction #(.width(2), .height(2)) parameterchange( 
																	.x1(x1_new), .y1(y1_new), // 4 bits
																	.x2(x2_new), .y2(y2_new), // 4 bits
																	.x3(x3_new), .y3(y3_new), // 4 bits
																	.shape(1),
																	.points(pts_new) // 16 bits
																); 
	reg[3:0] x1_triangle, x2_triangle, x3_triangle;
	reg[2:0] y1_triangle, y2_triangle, y3_triangle;
	wire[27:0] pts_triangle;
	// triangle
	processInstruction #() shapechange( 
										.x1(x1_triangle), .y1(y1_triangle), // 4 bits
										.x2(x2_triangle), .y2(y2_triangle), // 4 bits
										.x3(x3_triangle), .y3(y3_triangle), // 4 bits
										.shape(0),
										.points(pts_triangle) // 16 bits
									); 

	reg[4:0] x1_newtriangle, x2_newtriangle, x3_newtriangle;
	reg[4:0] y1_newtriangle, y2_newtriangle, y3_newtriangle;
	wire[39:0] pts_newtriangle;
	// triangle
	processInstruction #(.width(5), .height(5)) shapeparamchange( 
										.x1(x1_newtriangle), .y1(y1_newtriangle), // 10 bits
										.x2(x2_newtriangle), .y2(y2_newtriangle), // 10 bits
										.x3(x3_newtriangle), .y3(y3_newtriangle), // 10 bits
										.shape(0),
										.points(pts_newtriangle) // 40 bits
									); 



	initial begin
		$dumpfile("process0.vcd");
		$dumpvars();

		// given points (0,0), (0,1) and (1,0) get (1,1)
		$display("Test case 0");
		
		x1 = 4'b0; y1 = 3'b0; x3 = 4'b0; y3 = 3'b1; x2 = 4'b1; y2 = 3'b0; #1000
		$display("pts: %b, size: %d", pts, $bits(pts));
		$display("x1: %d, y1: %d", pts[3:0], pts[6:4]);
		$display("x2: %d, y2: %d", pts[10:7], pts[13:11]);
		$display("x3: %d, y3: %d", pts[17:14], pts[20:18]);
		$display("x4: %d, y4: %d", pts[24:21], pts[27:25]); 
		end


	initial begin
		$dumpfile("process1.vcd");
		$dumpvars();

		// given points (0,0), (0,1) and (1,0) get (1,1) with parameter changes
		$display("Test case 1");

		x1_new = 2'b0; y1_new = 2'b0; x3_new = 2'b0; y3_new = 2'b1; x2_new = 2'b1; y2_new = 2'b0; #2000
		$display("pts_new: %b, size: %d", pts_new, $bits(pts_new));
		$display("x1_new: %d, y1_new: %d", pts_new[1:0], pts_new[3:2]);
		$display("x2_new: %d, y2_new: %d", pts_new[5:4], pts_new[7:6]);
		$display("x3_new: %d, y3_new: %d", pts_new[9:8], pts_new[11:10]);
		$display("x4_new: %d, y4_new: %d", pts_new[13:12], pts_new[15:14]);

	end

	initial begin
		$dumpfile("process2.vcd");
		$dumpvars();

		// given points (0,0), (0,1) and (1,0) just return those points
		$display("Test case 2");

		x1_triangle = 4'b0; y1_triangle = 3'b0; x3_triangle = 4'b0; y3_triangle = 3'b1; x2_triangle = 4'b1; y2_triangle = 3'b0; #2000
		$display("pts_triangle: %b, size: %d", pts_triangle, $bits(pts_triangle));
		$display("x1_triangle: %d, y1_triangle: %d", pts_triangle[3:0], pts_triangle[6:4]);
		$display("x2_triangle: %d, y2_triangle: %d", pts_triangle[10:7], pts_triangle[13:11]);
		$display("x3_triangle: %d, y3_triangle: %d", pts_triangle[17:14], pts_triangle[20:18]);
		$display("should be just 0: x4_triangle: %d, y4_triangle: %d", pts_triangle[24:21], pts_triangle[27:25]); 
	end

	initial begin
		$dumpfile("process3.vcd");
		$dumpvars();

		// given points (16,16), (4,10) and (16,0) just return those points
		$display("Test case 3");

		x1_newtriangle = 5'd16; y1_newtriangle = 5'd16; x3_newtriangle = 5'd4; y3_newtriangle = 5'b10; x2_newtriangle = 5'd10; y2_newtriangle = 5'b10; #2000
		$display("pts_newtriangle: %b, size: %d", pts_newtriangle, $bits(pts_newtriangle));
		$display("x1_newtriangle: %d, y1_newtriangle: %d", pts_newtriangle[4:0], pts_newtriangle[9:5]);
		$display("x2_newtriangle: %d, y2_newtriangle: %d", pts_newtriangle[14:10], pts_newtriangle[19:15]);
		$display("x3_newtriangle: %d, y3_newtriangle: %d", pts_newtriangle[24:20], pts_newtriangle[29:25]);
		$display("should be just 0: x4_newtriangle: %d, y4_newtriangle: %d", pts_newtriangle[34:30], pts_newtriangle[39:35]); 
	end


endmodule