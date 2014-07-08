module FFT(clk, rst, fir_d, fir_valid,
	fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7,  
	fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15,
	fft_valid);


input clk, rst;
input signed [15:0]	fir_d;
input fir_valid;

output signed [31:0] fft_d0, fft_d1, fft_d2, fft_d3;
output signed [31:0] fft_d4, fft_d5, fft_d6, fft_d7;
output signed [31:0] fft_d8, fft_d9, fft_d10, fft_d11;
output signed [31:0] fft_d12, fft_d13, fft_d14, fft_d15;
output fft_valid;

//Image
parameter W0_Imag = 32'h00000000;
parameter W1_Imag = 32'hFFFF9E09;
parameter W2_Imag = 32'hFFFF4AFC;
parameter W3_Imag = 32'hFFFF137D;
parameter W4_Imag = 32'hFFFF0000;
parameter W5_Imag = 32'hFFFF137D;
parameter W6_Imag = 32'hFFFF4AFC;
parameter W7_Imag = 32'hFFFF9E09;

//Real
parameter W0_Real = 32'h00010000; 
parameter W1_Real = 32'h0000EC83;
parameter W2_Real = 32'h0000B504; 
parameter W3_Real = 32'h000061F7; 
parameter W4_Real = 32'h00000000; 
parameter W5_Real = 32'hFFFF9E09; 
parameter W6_Real = 32'hFFFF4AFC; 
parameter W7_Real = 32'hFFFF137D;

reg stage1_valid;
reg stage2_valid;
reg stage3_valid;
reg stage4_valid;
reg fft_valid;
reg [3:0] fft_counter;

reg signed [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15;

//stage1
wire signed [31:0] stage1_real_0, stage1_real_1, stage1_real_2, stage1_real_3;
wire signed [31:0] stage1_real_4, stage1_real_5, stage1_real_6, stage1_real_7;
wire signed [31:0] stage1_real_8, stage1_real_9, stage1_real_10, stage1_real_11;
wire signed [31:0] stage1_real_12, stage1_real_13, stage1_real_14, stage1_real_15;

wire signed [31:0] stage1_imag_0, stage1_imag_1, stage1_imag_2, stage1_imag_3;
wire signed [31:0] stage1_imag_4, stage1_imag_5, stage1_imag_6, stage1_imag_7;
wire signed [31:0] stage1_imag_8, stage1_imag_9, stage1_imag_10, stage1_imag_11;
wire signed [31:0] stage1_imag_12, stage1_imag_13, stage1_imag_14, stage1_imag_15;

FFT_ADDER FFT_S1_0(clk, rst, stage1_valid, y0, 0, y8,  0, stage1_real_0, stage1_imag_0);
FFT_ADDER FFT_S1_1(clk, rst, stage1_valid, y1, 0, y9,  0, stage1_real_1, stage1_imag_1);
FFT_ADDER FFT_S1_2(clk, rst, stage1_valid, y2, 0, y10, 0, stage1_real_2, stage1_imag_2);
FFT_ADDER FFT_S1_3(clk, rst, stage1_valid, y3, 0, y11, 0, stage1_real_3, stage1_imag_3);
FFT_ADDER FFT_S1_4(clk, rst, stage1_valid, y4, 0, y12, 0, stage1_real_4, stage1_imag_4);
FFT_ADDER FFT_S1_5(clk, rst, stage1_valid, y5, 0, y13, 0, stage1_real_5, stage1_imag_5);
FFT_ADDER FFT_S1_6(clk, rst, stage1_valid, y6, 0, y14, 0, stage1_real_6, stage1_imag_6);
FFT_ADDER FFT_S1_7(clk, rst, stage1_valid, y7, 0, y15, 0, stage1_real_7, stage1_imag_7);

FFT_MULTI FFT_S1_8 (clk, rst, stage1_valid, y8,  0, y0, 0, W0_Real, W0_Imag, stage1_real_8,  stage1_imag_8);
FFT_MULTI FFT_S1_9 (clk, rst, stage1_valid, y9,  0, y1, 0, W1_Real, W1_Imag, stage1_real_9,  stage1_imag_9);
FFT_MULTI FFT_S1_10(clk, rst, stage1_valid, y10, 0, y2, 0, W2_Real, W2_Imag, stage1_real_10, stage1_imag_10);
FFT_MULTI FFT_S1_11(clk, rst, stage1_valid, y11, 0, y3, 0, W3_Real, W3_Imag, stage1_real_11, stage1_imag_11);
FFT_MULTI FFT_S1_12(clk, rst, stage1_valid, y12, 0, y4, 0, W4_Real, W4_Imag, stage1_real_12, stage1_imag_12);
FFT_MULTI FFT_S1_13(clk, rst, stage1_valid, y13, 0, y5, 0, W5_Real, W5_Imag, stage1_real_13, stage1_imag_13);
FFT_MULTI FFT_S1_14(clk, rst, stage1_valid, y14, 0, y6, 0, W6_Real, W6_Imag, stage1_real_14, stage1_imag_14);
FFT_MULTI FFT_S1_15(clk, rst, stage1_valid, y15, 0, y7, 0, W7_Real, W7_Imag, stage1_real_15, stage1_imag_15);

//stage2
wire signed [31:0] stage2_real_0, stage2_real_1, stage2_real_2, stage2_real_3;
wire signed [31:0] stage2_real_4, stage2_real_5, stage2_real_6, stage2_real_7;
wire signed [31:0] stage2_real_8, stage2_real_9, stage2_real_10, stage2_real_11;
wire signed [31:0] stage2_real_12, stage2_real_13, stage2_real_14, stage2_real_15;

wire signed [31:0] stage2_imag_0, stage2_imag_1, stage2_imag_2, stage2_imag_3;
wire signed [31:0] stage2_imag_4, stage2_imag_5, stage2_imag_6, stage2_imag_7;
wire signed [31:0] stage2_imag_8, stage2_imag_9, stage2_imag_10, stage2_imag_11;
wire signed [31:0] stage2_imag_12, stage2_imag_13, stage2_imag_14, stage2_imag_15;

FFT_ADDER FFT_S2_0 (clk, rst, stage2_valid, stage1_real_0,  stage1_imag_0,   stage1_real_4,  stage1_imag_4,  stage2_real_0,  stage2_imag_0);
FFT_ADDER FFT_S2_1 (clk, rst, stage2_valid, stage1_real_1,  stage1_imag_1,   stage1_real_5,  stage1_imag_5,  stage2_real_1,  stage2_imag_1);
FFT_ADDER FFT_S2_2 (clk, rst, stage2_valid, stage1_real_2,  stage1_imag_2,   stage1_real_6,  stage1_imag_6,  stage2_real_2,  stage2_imag_2);
FFT_ADDER FFT_S2_3 (clk, rst, stage2_valid, stage1_real_3,  stage1_imag_3,   stage1_real_7,  stage1_imag_7,  stage2_real_3,  stage2_imag_3);
FFT_ADDER FFT_S2_8 (clk, rst, stage2_valid, stage1_real_8,  stage1_imag_8,   stage1_real_12, stage1_imag_12, stage1_real_8,  stage1_imag_8);
FFT_ADDER FFT_S2_9 (clk, rst, stage2_valid, stage1_real_9,  stage1_imag_9,   stage1_real_13, stage1_imag_13, stage1_real_9,  stage1_imag_9);
FFT_ADDER FFT_S2_10(clk, rst, stage2_valid, stage1_real_10, stage1_imag_10,  stage1_real_14, stage1_imag_14, stage1_real_10, stage1_imag_10);
FFT_ADDER FFT_S2_11(clk, rst, stage2_valid, stage1_real_11, stage1_imag_11,  stage1_real_15, stage1_imag_15, stage1_real_11, stage1_imag_11);

FFT_MULTI FFT_S2_4 (clk, rst, stage2_valid, stage1_real_4,  stage1_imag_4,  stage1_real_0,  stage1_imag_0,  W0_Real, W0_Imag, stage2_real_4,  stage2_imag_4);
FFT_MULTI FFT_S2_5 (clk, rst, stage2_valid, stage1_real_5,  stage1_imag_5,  stage1_real_1,  stage1_imag_1,  W2_Real, W2_Imag, stage2_real_5,  stage2_imag_5);
FFT_MULTI FFT_S2_6 (clk, rst, stage2_valid, stage1_real_6,  stage1_imag_6,  stage1_real_2,  stage1_imag_2,  W4_Real, W4_Imag, stage2_real_6,  stage2_imag_6);
FFT_MULTI FFT_S2_7 (clk, rst, stage2_valid, stage1_real_7,  stage1_imag_7,  stage1_real_3,  stage1_imag_3,  W6_Real, W6_Imag, stage2_real_7,  stage2_imag_7);
FFT_MULTI FFT_S2_12(clk, rst, stage2_valid, stage1_real_12, stage1_imag_12, stage1_real_8,  stage1_imag_8,  W0_Real, W0_Imag, stage2_real_12, stage2_imag_12);
FFT_MULTI FFT_S2_13(clk, rst, stage2_valid, stage1_real_13, stage1_imag_13, stage1_real_9,  stage1_imag_9,  W2_Real, W2_Imag, stage2_real_13, stage2_imag_13);
FFT_MULTI FFT_S2_14(clk, rst, stage2_valid, stage1_real_14, stage1_imag_14, stage1_real_10, stage1_imag_10, W4_Real, W4_Imag, stage2_real_14, stage2_imag_14);
FFT_MULTI FFT_S2_15(clk, rst, stage2_valid, stage1_real_15, stage1_imag_15, stage1_real_11, stage1_imag_11, W6_Real, W6_Imag, stage2_real_15, stage2_imag_15);

//stage2
wire signed [31:0] stage3_real_0, stage3_real_1, stage3_real_2, stage3_real_3;
wire signed [31:0] stage3_real_4, stage3_real_5, stage3_real_6, stage3_real_7;
wire signed [31:0] stage3_real_8, stage3_real_9, stage3_real_10, stage3_real_11;
wire signed [31:0] stage3_real_12, stage3_real_13, stage3_real_14, stage3_real_15;

wire signed [31:0] stage3_imag_0, stage3_imag_1, stage3_imag_2, stage3_imag_3;
wire signed [31:0] stage3_imag_4, stage3_imag_5, stage3_imag_6, stage3_imag_7;
wire signed [31:0] stage3_imag_8, stage3_imag_9, stage3_imag_10, stage3_imag_11;
wire signed [31:0] stage3_imag_12, stage3_imag_13, stage3_imag_14, stage3_imag_15;

FFT_ADDER FFT_S3_0 (clk, rst, stage3_valid, stage1_real_0,  stage1_imag_0,   stage1_real_4,  stage1_imag_4,  stage2_real_0,  stage2_imag_0);
FFT_ADDER FFT_S3_1 (clk, rst, stage3_valid, stage1_real_1,  stage1_imag_1,   stage1_real_5,  stage1_imag_5,  stage2_real_1,  stage2_imag_1);
FFT_ADDER FFT_S3_2 (clk, rst, stage3_valid, stage1_real_2,  stage1_imag_2,   stage1_real_6,  stage1_imag_6,  stage2_real_2,  stage2_imag_2);
FFT_ADDER FFT_S3_3 (clk, rst, stage3_valid, stage1_real_3,  stage1_imag_3,   stage1_real_7,  stage1_imag_7,  stage2_real_3,  stage2_imag_3);
FFT_ADDER FFT_S3_8 (clk, rst, stage3_valid, stage1_real_8,  stage1_imag_8,   stage1_real_12, stage1_imag_12, stage1_real_8,  stage1_imag_8);
FFT_ADDER FFT_S3_9 (clk, rst, stage3_valid, stage1_real_9,  stage1_imag_9,   stage1_real_13, stage1_imag_13, stage1_real_9,  stage1_imag_9);
FFT_ADDER FFT_S3_10(clk, rst, stage3_valid, stage1_real_10, stage1_imag_10,  stage1_real_14, stage1_imag_14, stage1_real_10, stage1_imag_10);
FFT_ADDER FFT_S3_11(clk, rst, stage3_valid, stage1_real_11, stage1_imag_11,  stage1_real_15, stage1_imag_15, stage1_real_11, stage1_imag_11);

FFT_MULTI FFT_S3_4 (clk, rst, stage3_valid, stage1_real_4,  stage1_imag_4,  stage1_real_0,  stage1_imag_0,  W0_Real, W0_Imag, stage2_real_4,  stage2_imag_4);
FFT_MULTI FFT_S3_5 (clk, rst, stage3_valid, stage1_real_5,  stage1_imag_5,  stage1_real_1,  stage1_imag_1,  W2_Real, W2_Imag, stage2_real_5,  stage2_imag_5);
FFT_MULTI FFT_S3_6 (clk, rst, stage3_valid, stage1_real_6,  stage1_imag_6,  stage1_real_2,  stage1_imag_2,  W4_Real, W4_Imag, stage2_real_6,  stage2_imag_6);
FFT_MULTI FFT_S3_7 (clk, rst, stage3_valid, stage1_real_7,  stage1_imag_7,  stage1_real_3,  stage1_imag_3,  W6_Real, W6_Imag, stage2_real_7,  stage2_imag_7);
FFT_MULTI FFT_S3_12(clk, rst, stage3_valid, stage1_real_12, stage1_imag_12, stage1_real_8,  stage1_imag_8,  W0_Real, W0_Imag, stage2_real_12, stage2_imag_12);
FFT_MULTI FFT_S3_13(clk, rst, stage3_valid, stage1_real_13, stage1_imag_13, stage1_real_9,  stage1_imag_9,  W2_Real, W2_Imag, stage2_real_13, stage2_imag_13);
FFT_MULTI FFT_S3_14(clk, rst, stage3_valid, stage1_real_14, stage1_imag_14, stage1_real_10, stage1_imag_10, W4_Real, W4_Imag, stage2_real_14, stage2_imag_14);
FFT_MULTI FFT_S3_15(clk, rst, stage3_valid, stage1_real_15, stage1_imag_15, stage1_real_11, stage1_imag_11, W6_Real, W6_Imag, stage2_real_15, stage2_imag_15);



always@(posedge clk or posedge rst)
	if(rst)
		stage1_valid <= 0;
	else if(fft_counter == 15)
		stage1_valid <= 1;
	else 
		stage1_valid <= 0;

always@(posedge clk or posedge rst)
	if(rst)
	begin
		stage2_valid <= 0;
		stage3_valid <= 0;
		stage4_valid <= 0;
		fft_valid <= 0;
	end
	else
	begin
		stage2_valid <= stage1_valid;
		stage3_valid <= stage2_valid;
		stage4_valid <= stage3_valid;
		fft_valid <= stage4_valid;
	end


always@(posedge clk or posedge rst)
	if(rst)
		fft_counter <= 0;
	else if(fir_valid)
		fft_counter <= fft_counter + 1;
	else 
		fft_counter <= 0;

wire signed [31:0] fir_d_extent = {{8{fir_d[15]}}, fir_d, 8'd0};

// data input
always@(posedge clk or posedge rst)
	if(rst)
		y0 <= 0;
	else if(fir_valid && (fft_counter == 0))
		y0 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y1 <= 0;
	else if(fir_valid && (fft_counter == 1))
		y1 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y2 <= 0;
	else if(fir_valid && (fft_counter == 2))
		y2 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y3 <= 0;
	else if(fir_valid && (fft_counter == 3))
		y3 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y4 <= 0;
	else if(fir_valid && (fft_counter == 4))
		y4 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y5 <= 0;
	else if(fir_valid && (fft_counter == 5))
		y5 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y6 <= 0;
	else if(fir_valid && (fft_counter == 6))
		y6 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y7 <= 0;
	else if(fir_valid && (fft_counter == 7))
		y7 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y8 <= 0;
	else if(fir_valid && (fft_counter == 8))
		y8 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y9 <= 0;
	else if(fir_valid && (fft_counter == 9))
		y9 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y10 <= 0;
	else if(fir_valid && (fft_counter == 10))
		y10 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y11 <= 0;
	else if(fir_valid && (fft_counter == 11))
		y11 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y12 <= 0;
	else if(fir_valid && (fft_counter == 12))
		y12 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y13 <= 0;
	else if(fir_valid && (fft_counter == 13))
		y13 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y14 <= 0;
	else if(fir_valid && (fft_counter == 14))
		y14 <= fir_d_extent;

always@(posedge clk or posedge rst)
	if(rst)
		y15 <= 0;
	else if(fir_valid && (fft_counter == 15))
		y15 <= fir_d_extent;

endmodule
