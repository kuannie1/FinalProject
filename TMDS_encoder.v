module TMDS_encoder(
	input pixclk,	// clock signal, positive edge triggered
	input [7:0] VD,  // video data (red, green or blue - 8 bits)
	input [1:0] CD,  // control data (2 bits)
	input VDE,  // video data enable, to choose between CD (when VDE=0) and VD (when VDE=1) - i.e. offscreen area can be control data
	output reg [9:0] TMDS = 0 // TMDS encoded color data
);

//algorithm based on the logic table for TMDS encoding on https://eewiki.net/pages/viewpage.action?pageId=36569119

wire [3:0] Num1s = VD[0] + VD[1] + VD[2] + VD[3] + VD[4] + VD[5] + VD[6] + VD[7]; //count number of 1s in the color data
wire XNOR = (Num1s>4'd4) || (Num1s==4'd4 && VD[0]==1'b0); //if number of 1s > 4 or number of 1s = 4 and LSB of VD is a 0 then XNOR, otherwise XOR 
wire [8:0] q_m = {~XNOR, q_m[6:0] ^ VD[7:1] ^ {7{XNOR}}, VD[0]}; // 8th bit is 0 if XNOR encoded, 1 if XOR encoded - LSB is unchanged - middle bits are either XOR'd or XNOR'd with previous bit

reg [3:0] diff_q_m_acc = 0;
wire [3:0] diff_q_m = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7] - 4'd4; // count the difference in number of 1s and 0s in the internal data byte (disparity)
wire diff_q_m_sign_eq = (diff_q_m[3] == diff_q_m_acc[3]);

wire invert_q_m = (diff_q_m==0 || diff_q_m_acc==0) ? ~q_m[8] : diff_q_m_sign_eq; // control bit that tells whether bits were inverted or not (in order to help hold avg DC level constant)

// more concise way of filling out the truth table for !(disparity = 0 or ones = 4)
wire [3:0] diff_q_m_acc_inc = diff_q_m - ({q_m[8] ^ ~diff_q_m_sign_eq} & ~(diff_q_m==0 || diff_q_m_acc==0)); 
wire [3:0] diff_q_m_acc_new = invert_q_m ? diff_q_m_acc-diff_q_m_acc_inc : diff_q_m_acc+diff_q_m_acc_inc;

//TMDS encoded data, MSB is the invert true or false bit, next bit is XOR or XNOR encoded bit, rest of bits are the encoded data bits
wire [9:0] TMDS_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};

// Control data is sent with as many transitions as possible to help clock synchronize
// one of 4 possible codes to specify the values for each of the 2 control bit values, sent when VD !enabled
// From table in wikipedia page on TMDS encoding
wire [9:0] TMDS_code = CD[1] ? (CD[0] ? 10'b1010101011 : 10'b0101010100) : (CD[0] ? 10'b0010101011 : 10'b1101010100);

always @(posedge pixclk) TMDS <= VDE ? TMDS_data : TMDS_code;
always @(posedge pixclk) diff_q_m_acc <= VDE ? diff_q_m_acc_new : 4'h0;
endmodule

