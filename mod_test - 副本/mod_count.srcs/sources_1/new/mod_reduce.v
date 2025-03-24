`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 17:01:50
// Design Name: 
// Module Name: mod_reduce
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
module mod_reduce(
input clk,
input rst_n,
input [255:0]m,
input [255:0]n,
output [255:0]M,
output m_valid
);
reg [256:0] M1;
reg [255:0] M0;
reg [1:0]state;
reg m1_valid;
//reg 
parameter P=256'h8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3;
// a='2454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';
// b='3159ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		M0 <= 257'd0;
		M1 <= 257'd0;
		m1_valid <= 0;
		state <=2'd0;
	end
	else if (m >n)
	begin
		case(state)
		2'd0:begin
				M0[255:0] <= m -n;
				state <=2'd1;
		end
		2'd1:begin
			if (M0[255:0] >P)
			begin	
				M1[255:0] <= M0[255:0]-P;
				m1_valid <= 1;
			end
			else if (M0 <P)
			begin
				M1 <= M0;
				m1_valid <= 1;
			end
		end
		endcase
	end
	else if (m <n)//m-n为负数，负数取模
	begin
		M1 <= m +P -n;//同一数量级，取模即为（m-n）+p
		m1_valid <= 1;
	end

end
assign M = M1[255:0];
assign m_valid = m1_valid;
endmodule
