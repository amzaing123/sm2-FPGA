`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/23 09:25:13
// Design Name: 
// Module Name: pointdouble_tb
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


module pointdouble_tb();
reg clk;
reg rst_n;
reg [255:0] x;
reg [255:0] y;
reg [255:0] z;
wire [255:0] xn;
wire [255:0] yn;
wire [255:0] zn;
wire double_valid;
pointdouble2 pointdouble_tb (
	.clk(clk),
    .rst_n(rst_n),
	.x(x),
	.y(y),
	.z(z),
	.xn(xn),
	.yn(yn),
	.zn(zn),
	.double_valid(double_valid)
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
	z=256'h0000000000000000000000000000000000000000000000000000000000000001;
	//x=256'h04D1DF516231EE428870804D3D5B6993C917DCCEC26D0E1ACCACBCC4624EE423;
	//y=256'h138EBF710F5D32D4694A5C6EC68E29C27562E9CB48144E31F2568C5063BB248A;
	//z=256'h0D00A2579768580FA8E693A42A76E189CBAFFBF97F46DD4350B08373C8DC1344;
	//x=256'h7049FAD0B15BF8370C5ECB1946ED72B2C307F20868C9EE80E470087BBFDABF42;
	//y=256'h4417C289540201260C356BD2142F59BC7AFC84CE202B43DD6E968B660AED48E9;
	//z=256'h126582F56440EB12B74E8601421F4BE9C40E491AE57034171FEA24CF23C79E94;
end
endmodule
