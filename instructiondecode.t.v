`include "instructiondecode.v"


module idecodeTest();
	reg passedtests;

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

		$display("Test case 0");
		instruction = 57'b100000001111111111000000111111110001111000111100011111110; #1000

		if(shape==0 &&(x1==4'b1111) && y1==3'b111 && x2== 4'b1000 && y2==3'b111 && x3==4'b1000 && y3==3'b111 && r== 8'b11111000 && g==8'b00000111 && b==8'b11111110 && op_code==2'b10) begin //testing all parameters
			passedtests=1;
			$display("I passed the first test");
			end
		else begin
			$display("I did not pass");
		end

		$display("Test case 1: I can change shape");
		instruction = 57'b100000001111111111000000111111110001111000111100011111111; #1000

		if(shape==1 &&(x1==4'b1111) && y1==3'b111 && x2== 4'b1000 && y2==3'b111 && x3==4'b1000 && y3==3'b111 && r== 8'b11111000 && g==8'b00000111 && b==8'b11111110 && op_code==2'b10) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			end
		else begin
			$display("I did not pass");
		end

		$display("Test case 2: I can change my coordinates");
		instruction = 57'b100000001111111111000000111111110001111000111100011101111; #1000

		if(shape==1 &&(x1==4'b0111) && y1==3'b111 && x2== 4'b1000 && y2==3'b111 && x3==4'b1000 && y3==3'b111 && r== 8'b11111000 && g==8'b00000111 && b==8'b11111110 && op_code==2'b10) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			end
		else begin
			$display("I cannot change x1 correctly");
		end

		$display("Test case 2: I can change my coordinates");
		instruction = 57'b100000001111111111000000111111110001111000111100010111111; #1000

		if(shape==1 &&(x1==4'b1111) && y1==3'b101 && x2== 4'b1000 && y2==3'b111 && x3==4'b1000 && y3==3'b111 && r== 8'b11111000 && g==8'b00000111 && b==8'b11111110 && op_code==2'b10) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			end
		else begin
			$display("I cannot change y1 correctly");
		end

		$display("Test case 2: I can change my coordinates");
		instruction = 57'b100000001111111111000000111111110001111000111101011111111; #1000

		if(shape==1 &&(x1==4'b1111) && y1==3'b111 && x2== 4'b1010 && y2==3'b111 && x3==4'b1000 && y3==3'b111 && r== 8'b11111000 && g==8'b00000111 && b==8'b11111110 && op_code==2'b10) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			end
		else begin
			$display("I cannot change x2 correctly");
		end

		$display("Test case 2: I can change my coordinates");
		instruction = 57'b100000001111111111000000111111110001111000110100011111111; #1000

		if(shape==1 &&(x1==4'b1111) && y1==3'b111 && x2== 4'b1000 && y2==3'b101 && x3==4'b1000 && y3==3'b111 && r== 8'b11111000 && g==8'b00000111 && b==8'b11111110 && op_code==2'b10) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			end
		else begin
			$display("I cannot change y2 correctly");
		end

		$display("Test case 2: I can change my coordinates");
		instruction = 57'b100000001111111111000000111111110001111001111100011111111; #1000

		if(shape==1 &&(x1==4'b1111) && y1==3'b111 && x2== 4'b1000 && y2==3'b111 && x3==4'b1001 && y3==3'b111 && r== 8'b11111000 && g==8'b00000111 && b==8'b11111110 && op_code==2'b10) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			end else begin
			$display("I cannot change x3 correctly");
		end

		$display("Test case 3: I can change my color");
		instruction = 57'b100000001110111111000000001110010001111000111100011111111; #1000

		if(shape==1 &&(x1==4'b1111) && y1==3'b111 && x2== 4'b1000 && y2==3'b111 && x3==4'b1000 && y3==3'b111 && r== 8'b11001000 && g==8'b00000001 && b==8'b01111110 && op_code==2'b10) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			end else begin
			$display("I cannot change color correctly");
		end

		$display("Test case 3: I can change my op_code");
		instruction = 57'b010000001110111111000000001110010001111000111100011111111; #1000

		if(shape==1 &&(x1==4'b1111) && y1==3'b111 && x2== 4'b1000 && y2==3'b111 && x3==4'b1000 && y3==3'b111 && r== 8'b11001000 && g==8'b00000001 && b==8'b01111110 && op_code==2'b01) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
			$display(passedtests);
			end else begin
			$display("I cannot change my op_code correctly");
		end

		$display("Test case 4: I can be parameterized!");
		instruction_new = 47'b01111000001010101010101010010101010100000000000; #1000

		if(shape_new==0 &&(x1_new==2'b00) && y1_new==2'b00 && x2_new== 2'b00 && y2_new==2'b00 && x3_new==2'b00 && y2_new==3'b01 && r_new== 8'b01010101 && g_new==8'b10101010 && b_new==8'b10101010 && op_code_new==2'b01) begin //testing all parameters
			passedtests=passedtests+1;
			$display("I passed this test");
		end else begin
			$display("Changing my parameters does not work");
		end

		$display("I passed %b tests", passedtests);


	end



endmodule