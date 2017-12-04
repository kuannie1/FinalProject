`include "process.v"

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
input coordA_X,
input coordA_Y,
input coordB_X,
input coordB_Y,
input coordC_X,
input coordC_Y,
//The output pixels register is always large enough to hold all coordinate values on the screen
output reg [width*height-1:0] pixel_x_coords,
output reg [width*height-1:0] pixel_y_coords
);

reg min_X;
reg min_Y;
reg max_X;
reg max_Y;

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

reg as_x;
reg as_y;
reg x_counter;
reg y_counter;
reg s_ab;
reg pixels_counter;


//Go through each pixel in a rectangle that wraps around the given triangle, and determine
//whether that particular pixel is inside the triangle.
//Referenced https://stackoverflow.com/questions/2049582/how-to-determine-if-a-point-is-in-a-2d-triangle
initial begin
    pixels_counter = 0;
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
