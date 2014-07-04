module FIR(clk, rst, data_valid, data,
	fir_d, fir_valid);
`include "./dat/FIR_coefficient.dat"

input	clk, rst;
input	data_valid;
input   [15:0] data;

output	fir_valid;
output	[15:0] fir_d;

wire [15:0] fir_d;
reg  [5:0]  fir_counter;
reg   fir_valid;

reg  signed [15:0] data_shift_00;
reg  signed [15:0] data_shift_01;
reg  signed [15:0] data_shift_02;
reg  signed [15:0] data_shift_03;
reg  signed [15:0] data_shift_04;
reg  signed [15:0] data_shift_05;
reg  signed [15:0] data_shift_06;
reg  signed [15:0] data_shift_07;
reg  signed [15:0] data_shift_08;
reg  signed [15:0] data_shift_09;
reg  signed [15:0] data_shift_10;
reg  signed [15:0] data_shift_11;
reg  signed [15:0] data_shift_12;
reg  signed [15:0] data_shift_13;
reg  signed [15:0] data_shift_14;
reg  signed [15:0] data_shift_15;
reg  signed [15:0] data_shift_16;
reg  signed [15:0] data_shift_17;
reg  signed [15:0] data_shift_18;
reg  signed [15:0] data_shift_19;
reg  signed [15:0] data_shift_20;
reg  signed [15:0] data_shift_21;
reg  signed [15:0] data_shift_22;
reg  signed [15:0] data_shift_23;
reg  signed [15:0] data_shift_24;
reg  signed [15:0] data_shift_25;
reg  signed [15:0] data_shift_26;
reg  signed [15:0] data_shift_27;
reg  signed [15:0] data_shift_28;
reg  signed [15:0] data_shift_29;
reg  signed [15:0] data_shift_30;
reg  signed [15:0] data_shift_31;

reg  signed [16:0] adder_00;
reg  signed [16:0] adder_01;
reg  signed [16:0] adder_02;
reg  signed [16:0] adder_03;
reg  signed [16:0] adder_04;
reg  signed [16:0] adder_05;
reg  signed [16:0] adder_06;
reg  signed [16:0] adder_07;
reg  signed [16:0] adder_08;
reg  signed [16:0] adder_09;
reg  signed [16:0] adder_10;
reg  signed [16:0] adder_11;
reg  signed [16:0] adder_12;
reg  signed [16:0] adder_13;
reg  signed [16:0] adder_14;
reg  signed [16:0] adder_15;

reg  signed [36:0] mult_00;
reg  signed [36:0] mult_01;
reg  signed [36:0] mult_02;
reg  signed [36:0] mult_03;
reg  signed [36:0] mult_04;
reg  signed [36:0] mult_05;
reg  signed [36:0] mult_06;
reg  signed [36:0] mult_07;
reg  signed [36:0] mult_08;
reg  signed [36:0] mult_09;
reg  signed [36:0] mult_10;
reg  signed [36:0] mult_11;
reg  signed [36:0] mult_12;
reg  signed [36:0] mult_13;
reg  signed [36:0] mult_14;
reg  signed [36:0] mult_15;

reg  sign_00;
reg  sign_01;
reg  sign_02;
reg  sign_03;
reg  sign_04;
reg  sign_05;
reg  sign_06;
reg  sign_07;
reg  sign_08;
reg  sign_09;
reg  sign_10;
reg  sign_11;
reg  sign_12;
reg  sign_13;
reg  sign_14;
reg  sign_15;
// Adder first level
reg signed [37:0] adder_level1_00;
reg signed [37:0] adder_level1_01;
reg signed [37:0] adder_level1_02;
reg signed [37:0] adder_level1_03;
reg signed [37:0] adder_level1_04;
reg signed [37:0] adder_level1_05;
reg signed [37:0] adder_level1_06;
reg signed [37:0] adder_level1_07;

always@(posedge clk or posedge rst)
	if(rst)
	begin
		adder_level1_00 <= 0;
		adder_level1_01 <= 0;
		adder_level1_02 <= 0;
		adder_level1_03 <= 0;
		adder_level1_04 <= 0;
		adder_level1_05 <= 0;
		adder_level1_06 <= 0;
		adder_level1_07 <= 0;
	end
	else
	begin
		adder_level1_00 <= mult_00 + mult_01; 
		adder_level1_01 <= mult_02 + mult_03; 
		adder_level1_02 <= mult_04 + mult_05; 
		adder_level1_03 <= mult_06 + mult_07; 
		adder_level1_04 <= mult_08 + mult_09; 
		adder_level1_05 <= mult_10 + mult_11; 
		adder_level1_06 <= mult_12 + mult_13; 
		adder_level1_07 <= mult_14 + mult_15; 
	end

// Adder second level
reg signed [38:0] adder_level2_00;
reg signed [38:0] adder_level2_01;
reg signed [38:0] adder_level2_02;
reg signed [38:0] adder_level2_03;

always@(posedge clk or posedge rst)
	if(rst)
	begin
		adder_level2_00 <= 0;
		adder_level2_01 <= 0;
		adder_level2_02 <= 0;
		adder_level2_03 <= 0;
	end
	else
	begin
		adder_level2_00 <= adder_level1_00 + adder_level1_01; 
		adder_level2_01 <= adder_level1_02 + adder_level1_03; 
		adder_level2_02 <= adder_level1_04 + adder_level1_05; 
		adder_level2_03 <= adder_level1_06 + adder_level1_07;
	end

// Adder third level
reg signed [39:0] adder_level3_00;
reg signed [39:0] adder_level3_01;

always@(posedge clk or posedge rst)
	if(rst)
	begin
		adder_level3_00 <= 0;
		adder_level3_01 <= 0;
	end
	else
	begin
		adder_level3_00 <= adder_level2_00 + adder_level2_01; 
		adder_level3_01 <= adder_level2_02 + adder_level2_03; 
	end

reg signed [40:0] adder_final;
always@(posedge clk or posedge rst)
	if(rst)
		adder_final <= 0;
	else
		adder_final <= adder_level3_00 + adder_level3_01;

//assign fir_d = {adder_final[39], adder_final[14:0]};
assign fir_d = {adder_final[40], adder_final[30:16]};

always@(posedge clk or posedge rst)
	if(rst)
	begin
		sign_00 <= 0;
		sign_01 <= 0;
		sign_02 <= 0;
		sign_03 <= 0;
		sign_04 <= 0;
		sign_05 <= 0;
		sign_06 <= 0;
		sign_07 <= 0;
		sign_08 <= 0;
		sign_09 <= 0;
		sign_10 <= 0;
		sign_11 <= 0;
		sign_12 <= 0;
		sign_13 <= 0;
		sign_14 <= 0;
		sign_15 <= 0;

		mult_00 <= 0;
		mult_01 <= 0;
		mult_02 <= 0;
		mult_03 <= 0;
		mult_04 <= 0;
		mult_05 <= 0;
		mult_06 <= 0;
		mult_07 <= 0;
		mult_08 <= 0;
		mult_09 <= 0;
		mult_10 <= 0;
		mult_11 <= 0;
		mult_12 <= 0;
		mult_13 <= 0;
		mult_14 <= 0;
		mult_15 <= 0;
	end
	else
	begin
		sign_00 <= FIR_C00[19] ^ adder_00[16];
		sign_01 <= FIR_C01[19] ^ adder_01[16];
		sign_02 <= FIR_C02[19] ^ adder_02[16];
		sign_03 <= FIR_C03[19] ^ adder_03[16];
		sign_04 <= FIR_C04[19] ^ adder_04[16];
		sign_05 <= FIR_C05[19] ^ adder_05[16];
		sign_06 <= FIR_C06[19] ^ adder_06[16];
		sign_07 <= FIR_C07[19] ^ adder_07[16];
		sign_08 <= FIR_C08[19] ^ adder_08[16];
		sign_09 <= FIR_C09[19] ^ adder_09[16];
		sign_10 <= FIR_C10[19] ^ adder_10[16];
		sign_11 <= FIR_C11[19] ^ adder_11[16];
		sign_12 <= FIR_C12[19] ^ adder_12[16];
		sign_13 <= FIR_C13[19] ^ adder_13[16];
		sign_14 <= FIR_C14[19] ^ adder_14[16];
		sign_15 <= FIR_C15[19] ^ adder_15[16];

		mult_00 <= FIR_C00 * adder_00;
		mult_01 <= FIR_C01 * adder_01;
		mult_02 <= FIR_C02 * adder_02;
		mult_03 <= FIR_C03 * adder_03;
		mult_04 <= FIR_C04 * adder_04;
		mult_05 <= FIR_C05 * adder_05;
		mult_06 <= FIR_C06 * adder_06;
		mult_07 <= FIR_C07 * adder_07;
		mult_08 <= FIR_C08 * adder_08;
		mult_09 <= FIR_C09 * adder_09;
		mult_10 <= FIR_C10 * adder_10;
		mult_11 <= FIR_C11 * adder_11;
		mult_12 <= FIR_C12 * adder_12;
		mult_13 <= FIR_C13 * adder_13;
		mult_14 <= FIR_C14 * adder_14;
		mult_15 <= FIR_C15 * adder_15;
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
	else
	begin
		adder_00 <= data + data_shift_30;
		adder_01 <= data_shift_00 + data_shift_29;
		adder_02 <= data_shift_01 + data_shift_28;
		adder_03 <= data_shift_02 + data_shift_27;
		adder_04 <= data_shift_03 + data_shift_26;
		adder_05 <= data_shift_04 + data_shift_25;
		adder_06 <= data_shift_05 + data_shift_24;
		adder_07 <= data_shift_06 + data_shift_23;
		adder_08 <= data_shift_07 + data_shift_22;
		adder_09 <= data_shift_08 + data_shift_21;
		adder_10 <= data_shift_09 + data_shift_20;
		adder_11 <= data_shift_10 + data_shift_19;
		adder_12 <= data_shift_11 + data_shift_18;
		adder_13 <= data_shift_12 + data_shift_17;
		adder_14 <= data_shift_13 + data_shift_16;
		adder_15 <= data_shift_14 + data_shift_15;
	end

always@(posedge clk or posedge rst)
	if(rst)
	begin
		data_shift_00 <= 16'h0;
		data_shift_01 <= 16'h0;
		data_shift_02 <= 16'h0;
		data_shift_03 <= 16'h0;
		data_shift_04 <= 16'h0;
		data_shift_05 <= 16'h0;
		data_shift_06 <= 16'h0;
		data_shift_07 <= 16'h0;
		data_shift_08 <= 16'h0;
		data_shift_09 <= 16'h0;
		data_shift_10 <= 16'h0;
		data_shift_11 <= 16'h0;
		data_shift_12 <= 16'h0;
		data_shift_13 <= 16'h0;
		data_shift_14 <= 16'h0;
		data_shift_15 <= 16'h0;
		data_shift_16 <= 16'h0;
		data_shift_17 <= 16'h0;
		data_shift_18 <= 16'h0;
		data_shift_19 <= 16'h0;
		data_shift_20 <= 16'h0;
		data_shift_21 <= 16'h0;
		data_shift_22 <= 16'h0;
		data_shift_23 <= 16'h0;
		data_shift_24 <= 16'h0;
		data_shift_25 <= 16'h0;
		data_shift_26 <= 16'h0;
		data_shift_27 <= 16'h0;
		data_shift_28 <= 16'h0;
		data_shift_29 <= 16'h0;
		data_shift_30 <= 16'h0;
		//data_shift_31 <= 16'h0;
	end
	else if(data_valid)
	begin
		data_shift_00 <= data 	       ;//* FIR_C00;
		data_shift_01 <= data_shift_00 ;//* FIR_C01;
		data_shift_02 <= data_shift_01 ;//* FIR_C02;
		data_shift_03 <= data_shift_02 ;//* FIR_C03;
		data_shift_04 <= data_shift_03 ;//* FIR_C04;
		data_shift_05 <= data_shift_04 ;//* FIR_C05;
		data_shift_06 <= data_shift_05 ;//* FIR_C06;
		data_shift_07 <= data_shift_06 ;//* FIR_C07;
		data_shift_08 <= data_shift_07 ;//* FIR_C08;
		data_shift_09 <= data_shift_08 ;//* FIR_C09;
		data_shift_10 <= data_shift_09 ;//* FIR_C10;
		data_shift_11 <= data_shift_10 ;//* FIR_C11;
		data_shift_12 <= data_shift_11 ;//* FIR_C12;
		data_shift_13 <= data_shift_12 ;//* FIR_C13;
		data_shift_14 <= data_shift_13 ;//* FIR_C14;
		data_shift_15 <= data_shift_14 ;//* FIR_C15;
		data_shift_16 <= data_shift_15 ;//* FIR_C16;
		data_shift_17 <= data_shift_16 ;//* FIR_C17;
		data_shift_18 <= data_shift_17 ;//* FIR_C18;
		data_shift_19 <= data_shift_18 ;//* FIR_C19;
		data_shift_20 <= data_shift_19 ;//* FIR_C20;
		data_shift_21 <= data_shift_20 ;//* FIR_C21;
		data_shift_22 <= data_shift_21 ;//* FIR_C22;
		data_shift_23 <= data_shift_22 ;//* FIR_C23;
		data_shift_24 <= data_shift_23 ;//* FIR_C24;
		data_shift_25 <= data_shift_24 ;//* FIR_C25;
		data_shift_26 <= data_shift_25 ;//* FIR_C26;
		data_shift_27 <= data_shift_26 ;//* FIR_C27;
		data_shift_28 <= data_shift_27 ;//* FIR_C28;
		data_shift_29 <= data_shift_28 ;//* FIR_C29;
		data_shift_30 <= data_shift_29 ;//* FIR_C30;
		//data_shift_31 <= data_shift_30 ;//* FIR_C31;
	end

reg signed [15:0] tmp;

always@(posedge clk or posedge rst)
	if(rst)
		tmp <= 0;
	else
		tmp = data_shift_30 * FIR_C31 + data_shift_29 * FIR_C30 + data_shift_28 * FIR_C29 + data_shift_27 * FIR_C28 +
		      data_shift_26 * FIR_C27 + data_shift_25 * FIR_C26 + data_shift_24 * FIR_C25 + data_shift_23 * FIR_C24 +
		      data_shift_22 * FIR_C23 + data_shift_21 * FIR_C22 + data_shift_20 * FIR_C21 + data_shift_19 * FIR_C20 +
		      data_shift_18 * FIR_C19 + data_shift_17 * FIR_C18 + data_shift_16 * FIR_C17 + data_shift_15 * FIR_C16 +
		      data_shift_14 * FIR_C15 + data_shift_13 * FIR_C14 + data_shift_12 * FIR_C13 + data_shift_11 * FIR_C12 +
		      data_shift_10 * FIR_C11 + data_shift_09 * FIR_C10 + data_shift_08 * FIR_C09 + data_shift_07 * FIR_C08 +
		      data_shift_06 * FIR_C07 + data_shift_05 * FIR_C06 + data_shift_04 * FIR_C05 + data_shift_03 * FIR_C04 +
		      data_shift_02 * FIR_C03 + data_shift_01 * FIR_C02 + data_shift_00 * FIR_C01 + data * FIR_C00 ;

reg data_valid_dly;
wire data_valid_start;
wire data_valid_end;

assign	data_valid_start = data_valid && !data_valid_dly;
assign 	data_valid_end = data_valid_dly && !data_valid;

always@(posedge clk or posedge rst)
	if(rst)
		data_valid_dly <= 0;
	else
		data_valid_dly <= data_valid;

always@(posedge clk or posedge rst)
	if(rst)
		fir_counter <= 6'd0;
	else if(|fir_counter)
		fir_counter <= fir_counter + 6'd1;
	else if(data_valid_start || data_valid_end)
		fir_counter <= 1;

always@(posedge clk or posedge rst)
	if(rst)
		fir_valid <= 1'b0;
	else if((fir_counter == 6'd37) && !data_valid)
		fir_valid <= 1'b0;
	else if((fir_counter == 6'd37) && data_valid)
		fir_valid <= 1'b1;

reg [10:0] fir_cnt;
always@(posedge clk or posedge rst)
	if(rst)
		fir_cnt <= 0;
	else if(|fir_cnt)
		fir_cnt <= fir_cnt + 1;
	else if(fir_valid)
		fir_cnt <= 1;
endmodule
