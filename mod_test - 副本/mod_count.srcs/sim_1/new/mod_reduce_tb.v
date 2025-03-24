`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 17:02:54
// Design Name: 
// Module Name: mod_reduce_tb
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


module mod_reduce_tb();
reg clk;
reg rst_n;
reg [255:0] m;
reg [255:0] n;
wire [255:0] M;
wire m_valid;

mod_reduce mod_reduce_tb (
	.clk(clk),
    .rst_n(rst_n),
	.m(m),
	.n(n),
	.M(M),
	.m_valid(m_valid)
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
	m=256'h2454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC;
	n=256'h3159ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E;
	
end
endmodule
