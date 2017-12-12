//`include "process.v"

/*
	Convert the input coordinates into pixels
	input: an array with coordinate values
	output: 
		Array of pixel values. One array for x-values, another for y-values.
*/ 

module rasterize #(
    parameter width = 4,
    parameter height = 3
) (
input [width-1:0]  coordA_X,
input [height-1:0] coordA_Y,
input [width-1:0] coordB_X,
input [height-1:0] coordB_Y,
input [width-1:0] coordC_X,
input [height-1:0] coordC_Y,
input shape,
//The output pixels register is always large enough to hold all coordinate values on the screen
//Since 2d wires are not supported as output in verilog, coordinates have to be sent serially
//For x-coord parse every width-1 bits; y-coord every height-1 bits
output reg [(width*height-1)*(width-1):0] pixel_x_coords,
output reg [(width*height-1)*(height-1):0] pixel_y_coords
);

reg[width-1:0] min_X;
reg[height-1:0] min_Y;
reg[width-1:0] max_X;
reg[height-1:0] max_Y;

//Computing min and max x,y values for defining a rectangle that wraps around the triangle
always @* begin
    if ((coordA_X < coordB_X) && (coordA_X < coordC_X)) begin
        min_X = coordA_X;
    end
    else if (coordB_X < coordC_X) begin
        min_X = coordB_X;
    end
    else begin
        min_X = coordC_X;
    end

    if ((coordA_Y < coordB_Y) && (coordA_Y < coordC_Y)) begin
        min_Y = coordA_Y;
    end
    else if (coordB_Y < coordC_Y) begin
        min_Y = coordB_Y;
    end
    else begin
        min_Y = coordC_Y;
    end

    if ((coordA_X > coordB_X) && (coordA_X > coordC_X)) begin
        max_X = coordA_X;
    end
    else if (coordB_X > coordC_X) begin
        max_X = coordB_X;
    end
    else begin
        max_X = coordC_X;
    end

    if ((coordA_Y > coordB_Y) && (coordA_Y > coordC_Y)) begin
        max_Y = coordA_Y;
    end
    else if (coordB_Y > coordC_Y) begin
        max_Y = coordB_Y;
    end
    else begin
        max_Y = coordC_Y;
    end
end

reg[width*height:0] as_x;
reg[width*height:0] as_y;
reg[width-1:0] x_counter;
reg[height-1:0] y_counter;
reg[width*height:0] s_ab;
reg[width*height:0] pixels_counter;


//Go through each pixel in a rectangle that wraps around the given triangle, and determine
//whether that particular pixel is inside the triangle.
//Referenced https://stackoverflow.com/questions/2049582/how-to-determine-if-a-point-is-in-a-2d-triangle
initial begin
    pixels_counter = 0;
    x_counter = min_X;
    y_counter = min_Y;
    while (y_counter <= max_Y) begin
        while (x_counter <= max_X) begin
            as_x = x_counter - coordA_X;
            as_y = y_counter - coordA_Y;

            s_ab = (coordB_X - coordA_X)*as_y-(coordB_Y-coordA_Y)*as_x > 0; 

            if (((coordC_X-coordA_X)*as_y-(coordB_Y-coordA_Y)*as_x > 0) == s_ab) begin
                x_counter = x_counter + 1;
                if (x_counter > max_X) begin
                    x_counter = min_X;
                    y_counter = y_counter + 1;
                end
            end
            else if (((coordC_X-coordB_X)-(coordC_Y-coordB_Y)*(x_counter-coordB_X) > 0) != s_ab)
            begin
                x_counter = x_counter + 1;
                if (x_counter > max_X) begin
                    x_counter = min_X;
                    y_counter = y_counter + 1;
                end
            end
            else begin
                pixel_x_coords[pixels_counter] = x_counter;
                pixel_y_coords[pixels_counter] = y_counter;
                pixels_counter = pixels_counter + 1;
            end            

        end
    end
end

endmodule
