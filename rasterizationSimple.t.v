`include "rasterizationSimple.v"

module testRasterizationSimple();
	reg[3:0] coordA_X;
	reg[2:0] coordA_Y;
	reg[3:0] coordB_X;
	reg[2:0] coordB_Y;
	reg[3:0] coordC_X;
	reg[2:0] coordC_Y;
    wire[11:0] screen;

    rasterizeSimple #(4,3) Rast0(.coordA_X(coordA_X), .coordA_Y(coordA_Y), .coordB_X(coordB_X), .coordB_Y(coordB_Y), .coordC_X(coordC_X), .coordC_Y(coordC_Y), .screen(screen));

    initial begin
        $dumpfile("rasterizationSimple.vcd");
        $dumpvars();

        coordA_X=4'd1;coordA_Y=3'd0; coordB_X=4'd3; coordB_Y=3'd0; coordC_X=4'd3; coordC_Y=3'd2; #1000
        $display("test");
    end
endmodule
