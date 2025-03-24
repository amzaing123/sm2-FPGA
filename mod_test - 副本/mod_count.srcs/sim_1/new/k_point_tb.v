`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/23 15:29:25
// Design Name: 
// Module Name: k_point_tb
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
module k_point_tb();
reg clk;
reg rst_n;
reg [255:0] x;
reg [255:0] y;
reg [255:0] k;
wire [255:0] xx;
wire [255:0] yy;
wire k_valid;
k_point k_point_tb (
	.clk(clk),
    .rst_n(rst_n),
	.x(x),
	.y(y),
	.k(k),
	.xx(xx),
	.yy(yy),
	.k_valid(k_valid)
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
	x=256'h421DEBD61B62EAB6746434EBC3CC315E32220B3BADD50BDC4C4E6C147FEDD43D;
	y=256'h0680512BCBB42C07D47349D2153B70C4E5D7FDFCBFA36EA1A85841B9E46E09A2;
	//k=256'h6CB28D99385C175C94F94E934817663FC176D925DD72B727260DBAAE1FB2F96E;
	k =256'h6FC6DAC32C5D5CF10C77DFB20F7C2EB667A457872FB09EC56327A67EC7DEEBE7;
end
endmodule
