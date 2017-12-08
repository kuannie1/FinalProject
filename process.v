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
	output [3+shape:0] points //array not possible, only returning coordinates of additional point if necessary

	);

	
	always @(shape)begin
		case(shape)
		
		triangle: begin 
		extrapoint<=0; //return points 1, 2, 3, and extrapoint is void
		end

		square: begin 
		//extrapoint<= ; //return additional coordinate from C code
		end

		default:$display("error in shape choice");
	endcase

	end


endmodule