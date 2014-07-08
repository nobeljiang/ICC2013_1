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

reg y_in_valid;
reg [3:0] fft_counter;

reg signed [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15;

wire signed [31:0] stage1_real_0, stage1_real_1, stage1_real_2, stage1_real_3;
wire signed [31:0] stage1_real_4, stage1_real_5, stage1_real_6, stage1_real_7;
wire signed [31:0] stage1_real_8, stage1_real_9, stage1_real_10, stage1_real_11;
wire signed [31:0] stage1_real_12, stage1_real_13, stage1_real_14, stage1_real_15;

wire signed [31:0] stage1_imag_0, stage1_imag_1, stage1_imag_2, stage1_imag_3;
wire signed [31:0] stage1_imag_4, stage1_imag_5, stage1_imag_6, stage1_imag_7;
wire signed [31:0] stage1_imag_8, stage1_imag_9, stage1_imag_10, stage1_imag_11;
wire signed [31:0] stage1_imag_12, stage1_imag_13, stage1_imag_14, stage1_imag_15;

FFT_ADDER FFT_S1_0(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y0), .imag_a(0), .real_b(y8), .imag_b(0), .real_out(stage1_real_0), .imag_out(stage1_imag_0));
FFT_ADDER FFT_S1_1(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y1), .imag_a(0), .real_b(y9), .imag_b(0), .real_out(stage1_real_1), .imag_out(stage1_imag_1));
FFT_ADDER FFT_S1_2(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y2), .imag_a(0), .real_b(y10), .imag_b(0), .real_out(stage1_real_2), .imag_out(stage1_imag_2));
FFT_ADDER FFT_S1_3(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y3), .imag_a(0), .real_b(y11), .imag_b(0), .real_out(stage1_real_3), .imag_out(stage1_imag_3));
FFT_ADDER FFT_S1_4(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y4), .imag_a(0), .real_b(y12), .imag_b(0), .real_out(stage1_real_4), .imag_out(stage1_imag_4));
FFT_ADDER FFT_S1_5(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y5), .imag_a(0), .real_b(y13), .imag_b(0), .real_out(stage1_real_5), .imag_out(stage1_imag_5));
FFT_ADDER FFT_S1_6(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y6), .imag_a(0), .real_b(y14), .imag_b(0), .real_out(stage1_real_6), .imag_out(stage1_imag_6));
FFT_ADDER FFT_S1_7(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y7), .imag_a(0), .real_b(y15), .imag_b(0), .real_out(stage1_real_7), .imag_out(stage1_imag_7));

FFT_MULTI FFT_S1_8(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y8), .imag_a(0), .real_b(y0), .imag_b(0), .Real_coff(W0_Real), .Imag_coff(W0_Imag), .real_out(stage1_real_8), .imag_out(stage1_imag_8));
FFT_MULTI FFT_S1_9(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y9), .imag_a(0), .real_b(y1), .imag_b(0), .Real_coff(W1_Real), .Imag_coff(W1_Imag), .real_out(stage1_real_9), .imag_out(stage1_imag_9));
FFT_MULTI FFT_S1_10(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y10), .imag_a(0), .real_b(y2), .imag_b(0), .Real_coff(W2_Real), .Imag_coff(W2_Imag), .real_out(stage1_real_10), .imag_out(stage1_imag_10));
FFT_MULTI FFT_S1_11(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y11), .imag_a(0), .real_b(y3), .imag_b(0), .Real_coff(W3_Real), .Imag_coff(W3_Imag), .real_out(stage1_real_11), .imag_out(stage1_imag_11));
FFT_MULTI FFT_S1_12(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y12), .imag_a(0), .real_b(y4), .imag_b(0), .Real_coff(W4_Real), .Imag_coff(W4_Imag), .real_out(stage1_real_12), .imag_out(stage1_imag_12));
FFT_MULTI FFT_S1_13(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y13), .imag_a(0), .real_b(y5), .imag_b(0), .Real_coff(W5_Real), .Imag_coff(W5_Imag), .real_out(stage1_real_13), .imag_out(stage1_imag_13));
FFT_MULTI FFT_S1_14(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y14), .imag_a(0), .real_b(y6), .imag_b(0), .Real_coff(W6_Real), .Imag_coff(W6_Imag), .real_out(stage1_real_14), .imag_out(stage1_imag_14));
FFT_MULTI FFT_S1_15(.clk(clk), .rst(rst), .valid(y_in_valid), .real_a(y15), .imag_a(0), .real_b(y7), .imag_b(0), .Real_coff(W7_Real), .Imag_coff(W7_Imag), .real_out(stage1_real_15), .imag_out(stage1_imag_15));



always@(posedge clk or posedge rst)
	if(rst)
		y_in_valid <= 0;
	else if(fft_counter == 15)
		y_in_valid <= 1;
	else 
		y_in_valid <= 0;

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
