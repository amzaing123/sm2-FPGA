`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 14:58:44
// Design Name: 
// Module Name: montgomery_mul_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module montgomery_mul_tb();
reg clk;
reg rst_n;
reg [255:0] x;
reg [255:0] y;
wire [255:0] result;
wire result_valid;
montgomery_mul montgomery_mul_tb (
	.clk(clk),
    .rst_n(rst_n),
	.x(x),
	.y(y),
	.result(result),
	.result_valid(result_valid)
  );
  initial begin//
    clk = 0;
    rst_n =0;
    //state =0;
 end
initial begin
    clk =0;
    forever #5 clk =~clk;
end
initial 
begin
	#10000
	rst_n =1;
	x=256'h8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC5;
	y=256'h4659ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E;
	
end
endmodule
