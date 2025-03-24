`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/23 09:24:46
// Design Name: 
// Module Name: pointdouble
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
module pointdouble(
input clk,
input rst_n,
input [255:0] x,
input [255:0] y,
input [255:0] z,
output [255:0] xn,
output [255:0] yn,
output [255:0] zn,
output double_valid);//蒙哥马利，模加，模减
parameter a1=256'h787968B4FA32C3FD2417842E73BBFEFF2F3C848B6831D7E0EC65228B3937E498;
parameter p1=256'd2;
parameter p2=256'd3;
parameter p3=256'd4;
parameter p4=256'd8;
wire [255:0] A1;
wire [255:0] A2;
wire [255:0] A3;
wire [255:0] A4;
wire [255:0] A5;
wire [255:0] A;
wire result_1;
wire result_2;
wire result_3;
wire result_4;

wire [255:0] B1;
wire [255:0] B2;
wire [255:0] B;
wire result_5;
wire result_6;

wire [255:0] C1;
wire [255:0] C2;
wire [255:0] C;
wire result_11;
wire [255:0] x1;
wire [255:0] x2;
wire result_12;
wire result_13;
wire m_1;

wire [255:0] y1;
wire [255:0] y2;
//wire result_13;
wire m_2;
wire m_3;

wire [255:0] z1;
wire result_15;
wire result_16;

wire result_A;
wire result_B;
wire result_x;
wire result_Bx;
wire result_Ay;
wire result_Cy;


wire [255:0] xn_1;
wire [255:0] yn_1;
wire [255:0] zn_1;
//A=3*x^2+a*z^4
montgomery_mul montgomery_mul1 (
	.clk(clk),
    .rst_n(rst_n),
	.x(x),
	.y(x),
	.result(A1),
	.result_valid(result_1)
  );
montgomery_mul montgomery_mul2 (
	.clk(clk),
    .rst_n(result_1),
	.x(A1),
	.y(p2),
	.result(A2),
	.result_valid(result_2)
  );
montgomery_mul montgomery_mul3 (
	.clk(clk),
    .rst_n(rst_n),
	.x(z),
	.y(z),
	.result(A3),
	.result_valid(result_3)
  );
montgomery_mul montgomery_mul4 (
	.clk(clk),
    .rst_n(result_3),
	.x(A3),
	.y(A3),
	.result(A4),
	.result_valid(result_4)
  );
montgomery_mul montgomery_mul5 (
	.clk(clk),
    .rst_n(result_4),
	.x(a1),
	.y(A4),
	.result(A5),
	.result_valid(result_5)
  );
assign result_A = result_2 && result_5;
mod_add mod_add1 (
	.clk(clk),
    .rst_n(result_A),
	.x(A2),
	.y(A5),
	.z1(A),
	.z_valid(z_1)
  );
/////B=4*x*y^2 
montgomery_mul montgomery_mul6 (
	.clk(clk),
    .rst_n(rst_n),
	.x(p3),
	.y(x),
	.result(B1),
	.result_valid(result_6)
  );
montgomery_mul montgomery_mul7 (
	.clk(clk),
    .rst_n(rst_n),
	.x(y),
	.y(y),
	.result(B2),
	.result_valid(result_7)
  );
assign result_B = result_6 && result_7;
montgomery_mul montgomery_mul8 (
	.clk(clk),
    .rst_n(result_B),
	.x(B1),
	.y(B2),
	.result(B),
	.result_valid(result_8)
  );
////C=8*y^4
montgomery_mul montgomery_mul9 (
	.clk(clk),
    .rst_n(rst_n),
	.x(y),
	.y(y),
	.result(C1),
	.result_valid(result_9)
  );
montgomery_mul montgomery_mul10 (
	.clk(clk),
    .rst_n(result_9),
	.x(C1),
	.y(C1),
	.result(C2),
	.result_valid(result_10)
  );
montgomery_mul montgomery_mul11 (
	.clk(clk),
    .rst_n(result_10),
	.x(p4),
	.y(C2),
	.result(C),
	.result_valid(result_11)
  );
///xn=A^2-2*B  
montgomery_mul montgomery_mul12 (
	.clk(clk),
    .rst_n(z_1),
	.x(A),
	.y(A),
	.result(x1),
	.result_valid(result_12)
  );
montgomery_mul montgomery_mul13 (
	.clk(clk),
    .rst_n(result_8),
	.x(p1),
	.y(B),
	.result(x2),
	.result_valid(result_13)
  );
assign result_x = result_12 && result_13;
mod_reduce mod_reduce1 (
	.clk(clk),
    .rst_n(result_x),
	.m(x1),
	.n(x2),
	.M(xn_1),
	.m_valid(m_1)
  );
////yn=A*(B-xn)-C
assign result_Bx = m_1 && result_8;
mod_reduce mod_reduce2 (
	.clk(clk),
    .rst_n(result_Bx),
	.m(B),
	.n(xn_1),
	.M(y1),
	.m_valid(m_2)
  );
assign result_Ay = z_1 && m_2;
montgomery_mul montgomery_mul14 (
	.clk(clk),
    .rst_n(result_Ay),
	.x(A),
	.y(y1),
	.result(y2),
	.result_valid(result_14)
  );
assign result_Cy = result_14 && result_11;
mod_reduce mod_reduce3 (
	.clk(clk),
    .rst_n(result_Cy),
	.m(y2),
	.n(C),
	.M(yn_1),
	.m_valid(m_3)
  );
////zn=2*y*z
montgomery_mul montgomery_mul15 (
	.clk(clk),
    .rst_n(rst_n),
	.x(y),
	.y(z),
	.result(z1),
	.result_valid(result_15)
  );
montgomery_mul montgomery_mul16 (
	.clk(clk),
    .rst_n(result_15),
	.x(p1),
	.y(z1),
	.result(zn_1),
	.result_valid(result_16)
  );
assign xn = xn_1;
assign yn = yn_1;
assign zn = zn_1;
assign double_valid = m_3 && result_16;
endmodule 
