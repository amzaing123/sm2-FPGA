`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/22 15:00:32
// Design Name: 
// Module Name: pointadd
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
module pointadd(
input clk,
input rst_n,
input [255:0]x,
input [255:0]y,
input [255:0]z,
input [255:0]x1,
input [255:0]y1,
input [255:0]z1,
output [255:0]xr,
output [255:0]yr,
output [255:0]zr,
output xyz_valid
);//蒙哥马利，模加，模减
parameter p2 = 256'd2;
///（1/2）modp可以通过预计算得出为一个定值。
parameter p = 256'h42A16B4F2602278C745C921ADFB7FBEF22B941C8AE22A8BEB9176DC58478EFE2;

wire m_1;
wire m_2;
wire m_3;
wire m_4;
wire m_5;

wire z_1;
wire z_2;

wire [255:0] A1;
wire [255:0] A;
wire result_1;
wire result_2;

wire [255:0] B1;
wire [255:0] B;
wire result_3;
wire result_4;

wire [255:0] C;
wire result_C;//C=A-B

wire [255:0] D1;
wire [255:0] D2;
wire [255:0] D;
wire result_5;
wire result_6;
wire result_7;

wire [255:0] E;
wire [255:0] E1;
wire [255:0] E2;
wire result_8;
wire result_9;
wire result_10;

wire [255:0] F;
wire [255:0] G;
wire [255:0] H;
wire result_F;//F=D-E  
wire result_G;//G=A+B

wire [255:0] xr1;
wire [255:0] xr2;
wire [255:0] xr3;
wire result_FGC;
wire result_GC;
wire result_11;
wire result_12;
wire result_13;

wire [255:0] I1;
wire [255:0] I;
//wire [255:0] xr3;
wire result_14;

wire [255:0] yr1;
wire [255:0] yr2;
wire [255:0] yr3;
wire [255:0] yr4;
wire [255:0] yr5;
wire result_15;
wire result_16;
wire result_17;
wire result_FI;
wire result_HC;

wire [255:0] zr1;
wire result_18;
wire result_19;
wire result_20;
wire result_21;

wire [255:0] xr_n;
wire [255:0] yr_n;
wire [255:0] zr_n;
wire result_x;
wire result_y;
wire result_z;

//A=x*z1*z1
montgomery_mul montgomery1 (
	.clk(clk),
    .rst_n(rst_n),
	.x(z1),
	.y(z1),
	.result(A1),
	.result_valid(result_1)
  );
montgomery_mul montgomery2 (
	.clk(clk),
    .rst_n(result_1),
	.x(x),
	.y(A1),
	.result(A),
	.result_valid(result_2)
  );
  
//x1*z*z
montgomery_mul montgomery3 (
	.clk(clk),
    .rst_n(rst_n),
	.x(z),
	.y(z),
	.result(B1),
	.result_valid(result_3)
  );
montgomery_mul montgomery4 (
	.clk(clk),
    .rst_n(result_3),
	.x(x1),
	.y(B1),
	.result(B),
	.result_valid(result_4)
  );
assign result_C = result_2 && result_4;
// C=A-B
 mod_reduce mod_reduce1 (
	.clk(clk),
    .rst_n(result_C),
	.m(A),
	.n(B),
	.M(C),
	.m_valid(m_1)
  );
 //D = y*z1*z1*z1
montgomery_mul montgomery5 ( //////////ABDE可并行运算
	.clk(clk),
    .rst_n(rst_n),
	.x(z1),
	.y(z1),
	.result(D1),
	.result_valid(result_5)
  );
 montgomery_mul montgomery6 (
	.clk(clk),
    .rst_n(result_5),
	.x(z1),
	.y(D1),
	.result(D2),
	.result_valid(result_6)
  );
  montgomery_mul montgomery7 (
	.clk(clk),
    .rst_n(result_6),
	.x(y),
	.y(D2),
	.result(D),
	.result_valid(result_7)
  );
//E = y1*z*z*z
 montgomery_mul montgomery8 (
	.clk(clk),
    .rst_n(rst_n),
	.x(z),
	.y(z),
	.result(E1),
	.result_valid(result_8)
  );
   montgomery_mul montgomery9 (
	.clk(clk),
    .rst_n(result_8),
	.x(z),
	.y(E1),
	.result(E2),
	.result_valid(result_9)
  );
 montgomery_mul montgomery10 (
	.clk(clk),
    .rst_n(result_9),
	.x(y1),
	.y(E2),
	.result(E),
	.result_valid(result_10)
  );
///F=D-E  G=A+B  H =D+E
assign result_F = result_7 && result_10;
assign result_G = result_2 && result_4;//和result_C一样
mod_reduce mod_reduce2 (
	.clk(clk),
    .rst_n(result_F),
	.m(D),
	.n(E),
	.M(F),
	.m_valid(m_2)
  );
mod_add mod_add1 (
	.clk(clk),
    .rst_n(result_G),
	.x(A),
	.y(B),
	.z1(G),
	.z_valid(z_1)
  );
 mod_add mod_add2 (
	.clk(clk),
    .rst_n(result_F),
	.x(D),
	.y(E),
	.z1(H),
	.z_valid(z_2)
  );
//xr=F^2-G*C^2
 montgomery_mul montgomery11 (
	.clk(clk),
    .rst_n(m_2),
	.x(F),
	.y(F),
	.result(xr1),
	.result_valid(result_11)
  );
montgomery_mul montgomery12 (
	.clk(clk),
    .rst_n(m_1),
	.x(C),
	.y(C),
	.result(xr2),
	.result_valid(result_12)
  );
assign result_GC = z_1 && result_12; 
montgomery_mul montgomery13 (
	.clk(clk),
    .rst_n(result_GC),
	.x(G),
	.y(xr2),
	.result(xr3),//G*C^2
	.result_valid(result_13)
  );
assign result_FGC = result_11 && result_13;
mod_reduce mod_reduce3 (
	.clk(clk),
    .rst_n(result_FGC),
	.m(xr1),
	.n(xr3),
	.M(xr_n),
	.m_valid(m_3)//xr
  );
/// I=G*C^2-2*xr
montgomery_mul montgomery14 (
	.clk(clk),
    .rst_n(m_3),
	.x(p2),
	.y(xr_n),
	.result(I1),
	.result_valid(result_14)
  );
assign result_I = result_13 && result_14;
mod_reduce mod_reduce4 (
	.clk(clk),
    .rst_n(result_I),
	.m(xr3),
	.n(I1),
	.M(I),
	.m_valid(m_4)
  );
////((F*I-H*C^3))/2 
//// y=((FI-HC^3)/2)modp=(FI-HC^3)modp*(1/2)modp,其中（1/2）modp可以通过预计算得出为一个定值。
assign result_FI = m_2 && m_4;
montgomery_mul montgomery15 (
	.clk(clk),
    .rst_n(result_FI),
	.x(F),
	.y(I),
	.result(yr1),
	.result_valid(result_15)
  );
montgomery_mul montgomery16 (
	.clk(clk),
    .rst_n(m_1),
	.x(C),
	.y(C),
	.result(yr2),
	.result_valid(result_16)
  );
montgomery_mul montgomery17 (
	.clk(clk),
    .rst_n(result_16),
	.x(C),
	.y(yr2),
	.result(yr3),///C^3
	.result_valid(result_17)
  );
 assign result_HC = z_2 && result_17;
 montgomery_mul montgomery18 (
	.clk(clk),
    .rst_n(result_HC),
	.x(H),
	.y(yr3),
	.result(yr4),
	.result_valid(result_18)
  );
 assign result_y = result_15 && result_18;
 mod_reduce mod_reduce5 (
	.clk(clk),
    .rst_n(result_y),
	.m(yr1),
	.n(yr4),
	.M(yr5),
	.m_valid(m_5)
  );
 montgomery_mul montgomery19 (
	.clk(clk),
    .rst_n(m_5),
	.x(p),
	.y(yr5),
	.result(yr_n),
	.result_valid(result_19)//yr 
  );
/////zr=z1*z2*C  
montgomery_mul montgomery20 (
	.clk(clk),
    .rst_n(rst_n),
	.x(z1),
	.y(z),
	.result(zr1),
	.result_valid(result_20)
  ); 
 assign result_z = m_1 && result_20;
montgomery_mul montgomery21 (
	.clk(clk),
    .rst_n(result_z),
	.x(zr1),
	.y(C),
	.result(zr_n),
	.result_valid(result_21)//zr
  );
  
assign xr = xr_n;
assign yr = yr_n;
assign zr = zr_n;
assign xyz_valid = result_21 && m_3 && result_19;
endmodule
