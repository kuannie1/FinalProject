//`include "process.v" //included in rasterization.v
//`include "processPixels.v"
`include "rasterization.v" 
`include "instructiondecode.v"

module topModule #(
	parameter width = 4,
	parameter height = 3,
	parameter misc_amt = 9, // parameters for instruction
	parameter op_size = 2
)

(

input [3*(width+height) + 25 + op_size + misc_amt - 1:0] instruction,
output [2:0] TMDSp, TMDSn, 
output TMDSp_clock, TMDSn_clock
);

instructiondecode #(width, height, misc_amt, op_size) ID0(.instruction(instruction), .shape(shape), .x1(x1[width-1:0]),.y1(y1[height-1:0]),.x2(x2[width-1:0]),.y2(y2[height-1:0]),.x3(x3[width-1:0]),.y3(y3[height-1:0]),.r(r[7:0]),.g(g[7:0]),.b(b[7:0]),.misc(misc[misc_amt-1]),.op_code(op_code[op_size-1:0])); //reads in initial instruction

processInstruction #(width,height,misc_amt,op_size) P0(.x1(x1[width-1:0]),.y1(y1[height-1:0]),.x2(x2[width-1:0]),.y2(y2[height-1:0]),.x3(x3[width-1:0]),.y3(y3[height-1:0]), .shape(shape), .points(points[4*(width + height)-1:0])); //processes/adds any additional features

rasterize #(width, height) R0(.coordA_X(x1), .coordA_Y(y1), .coordB_X(x2), .coordB_Y(y2), .coordC_X(x3), .coordC_Y(y3), .pixel_x_coords(pixel_x_coords), .pixel_y_coords(pixel_y_coords)); //rasterizes using points given into either a triangle or square

//processPixels PP0(.xCoord(pixel_x_coords), .yCoord(pixel_y_coords), .red_vect(r), .green_vect(g), .blue_vect(b), .TMDSp(TMDSp[2:0]), .TMDSn(TMDSn[2:0]), .TMDSp_clock(TMDSp_clock), .TMDSn_clock(TMDSn_clock)); //combines multiple shapes to a screen 

endmodule
