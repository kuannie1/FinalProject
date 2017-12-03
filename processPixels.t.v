`include "processPixels.v"

module testDraw();
parameter NumbPixels = 100;

reg[7:0] red [NumbPixels-1:0];
reg[7:0] green [NumbPixels-1:0];
reg[7:0] blue [NumbPixels-1:0];
reg[9:0] xCoord [NumbPixels-1:0];
reg[8:0] yCoord [NumbPixels-1:0];
wire [7:0] screenArray [2:0][screenWidth-1:0][screenHeight-1:0];

processPixels procPixels(.xCoord(xCoord),.yCoord(yCoord),.red(red),.green(green),.blue(blue).screenArray(screenArray));

initial begin
red[NumbPixels-1:0] <= 8'b01010101;
green[NumbPixels-1:0] <= 8'b11110000;
blue[NumbPixels-1:0] <= 8'b00001111;

for (i = 0; i < NumbPixels, i = i + 1) begin
	xCoord[i] <= 10'b0000000000 + i;
	yCoord[i] <= 9'b000000000 + i;
end


for (i = 0; i < screenWidth, i = i + 1) begin
	for (j = 0; j < screenHeight, j = j + 1) begin
		$display("%b, %b, %b", screenArray[0][i][j], screenArray[1][i][j], screenArray[2][i][j])
	end
	$display();
	$display();
end

end