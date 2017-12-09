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
											.points(pts) // 28 bits
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
																); // total: 


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
		$dumpfile("process2.vcd");
		$dumpvars();

		// given points (0,0), (0,1) and (1,0) get (1,1) with parameter changes
		$display("Test case 1");

		x1_new = 2'b0; y1_new = 2'b0; x3_new = 2'b0; y3_new = 2'b1; x2_new = 2'b1; y2_new = 2'b0; #2000
		$display("pts: %b, size: %d", pts_new, $bits(pts_new));
		$display("x1: %d, y1: %d", pts_new[1:0], pts_new[3:2]);
		$display("x2: %d, y2: %d", pts_new[5:4], pts_new[7:6]);
		$display("x3: %d, y3: %d", pts_new[9:8], pts_new[11:10]);
		$display("x4: %d, y4: %d", pts_new[13:12], pts_new[15:14]);

	end

endmodule