`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 20:07:44
// Design Name: 
// Module Name: mult256_tb
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


module mult256_tb();
reg clk;
reg rst_n;
reg [255:0] str1;
reg [255:0] str2;
wire [511:0] b;
wire b_valid;

mult256 mult256_tb (
	.clk(clk),
    .rst_n(rst_n),
	.str1(str1),
	.str2(str2),
	.b(b),
	.b_valid(b_valid)
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
	str1 = 256'hABDC5678AEFCD964BCDEF6123697ADCB21365EFDADEB1248789ADEBC2964ABEC;
	str2 = 256'hADB123654EF2614D3645AADC2379ADB7ADBE52CCAEFB4539AD15BC36ADE367FB;
	
end
endmodule
