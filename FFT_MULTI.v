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

always@(posedge clk or posedge rst)
	if(rst)
		real_out <= 0;
	else if(valid) 
		real_out <= a_c_sub*Real_coff + d_b_sub*Imag_coff;

always@(posedge clk or posedge rst)
	if(rst)
		imag_out <= 0;
	else if(valid) 
		imag_out <= a_c_sub*Imag_coff + b_d_sub*Real_coff;

endmodule
