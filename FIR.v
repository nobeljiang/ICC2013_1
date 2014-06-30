module FIR(clk, rst, data_valid, data,
	fir_d, fir_valid);
`include "./dat/FIR_coefficient.dat"

input	clk, rst;
input	data_valid;
input   [15:0] data;

output	fir_valid;
output	[15:0] fir_d;

reg  [15:0] fir_d;
reg  [4:0]  fir_counter;
wire fir_valid;

reg  [15:0] data_shift_00;
reg  [15:0] data_shift_01;
reg  [15:0] data_shift_02;
reg  [15:0] data_shift_03;
reg  [15:0] data_shift_04;
reg  [15:0] data_shift_05;
reg  [15:0] data_shift_06;
reg  [15:0] data_shift_07;
reg  [15:0] data_shift_08;
reg  [15:0] data_shift_09;
reg  [15:0] data_shift_10;
reg  [15:0] data_shift_11;
reg  [15:0] data_shift_12;
reg  [15:0] data_shift_13;
reg  [15:0] data_shift_14;
reg  [15:0] data_shift_15;
reg  [15:0] data_shift_16;
reg  [15:0] data_shift_17;
reg  [15:0] data_shift_18;
reg  [15:0] data_shift_19;
reg  [15:0] data_shift_20;
reg  [15:0] data_shift_21;
reg  [15:0] data_shift_22;
reg  [15:0] data_shift_23;
reg  [15:0] data_shift_24;
reg  [15:0] data_shift_25;
reg  [15:0] data_shift_26;
reg  [15:0] data_shift_27;
reg  [15:0] data_shift_28;
reg  [15:0] data_shift_29;
reg  [15:0] data_shift_30;
reg  [15:0] data_shift_31;

assign	fir_valid = (fir_counter == 5'd31);

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
		data_shift_31 <= 16'h0;
	end
	else if(data_valid)
	begin
		data_shift_00 <= data * FIR_C00;
		data_shift_01 <= data_shift_00 * FIR_C01;
		data_shift_02 <= data_shift_01 * FIR_C02;
		data_shift_03 <= data_shift_02 * FIR_C03;
		data_shift_04 <= data_shift_03 * FIR_C04;
		data_shift_05 <= data_shift_04 * FIR_C05;
		data_shift_06 <= data_shift_05 * FIR_C06;
		data_shift_07 <= data_shift_06 * FIR_C07;
		data_shift_08 <= data_shift_07 * FIR_C08;
		data_shift_09 <= data_shift_08 * FIR_C09;
		data_shift_10 <= data_shift_09 * FIR_C10;
		data_shift_11 <= data_shift_10 * FIR_C11;
		data_shift_12 <= data_shift_11 * FIR_C12;
		data_shift_13 <= data_shift_12 * FIR_C13;
		data_shift_14 <= data_shift_13 * FIR_C14;
		data_shift_15 <= data_shift_14 * FIR_C15;
		data_shift_16 <= data_shift_15 * FIR_C16;
		data_shift_17 <= data_shift_16 * FIR_C17;
		data_shift_18 <= data_shift_17 * FIR_C18;
		data_shift_19 <= data_shift_18 * FIR_C19;
		data_shift_20 <= data_shift_19 * FIR_C20;
		data_shift_21 <= data_shift_20 * FIR_C21;
		data_shift_22 <= data_shift_21 * FIR_C22;
		data_shift_23 <= data_shift_22 * FIR_C23;
		data_shift_24 <= data_shift_23 * FIR_C24;
		data_shift_25 <= data_shift_24 * FIR_C25;
		data_shift_26 <= data_shift_25 * FIR_C26;
		data_shift_27 <= data_shift_26 * FIR_C27;
		data_shift_28 <= data_shift_27 * FIR_C28;
		data_shift_29 <= data_shift_28 * FIR_C29;
		data_shift_30 <= data_shift_29 * FIR_C30;
		data_shift_31 <= data_shift_30 * FIR_C31;
	end
	
always@(posedge clk or posedge rst)
	if(rst)
		fir_d <= 16'd0;
	else if(data_valid)
		fir_d <= data_shift_00 + data_shift_01 + data_shift_02 + data_shift_03 +
			 data_shift_04 + data_shift_05 + data_shift_06 + data_shift_07 +
			 data_shift_08 + data_shift_09 + data_shift_10 + data_shift_11 +
			 data_shift_12 + data_shift_13 + data_shift_14 + data_shift_15 +
			 data_shift_16 + data_shift_17 + data_shift_18 + data_shift_19 +
			 data_shift_20 + data_shift_21 + data_shift_22 + data_shift_23 +
			 data_shift_24 + data_shift_25 + data_shift_26 + data_shift_27 +
			 data_shift_28 + data_shift_29 + data_shift_30 + data_shift_31 ;

always@(posedge clk or posedge rst)
	if(rst)
		fir_counter <= 5'd0;
	else if(&fir_counter)
		fir_counter <= 5'd31;
	else if(data_valid)
		fir_counter <= fir_counter + 5'd1;
	else
		fir_counter <= 5'd0;


endmodule
