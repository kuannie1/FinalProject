`include "rasterization.v"

module testRasterization();
	reg coordA_X;
	reg coordA_Y;
	reg coordB_X;
	reg coordB_Y;
	reg coordC_X;
	reg coordC_Y;
	wire [11:0] pixel_x_coords;
	wire [11:0] pixel_y_coords;

	rasterize #(4,3) Rast0(.coordA_X(coordA_x),.coordA_Y(coordA_Y), .coordB_X(coordB_X), .coordB_Y(coordB_Y), .coordC_X(coordC_X), .coordC_Y(coordC_Y), .pixel_x_coords(pixel_x_coords), .pixel_y_coords(pixel_y_coords));

	reg coordA_X_new;
	reg coordA_Y_new;
	reg coordB_X_new;
	reg coordB_Y_new;
	reg coordC_X_new;
	reg coordC_Y_new;
	wire [35:0] pixel_x_coords_new;
	wire [35:0] pixel_y_coords_new;

	rasterize #(6,6) Rast0(.coordA_X(coordA_X_new),.coordA_Y(coordA_Y_new), .coordB_X(coordB_X_new), .coordB_Y(coordB_Y_new), .coordC_X(coordC_X_new), .coordC_Y(coordC_Y_new), .pixel_x_coords(pixel_x_coords_new), .pixel_y_coords(pixel_y_coords_new));

	initial begin
	$dumpfile("rasterize.vcd");
	$dumpvars();

	coordA_X_new = ; #1000

	$display("shape: %b", shape);


	end

endmodule

