`include "rasterization.v"

/*
	Takes in pixels from rasterizing stage and outputs a screen array
	input: array of pixel x values, pixel y values, red values, green values, and blue values
	output: a multidimensional array storing 8 bit numbers in a [red,gree,blue] x width x height array		
*/ 

module processPixels
(
input [9:0] xCoord [],
input [8:0] yCoord [],
input [7:0] red [],
input [7:0] green [],
input [7:0] blue [],
output [7:0] screenArray [2:0][screenWidth-1:0][screenHeight-1:0]
);

parameter screenWidth = 640;
parameter screenHeight = 480;

reg [7:0]screenArray[2:0][screenWidth-1:0][screenHeight-1:0];

for (i = 0; i < $size(xCoord); i = i + 1) begin
	screenArray[0] [xCoord[i]] [yCoord[i]] <= red[i];
	screenArray[1] [xCoord[i]] [yCoord[i]] <= green[i];
	screenArray[2] [xCoord[i]] [yCoord[i]] <= blue[i];
end