`include "process.v"
`include "processPixels.v"
`include "rasterization.v"

module topModule #(
	parameter width = 4,
	parameter height = 3,
	parameter misc_amt = 9, // parameters for instruction
	parameter op_size = 2,
)

(

input [3*(width+height) + 25 + op_size + misc_amt - 1:0] instruction,
output [width^2:0] [height^2:0] pixels //screenwidth x screenheight
);

instructiondecode #(width, height, misc_amt, op_size) ID0(.instruction(instruction), .x1(x1),.y1(y1),.x2(x2),.y2(y2),.x3(x3),.y3(y3),.r(r),.g(g),.b(b),.misc(misc),.op_code(op_code)); //reads in initial instruction

processInstruction #(width,height,misc_amt,op_size) P0(.instruction(instruction), .points(points)); //processes/adds any additional features

rasterize #(width, height) R0(coordA_X(x1), coordA_Y(y1), coordB_X(x2), coordB_Y(y2), coordC_X(x3), coordC_Y(y3), .pixel_x_coords(pixel_x_coords), .pixel_y_coords(pixel_y_coords)); //rasterizes using points given into either a triangle or square

processPixels PP0(.xCoord(pixel_x_coords), .yCoord(pixel_y_coords), .red(r), .green(g), .blue(b), .screenArray(pixels)); //combines multiple shapes to a screen 

end