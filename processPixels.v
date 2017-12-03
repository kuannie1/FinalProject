`include "rasterization.v"

/*
	Takes in pixels from rasterizing stage and
	input: pixels
	output: 
		
*/ 

module processPixels
(
input xCoord,
input yCoord,
input [7:0] red,
input [7:0] green,
input 7:0] blue,
output screenArray
);

parameter screenWidth = 640;
parameter screenHeight = 480;

reg [7:0]screenArray[2:0][screenWidth-1:0][screenHeight-1:0];

for (i = 0; i < $size(xCoord); i = i + 1) begin
	screenArray[0] [xCoord[i]] [yCoord[i]] <= red[i];
	screenArray[1] [xCoord[i]] [yCoord[i]] <= green[i];
	screenArray[2] [xCoord[i]] [yCoord[i]] <= blue[i];
end