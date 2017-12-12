module rasterizeSimple #(
    parameter width = 4,
    parameter height = 3
) (
input [width-1:0] coordA_X,
input [height-1:0] coordA_Y,
input [width-1:0] coordB_X,
input [height-1:0] coordB_Y,
input [width-1:0] coordC_X,
input [height-1:0] coordC_Y,
input shape,
output reg [width*height-1:0] screen
);

integer i;
integer j;
//reg[height-1:0] pixels[width-1:0];

always @* begin
    for (i=0; i<height; i=i+1) begin
        for (j=0; j<width; j=j+1) begin
            screen[(i*width)+j] <= ((i >= coordA_Y) && (i <= coordC_Y) && (j >= coordA_X) && (j <= coordB_X));
        end
    end
end

endmodule
