`include "instructiondecode.v"


module idecodeTest();
	reg [56:0] instruction;
	wire shape;
	wire [3:0] x1, x2, x3;
	wire [2:0] y1, y2, y3;
	wire [7:0] r, g, b;
	wire[8:0] misc;
	wire[1:0] op_code;


	instructiondecode #(4, 3, 9, 2) idecoder1( .instruction(instruction), 
										.shape(shape), // 1 bit
										.x1(x1), .y1(y1), // 7 bits
										.x2(x2), .y2(y2), // 7 bits
										.x3(x3), .y3(y3), // 7 bits
										.r(r), .g(g), .b(b), // 24 bits
										.misc(misc), // 9 bits
										.op_code(op_code) // 2 bits
										); // total: 57 bits



	// testing parameter changes
	reg [46:0] instruction_new;
	wire shape_new;
	wire[1:0] x1_new, x2_new, x3_new, y1_new, y2_new, y3_new;
	wire [7:0] r_new, g_new, b_new;
	wire[8:0] misc_new;
	wire op_code_new;

	instructiondecode #(2, 2, 9, 1) idecoder2( .instruction(instruction_new), 
										.shape(shape_new), // 1 bit
										.x1(x1_new), .y1(y1_new), // 4 bits
										.x2(x2_new), .y2(y2_new), // 4 bits
										.x3(x3_new), .y3(y3_new), // 4 bits
										.r(r_new), .g(g_new), .b(b_new), // 24 bits
										.misc(misc_new), // 9 bits
										.op_code(op_code_new) // 1 bit
										); // total: 47 bits


	initial begin
		$dumpfile("idecode.vcd");
		$dumpvars();

		instruction = 57'b110000000001111111100000000111111110001111000111100011111; #1000

		$display("shape: %b", shape);
		$display("x1: %b, y1: %b", x1, y1);
		$display("x2: %b, y2: %b", x2, y2);
		$display("x3: %b, y3: %b", x3, y3);
		$display("r: %b", r);
		$display("g: %b", g);
		$display("b: %b", b);
		$display("op_code: %b", op_code);

		$display();
		instruction = 57'b001111111111111111100000000111111110001111000111100011110; #1000

		$display("shape: %b", shape);
		$display("x1: %b, y1: %b", x1, y1);
		$display("x2: %b, y2: %b", x2, y2);
		$display("x3: %b, y3: %b", x3, y3);
		$display("r: %b", r);
		$display("g: %b", g);
		$display("b: %b", b);
		$display("op_code: %b", op_code);


		$display();
		instruction_new = 47'b10000000001111111100000000111111110011001100111; #1000

		$display("shape: %b", shape);
		$display("x1: %b, y1: %b", x1_new, y1_new);
		$display("x2: %b, y2: %b", x2_new, y2_new);
		$display("x3: %b, y3: %b", x3_new, y3_new);
		$display("r: %b", r_new);
		$display("g: %b", g_new);
		$display("b: %b", b_new);
		$display("op_code: %b", op_code_new);


	end



endmodule