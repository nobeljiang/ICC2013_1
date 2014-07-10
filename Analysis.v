module Analysis(clk, rst, 
	fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7,  
	fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15,
	fft_valid, done, freq);

input clk, rst;
input [31:0] fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7;
input [31:0] fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15;
input fft_valid;
output done;
output [3:0] freq;

reg signed [31:0] real_square_00;
reg signed [31:0] real_square_01;
reg signed [31:0] real_square_02;
reg signed [31:0] real_square_03;
reg signed [31:0] real_square_04;
reg signed [31:0] real_square_05;
reg signed [31:0] real_square_06;
reg signed [31:0] real_square_07;
reg signed [31:0] real_square_08;
reg signed [31:0] real_square_09;
reg signed [31:0] real_square_10;
reg signed [31:0] real_square_11;
reg signed [31:0] real_square_12;
reg signed [31:0] real_square_13;
reg signed [31:0] real_square_14;
reg signed [31:0] real_square_15;

reg signed [31:0] imag_square_00;
reg signed [31:0] imag_square_01;
reg signed [31:0] imag_square_02;
reg signed [31:0] imag_square_03;
reg signed [31:0] imag_square_04;
reg signed [31:0] imag_square_05;
reg signed [31:0] imag_square_06;
reg signed [31:0] imag_square_07;
reg signed [31:0] imag_square_08;
reg signed [31:0] imag_square_09;
reg signed [31:0] imag_square_10;
reg signed [31:0] imag_square_11;
reg signed [31:0] imag_square_12;
reg signed [31:0] imag_square_13;
reg signed [31:0] imag_square_14;
reg signed [31:0] imag_square_15;

reg signed [32:0] adder_00;
reg signed [32:0] adder_01;
reg signed [32:0] adder_02;
reg signed [32:0] adder_03;
reg signed [32:0] adder_04;
reg signed [32:0] adder_05;
reg signed [32:0] adder_06;
reg signed [32:0] adder_07;
reg signed [32:0] adder_08;
reg signed [32:0] adder_09;
reg signed [32:0] adder_10;
reg signed [32:0] adder_11;
reg signed [32:0] adder_12;
reg signed [32:0] adder_13;
reg signed [32:0] adder_14;
reg signed [32:0] adder_15;

reg [36:0] comp1_0;
reg [36:0] comp1_1;
reg [36:0] comp1_2;
reg [36:0] comp1_3;
reg [36:0] comp1_4;
reg [36:0] comp1_5;
reg [36:0] comp1_6;
reg [36:0] comp1_7;

reg [36:0] comp2_0;
reg [36:0] comp2_1;
reg [36:0] comp2_2;
reg [36:0] comp2_3;

reg [36:0] comp3_0;
reg [36:0] comp3_1;

reg [3:0] freq;

reg fft_valid_d1;
reg fft_valid_d2;
reg fft_valid_d3;
reg fft_valid_d4;
reg fft_valid_d5;
reg done;


always@(posedge clk or posedge rst)
	if(rst)
	begin
		real_square_00 <= 0;
		real_square_01 <= 0;
		real_square_02 <= 0;
		real_square_03 <= 0;
		real_square_04 <= 0;
		real_square_05 <= 0;
		real_square_06 <= 0;
		real_square_07 <= 0;
		real_square_08 <= 0;
		real_square_09 <= 0;
		real_square_10 <= 0;
		real_square_11 <= 0;
		real_square_12 <= 0;
		real_square_13 <= 0;
		real_square_14 <= 0;
		real_square_15 <= 0;
	end
	else if(fft_valid)
	begin
		real_square_00 <= $signed(fft_d0[31:16])  * $signed(fft_d0[31:16]);
		real_square_01 <= $signed(fft_d1[31:16])  * $signed(fft_d1[31:16]);
		real_square_02 <= $signed(fft_d2[31:16])  * $signed(fft_d2[31:16]);
		real_square_03 <= $signed(fft_d3[31:16])  * $signed(fft_d3[31:16]);
		real_square_04 <= $signed(fft_d4[31:16])  * $signed(fft_d4[31:16]);
		real_square_05 <= $signed(fft_d5[31:16])  * $signed(fft_d5[31:16]);
		real_square_06 <= $signed(fft_d6[31:16])  * $signed(fft_d6[31:16]);
		real_square_07 <= $signed(fft_d7[31:16])  * $signed(fft_d7[31:16]);
		real_square_08 <= $signed(fft_d8[31:16])  * $signed(fft_d8[31:16]);
		real_square_09 <= $signed(fft_d9[31:16])  * $signed(fft_d9[31:16]);
		real_square_10 <= $signed(fft_d10[31:16]) * $signed(fft_d10[31:16]);
		real_square_11 <= $signed(fft_d11[31:16]) * $signed(fft_d11[31:16]);
		real_square_12 <= $signed(fft_d12[31:16]) * $signed(fft_d12[31:16]);
		real_square_13 <= $signed(fft_d13[31:16]) * $signed(fft_d13[31:16]);
		real_square_14 <= $signed(fft_d14[31:16]) * $signed(fft_d14[31:16]);
		real_square_15 <= $signed(fft_d15[31:16]) * $signed(fft_d15[31:16]);
	end

always@(posedge clk or posedge rst)
	if(rst)
	begin
		imag_square_00 <= 0;
		imag_square_01 <= 0;
		imag_square_02 <= 0;
		imag_square_03 <= 0;
		imag_square_04 <= 0;
		imag_square_05 <= 0;
		imag_square_06 <= 0;
		imag_square_07 <= 0;
		imag_square_08 <= 0;
		imag_square_09 <= 0;
		imag_square_10 <= 0;
		imag_square_11 <= 0;
		imag_square_12 <= 0;
		imag_square_13 <= 0;
		imag_square_14 <= 0;
		imag_square_15 <= 0;
	end
	else if(fft_valid)
	begin
		imag_square_00 <= $signed(fft_d0[15:0])  * $signed(fft_d0[15:0]);
		imag_square_01 <= $signed(fft_d1[15:0])  * $signed(fft_d1[15:0]);
		imag_square_02 <= $signed(fft_d2[15:0])  * $signed(fft_d2[15:0]);
		imag_square_03 <= $signed(fft_d3[15:0])  * $signed(fft_d3[15:0]);
		imag_square_04 <= $signed(fft_d4[15:0])  * $signed(fft_d4[15:0]);
		imag_square_05 <= $signed(fft_d5[15:0])  * $signed(fft_d5[15:0]);
		imag_square_06 <= $signed(fft_d6[15:0])  * $signed(fft_d6[15:0]);
		imag_square_07 <= $signed(fft_d7[15:0])  * $signed(fft_d7[15:0]);
		imag_square_08 <= $signed(fft_d8[15:0])  * $signed(fft_d8[15:0]);
		imag_square_09 <= $signed(fft_d9[15:0])  * $signed(fft_d9[15:0]);
		imag_square_10 <= $signed(fft_d10[15:0]) * $signed(fft_d10[15:0]);
		imag_square_11 <= $signed(fft_d11[15:0]) * $signed(fft_d11[15:0]);
		imag_square_12 <= $signed(fft_d12[15:0]) * $signed(fft_d12[15:0]);
		imag_square_13 <= $signed(fft_d13[15:0]) * $signed(fft_d13[15:0]);
		imag_square_14 <= $signed(fft_d14[15:0]) * $signed(fft_d14[15:0]);
		imag_square_15 <= $signed(fft_d15[15:0]) * $signed(fft_d15[15:0]);
	end

always@(posedge clk or posedge rst)
	if(rst)
	begin
		adder_00 <= 0;
		adder_01 <= 0;
		adder_02 <= 0;
		adder_03 <= 0;
		adder_04 <= 0;
		adder_05 <= 0;
		adder_06 <= 0;
		adder_07 <= 0;
		adder_08 <= 0;
		adder_09 <= 0;
		adder_10 <= 0;
		adder_11 <= 0;
		adder_12 <= 0;
		adder_13 <= 0;
		adder_14 <= 0;
		adder_15 <= 0;
	end
	else if(fft_valid_d1)
	begin
		adder_00 <= real_square_00 + imag_square_00;
		adder_01 <= real_square_01 + imag_square_01;
		adder_02 <= real_square_02 + imag_square_02;
		adder_03 <= real_square_03 + imag_square_03;
		adder_04 <= real_square_04 + imag_square_04;
		adder_05 <= real_square_05 + imag_square_05;
		adder_06 <= real_square_06 + imag_square_06;
		adder_07 <= real_square_07 + imag_square_07;
		adder_08 <= real_square_08 + imag_square_08;
		adder_09 <= real_square_09 + imag_square_09;
		adder_10 <= real_square_10 + imag_square_10;
		adder_11 <= real_square_11 + imag_square_11;
		adder_12 <= real_square_12 + imag_square_12;
		adder_13 <= real_square_13 + imag_square_13;
		adder_14 <= real_square_14 + imag_square_14;
		adder_15 <= real_square_15 + imag_square_15;
	end


always@(posedge clk or posedge rst)
	if(rst)
	begin
		comp1_0 <= 0;
		comp1_1 <= 0;
		comp1_2 <= 0;
		comp1_3 <= 0;
		comp1_4 <= 0;
		comp1_5 <= 0;
		comp1_6 <= 0;
		comp1_7 <= 0;
	end
	else if(fft_valid_d2)
	begin
		comp1_0 <= (adder_00 > adder_01) ? {4'd0,  adder_00} : {4'd1,  adder_01};
		comp1_1 <= (adder_02 > adder_03) ? {4'd2,  adder_02} : {4'd3,  adder_03};
		comp1_2 <= (adder_04 > adder_05) ? {4'd4,  adder_04} : {4'd5,  adder_05};
		comp1_3 <= (adder_06 > adder_07) ? {4'd6,  adder_06} : {4'd7,  adder_07};
		comp1_4 <= (adder_08 > adder_09) ? {4'd8,  adder_08} : {4'd9,  adder_09};
		comp1_5 <= (adder_10 > adder_11) ? {4'd10, adder_10} : {4'd11, adder_11};
		comp1_6 <= (adder_12 > adder_13) ? {4'd12, adder_12} : {4'd13, adder_13};
		comp1_7 <= (adder_14 > adder_15) ? {4'd14, adder_14} : {4'd15, adder_15};
	end

always@(posedge clk or posedge rst)
	if(rst)
	begin
		comp2_0 <= 0;
		comp2_1 <= 0;
		comp2_2 <= 0;
		comp2_3 <= 0;
	end
	else if(fft_valid_d3)
	begin
		comp2_0 <= (comp1_0[32:0] > comp1_1[32:0]) ? comp1_0 : comp1_1;
		comp2_1 <= (comp1_2[32:0] > comp1_3[32:0]) ? comp1_2 : comp1_3;
		comp2_2 <= (comp1_4[32:0] > comp1_5[32:0]) ? comp1_4 : comp1_5;
		comp2_3 <= (comp1_6[32:0] > comp1_7[32:0]) ? comp1_6 : comp1_7;
	end

always@(posedge clk or posedge rst)
	if(rst)
	begin
		comp3_0 <= 0;
		comp3_1 <= 0;
	end
	else if(fft_valid_d4)
	begin
		comp3_0 <= (comp2_0[32:0] > comp2_1[32:0]) ? comp2_0 : comp2_1;
		comp3_1 <= (comp2_2[32:0] > comp2_3[32:0]) ? comp2_2 : comp2_3;
	end

always@(posedge clk or posedge rst)
	if(rst)
		freq <= 0;
	else if(fft_valid_d5)
		freq <= (comp3_0[32:0] > comp3_1[32:0]) ? comp3_0[36:33] : comp3_1[36:33];

always@(posedge clk or posedge rst)
	if(rst)
	begin
		fft_valid_d1 <= 0;
		fft_valid_d2 <= 0;
		fft_valid_d3 <= 0;
		fft_valid_d4 <= 0;
		fft_valid_d5 <= 0;
		done <= 0;
	end
	else
	begin
		fft_valid_d1 <= fft_valid;
		fft_valid_d2 <= fft_valid_d1;
		fft_valid_d3 <= fft_valid_d2;
		fft_valid_d4 <= fft_valid_d3;
		fft_valid_d5 <= fft_valid_d4;
		done <= fft_valid_d5;
	end
endmodule
