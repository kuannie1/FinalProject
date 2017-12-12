//`include "process.v" //included in rasterization.v
`include "processPixels.v"
`include "rasterization.v" 
`include "instructiondecode.v"
`include "MMCM_clk_gen.v"

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

wire shape;
wire [width-1:0] x1, x2, x3;
wire [height-1:0] y1, y2, y3;
wire [7:0] r, g, b;
wire [misc_amt-1:0] misc;
wire [op_size-1:0] op_code;

wire locked;
wire pixclk;
wire clk_TMDS;

wire [(width*height-1)*(width-1):0] pixel_x_coords;
wire [(width*height-1)*(height-1):0] pixel_y_coords;

instructiondecode #(width, height, misc_amt, op_size) ID0(.instruction(instruction), .shape(shape), .x1(x1),.y1(y1),.x2(x2),.y2(y2),.x3(x3),.y3(y3),.r(r),.g(g),.b(b),.misc(misc),.op_code()); //reads in initial instruction

//processInstruction #(width,height,misc_amt,op_size) P0(.x1(x1[width-1:0]),.y1(y1[height-1:0]),.x2(x2[width-1:0]),.y2(y2[height-1:0]),.x3(x3[width-1:0]),.y3(y3[height-1:0]), .shape(shape), .points(points[4*(width + height)-1:0])); //processes/adds any additional features

rasterize #(width, height) R0(.coordA_X(x1), .coordA_Y(y1), .coordB_X(x2), .coordB_Y(y2), .coordC_X(x3), .coordC_Y(y3), .shape(shape), .pixel_x_coords(pixel_x_coords), .pixel_y_coords(pixel_y_coords)); //rasterizes using points given into either a triangle or square

clk_wiz_0_clk_wiz clk_gen(.clk_in1(clk), .locked(locked), .clk_TMDS(clk_TMDS), .pixclk(pixclk));

processPixels PP0(.xCoord(pixel_x_coords), .yCoord(pixel_y_coords), .red_vect(r), .green_vect(g), .blue_vect(b), .locked(locked), .pixclk(pixclk), .clk_TMDS(clk_TMDS), .TMDSp(TMDSp[2:0]), .TMDSn(TMDSn[2:0]), .TMDSp_clock(TMDSp_clock), .TMDSn_clock(TMDSn_clock)); //combines multiple shapes to a screen 

endmodule
