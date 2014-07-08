module FFT_MULTI(clk, rst, valid, real_a, imag_a, real_b, imag_b, Real_coff, Imag_coff, real_out, imag_out);

input clk, rst;
input valid;
input signed [31:0] real_a, imag_a; 	//c+dj
input signed [31:0] real_b, imag_b;	//a+bj
input signed [31:0] Real_coff, Imag_coff;
output signed [31:0] real_out;
output signed [31:0] imag_out;

wire signed [31:0] a_c_sub = real_b - real_a;
wire signed [31:0] d_b_sub = imag_a - imag_b;
wire signed [31:0] b_d_sub = imag_b - imag_a;
reg signed [31:0] real_out;
reg signed [31:0] imag_out;

wire signed [63:0] mult_tmp1 = a_c_sub*Real_coff;
wire signed [63:0] mult_tmp2 = d_b_sub*Imag_coff;
wire signed [63:0] mult_tmp3 = a_c_sub*Imag_coff;
wire signed [63:0] mult_tmp4 = b_d_sub*Real_coff;

wire signed [63:0] adder_tmp1 = mult_tmp1 + mult_tmp2;
wire signed [63:0] adder_tmp2 = mult_tmp3 + mult_tmp4;

always@(posedge clk or posedge rst)
	if(rst)
		real_out <= 0;
	else if(valid) 
		real_out <= {adder_tmp1[63], adder_tmp1[46:16]} ;

always@(posedge clk or posedge rst)
	if(rst)
		imag_out <= 0;
	else if(valid) 
		imag_out <= {adder_tmp2[63], adder_tmp2[46:16]};

endmodule
