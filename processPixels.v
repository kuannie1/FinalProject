`include "rasterization.v"
`include "TMDS_encoder.v"

/*
	Takes in pixels from rasterizing stage and outputs a screen array
	input: array of pixel x values, pixel y values, red values, green values, and blue values
	output: a multidimensional array storing 8 bit numbers in a [red,gree,blue] x width x height array		
*/ 

module processPixels
(
	input [9:0] xCoord,
	input [8:0] yCoord,
	input [7:0] red_vect,
	input [7:0] green_vect,
	input [7:0] blue_vect,
	input pixclk, // 25MHz pixel clock
	output [2:0] TMDSp, TMDSn, // differential high speed data lines
	output TMDSp_clock, TMDSn_clock //differential clock for high speed data lines
);

reg [9:0] CounterX, CounterY; // counters used for horizontal and vertical synchronization
reg hSync, vSync, DrawArea; // 
reg [7:0] red, green, blue;
wire [9:0] TMDS_red, TMDS_green, TMDS_blue;
wire clk_TMDS;  // used for 250 MHz clock
reg [3:0] TMDS_bit_counter=0;  // counter for color bit synchronization (counts from 0 - 9 and then resets back to 0)
reg [9:0] TMDS_shift_red=0, TMDS_shift_green=0, TMDS_shift_blue=0;
reg TMDS_shift_load=0;
reg [7:0] background_red = 0, background_green = 0, background_blue = 0; //background color values
integer i = 0;


//Want all of these things to happen at once on every pixel clock positive edge:
always @(posedge pixclk) DrawArea <= (CounterX<640) && (CounterY<480); //DrawArea == 1 if counter is within the draw area - HDMI has some off-screen area so that timing works out

// increment both counters until counter X reaches 799 and then overflow back to 0 and counter Y reaches 524 (800 x 525 pixels)- these numbers are chosen so that total number of pixels
// including off-screen area has the appropriate refresh rate (60Hz) with HDMI lowest allowable pixel clock (25MHz) and so that all timing requirements are met
always @(posedge pixclk) CounterX <= (CounterX==799) ? 0 : CounterX+1; 
always @(posedge pixclk) if(CounterX==799) CounterY <= (CounterY==524) ? 0 : CounterY+1;

// hSync and vSync are generated off of the counter. 
always @(posedge pixclk) hSync <= (CounterX>=656) && (CounterX<752);
always @(posedge pixclk) vSync <= (CounterY>=490) && (CounterY<492);

//if counterX and counterY both equal the next value in xCoord and yCoord vectors then assign red, green, and blue to the same index in red_vect, green_vect, and blue_vect.
//if current counter values are not in the xCoord and yCoord vectors then default to background color values
always @(posedge pixclk)
begin
	if(CounterX==xCoord[i] && CounterY==yCoord[i])red <= ? red_vect[i] : background_red;
end

always @(posedge pixclk)
begin
	if(CounterX==xCoord[i] && CounterY==yCoord[i])green <= ? green_vect[i] : background_green;
end

always @(posedge pixclk)
begin
	if(CounterX==xCoord[i] && CounterY==yCoord[i])blue <= ? blue_vect[i] : background_blue;
	if(i==$size(xCoord) i <= ? 0 : i + 1;
end


//TMDS Encode all the signals - converts 8 bit color data value to 10 bit TMDS encoded color value
TMDS_encoder encode_red(.clk(pixclk), .VD(red), .CD(2'b00), .VDE(DrawArea), .TMDS(TMDS_red));				// transition minimized differential signaling encoding
TMDS_encoder encode_green(.clk(pixclk), .VD(green), .CD(2'b00), .VDE(DrawArea), .TMDS(TMDS_green));			// reduces number of transitions and noise
TMDS_encoder encode_blue(.clk(pixclk), .VD(blue), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));	// specifided in the DVI/HDMI specification


// generate 250 MHz clock by multiplying 25 MHz pixel clock by 10
// this clock is needed because for each pixel we need 10 bits of color data to be clocked in
// (8 bits of actual data + the 2 bit overhead for TMDS encoding). Pixel clock is 25 MHz so this clock
// needs to be 250 MHz
DCM_SP #(.CLKFX_MULTIPLY(10)) DCM_TMDS_inst(.CLKIN(pixclk), .CLKFX(clk_TMDS), .RST(1'b0));


always @(posedge clk_TMDS) TMDS_shift_load <= (TMDS_bit_counter==4'd9);// if bit counter reaches 9, i.e. all 10 color bits have been output, grab the color bits for the next pixel

always @(posedge clk_TMDS)
begin
	TMDS_shift_red   <= TMDS_shift_load ? TMDS_red   : TMDS_shift_red  [9:1];		// If bit counter has been reached, i.e. TMDS_shift_load is asserted, grab next pixel's color data
	TMDS_shift_green <= TMDS_shift_load ? TMDS_green : TMDS_shift_green[9:1];		// otherwise shift one bit off the end and output that bit through the differential buffer defined
	TMDS_shift_blue  <= TMDS_shift_load ? TMDS_blue  : TMDS_shift_blue [9:1];		// below. Do this for all 3 colors
	TMDS_bit_counter <= (TMDS_bit_counter==4'd9) ? 4'd0 : TMDS_bit_counter+4'd1;	// If TMDS bit counter == 9, reset to 0, otherwise increment by 1
end

//differential output buffers, saw recommendation/usage case in Xilinx forum post
OBUFDS OBUFDS_red  (.I(TMDS_shift_red  [0]), .O(TMDSp[2]), .OB(TMDSn[2])); //because these are high speed differential signals that will be used offboard I read somewhere that you want
OBUFDS OBUFDS_green(.I(TMDS_shift_green[0]), .O(TMDSp[1]), .OB(TMDSn[1])); //Vivado to synthesize with a high(ish) current output buffer this "hardcodes" a differential output buffer
OBUFDS OBUFDS_blue (.I(TMDS_shift_blue [0]), .O(TMDSp[0]), .OB(TMDSn[0])); //Do this for all of the TMDS signals
OBUFDS OBUFDS_clock(.I(pixclk), .O(TMDSp_clock), .OB(TMDSn_clock));		   //As well as for the TMDS clock signal

endmodule