`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 15:08:24
// Design Name: 
// Module Name: mod_add
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


module mod_add(
input clk,
input rst_n,
input [255:0] x,
input [255:0] y,
output [255:0] z1,
output z_valid
);
// parameter x=256'h8454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC;
// parameter y=256'h8659ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E;
reg [256:0] z;
reg [256:0] z2;
reg [256:0] P1;

reg z1_valid;
reg [1:0] state=2'd0; 
parameter P=256'h8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3;

always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		z <= 257'd0;
		z2 <= 257'd0;
		P1 <= 257'd0;
		state <= 2'd0;
		z1_valid <= 0;
	end
	else
	begin 
		case(state)
			2'd0:begin 
					z <= x +y;
					state <= 2'd1;
				end
			2'd1:begin
					P1 <= {0,P};//保证P得位数与z相同
					state <= 2'd2;
				end
			2'd2:begin
					if (z >P1)
					begin
						z2 <= z -P1;
						z1_valid <= 1;
					end
					else if (z < P1)
					begin
						z2 <= z;
						z1_valid <= 1;
					end
				end
				default:z2 <=257'd0;
		endcase
	end
end
	assign z1 = z2[255:0];
	assign z_valid = z1_valid;
endmodule
