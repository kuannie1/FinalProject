`include "process.v"

/*
	Convert the input coordinates into pixels
	input: an array with coordinate values
	output: 
		pixels?
*/ 

//Not really verilog yet: verilog-ish psuedocode
module rasterize
(
input coordA_X,
input coordA_Y,
input coordB_X,
input coordB_Y,
input coordC_X,
input coordC_Y,
output pixels //Make it into an array
);
//Referenced https://stackoverflow.com/questions/2049582/how-to-determine-if-a-point-is-in-a-2d-triangle

min_x = min(coordA_X, coordB_X, coordC_X)
min_y = min(coordA_Y, coordB_Y, coordC_Y)
max_x = max(coordA_X, coordB_X, coordC_X)
max_y = max(coordA_Y, coordB_Y, coordC_Y)
x_counter = min_x
y_counter = min_y
while y_counter <= max_y:
    while x_counter <= max_x:
        //determine if point is inside the triangle
        as_x = x_counter - coordA_X
        as_y = y_counter - coordA_Y

        s_ab = (coordB_X - coordA_X)*as_Y-(coordB_Y-coordA_Y)*as_x > 0;

        if ((coordC_X-coordA_X)*as_y-(coordC_Y-coordA_Y)*as_x > 0 == s_ab): 
            x_counter += 1
            if x_counter > max_x:
                x_counter = min_x
                y_counter += 1
            continue

        if ((coordC_X-coordB_X)-(coordC_Y-coordB_Y)*(x_counter-coordB_X) > 0 !+ s_ab): 
            x_counter += 1
            if x_counter > max_x:
                x_counter = min_x
                y_counter += 1
            continue

        else:
            //append (x_counter, y_counter) to pixels output

endmodule
