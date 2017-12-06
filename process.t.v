`include "process.v"


module processTest();
	reg [4:0] width;
	reg [3:0] height;
	reg [9:0] misc_amt;
	reg [2:0] op_size;
	wire shape;
	wire [3:0] x1, x2, x3;
	wire [2:0] y1, y2, y3;
	wire [7:0] r, g, b;
	wire[8:0] misc;
	wire[1:0] op_code;


module processInstruction #( 
	parameter width = 4,
	parameter height = 3,
	parameter misc_amt = 9,
	parameter op_size = 2
)

	processInstruction #(4, 3, 9, 2) process0(.shape(shape), // 1 bit
										.x1(x1), .y1(y1), // 7 bits
										.x2(x2), .y2(y2), // 7 bits
										.x3(x3), .y3(y3), // 7 bits
										.r(r), .g(g), .b(b), // 24 bits
										.misc(misc), // 9 bits
										.op_code(op_code) // 2 bits
										); // total: 57 bits



	// testing parameter changes
	wire shape_new;
	wire[1:0] x1_new, x2_new, x3_new, y1_new, y2_new, y3_new;
	wire [7:0] r_new, g_new, b_new;
	wire[8:0] misc_new;
	wire op_code_new;

	processInstruction #(2, 2, 9, 1) process1( .shape(shape_new), // 1 bit
										.x1(x1_new), .y1(y1_new), // 4 bits
										.x2(x2_new), .y2(y2_new), // 4 bits
										.x3(x3_new), .y3(y3_new), // 4 bits
										.r(r_new), .g(g_new), .b(b_new), // 24 bits
										.misc(misc_new), // 9 bits
										.op_code(op_code_new) // 1 bit
										); // total: 47 bits


	initial begin
		$dumpfile("process.vcd");
		$dumpvars();


	end



endmodule