`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 15:08:53
// Design Name: 
// Module Name: mod_add_tb
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


module mod_add_tb();
reg clk;
reg rst_n;
reg [255:0] x;
reg [255:0] y;
wire [256:0] z1;
wire z_valid;
mod_add mod_add_tb (
	.clk(clk),
    .rst_n(rst_n),
	.x(x),
	.y(y),
	.z1(z1),
	.z_valid(z_valid)
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
	x=256'h8454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC;
	y=256'h8659ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E;
	
end
endmodule
