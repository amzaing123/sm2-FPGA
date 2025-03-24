`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/15 15:05:02
// Design Name: 
// Module Name: mod_inv
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
module mod_inv(
input clk,
input rst_n,
input [255:0]c,
//input [1:0]a,
output [255:0]c_inv,
output c_valid

);
//输入c='128B2FA8BD433C6C068C8D803DFF79792A519A55171B1B650C23661D15897264';//64位16进制
//reg [255:0]p;
 
integer F = 10;
integer G = 10;
integer n = 0;
integer cnt =0;
integer cnt1 =0;
integer cnt2 =0;
//integer q = 0;

//定义中间变量
reg [1:0]t;
reg [3:0] q =4'd0;
reg [3:0] state =4'd0;
reg [1:0] state1 =2'd0;

reg c1_valid;

reg [1:0] dit;
reg [255:0] u,v;
reg [255:0] r;
reg [255:0] temp;
reg [255:0] c1_inv;
reg [256:0] xm;//xm= q*x1;一共257位，高位为符号位
reg [256:0] xn;
reg [255:0] z;
reg [256:0] x;
reg [256:0] x1 =257'd1;
reg [256:0] x2 =257'd0;
//定义常数量
//parameter p1 =256'h8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3;//64位16进制
parameter N =256'h8542D69E4C044F18E8B92435BF6FF7DD297720630485628D5AE74EE7C32E79B7;
parameter m = 252'd0;//用来填充变量
//parameter x2 = 260'd0;

 parameter p=256'h8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3;//64位16进制数
// parameter p=256'h8542D69E4C044F18E8B92435BF6FF7DD297720630485628D5AE74EE7C32E79B7;
always@(posedge clk or negedge rst_n)
begin//0
	if (~rst_n)
	begin
		
		q  <=4'd0;
		dit <=2'd0;
		u <=256'd0;
		v <=256'd0;
		r <=256'd0;
		temp <=256'd0;
		c1_inv <=256'd0;
		z <=256'd0;
		xn <= 7'd0;
		
		xm <=257'd0;
		x <=257'd0;
		x1 <= 257'd1;
		state <= 4'd0;
		t <=0;
		
		c1_valid <= 0;
	end
	/*else if (a == 1)
		p <= p1;
	else if (a == 2)
		p <= N;*/
	else begin//1
	case(state)
		4'd0:begin
			u <= c;
			v <= p;
			state <= 4'd1;
		end
		4'd1:begin//2
			//q <= 4'd0;
			//t <= 0;
			case (t)
				2'd0:
				begin
					if (v >u)
					begin
						q <= q +1;
						v <= v-u;
						t <= 1;
						xn <= xn[255:0] +x1[255:0];
					end
				end
				2'd1:
				begin
					if (v > u)
						t <= 0;
					else if (v < u)
						begin
							state <=4'd2;
							//xn <= q *(x1[3:0]);
						end
						
				end
			endcase//t case
			end//2
		4'd2:begin//3
			r <=v;
			xm <= {x1[256],xn[255:0]};
			state <= 4'd3;
			end
		4'd3:begin
				dit <={x2[256],xm[256]};
				state <= 4'd4;
			end
		4'd4:begin
			case (dit)
				2'd0:begin//00，全为正
						if (x2[255:0] > xm[255:0])
						begin
							//temp <= x2[255:0] -xm[255:0];
							//x <={0,temp};
							x <={0,x2[255:0] -xm[255:0]};
							state <= 4'd5;
						end
						else if (x2[255:0] <xm[255:0])
						begin
							//temp <= xm[255:0] -x2[255:0];
							//x <={1,temp};
							x <={1,xm[255:0] -x2[255:0]};
							state <= 4'd5;
						end
					end
				2'd1:begin//01,算术位直接相加，结果为正
						//temp <= x2[255:0] + xm[255:0];//去掉高位，高位位符号位
						//x <= {0,temp};
						x <={0,xm[255:0] +x2[255:0]};
						state <= 4'd5;
					end
				2'd2:begin//10，x2负，xm正，结果为负
						//z <= x2[255:0] + xm[255:0];
						//x <= {1,z};
						x <={1,xm[255:0] +x2[255:0]};
						state <= 4'd5;
					end
				2'd3:begin//11，全为负，先判断大小
						if (x2[255:0] >xm[255:0])//-5和-3，结果为-2，结果为负
						begin
							//temp <= x2[255:0] - xm[255:0];
							//x <= {1,temp};
							x <={1,x2[255:0] -xm[255:0]};
							state <= 4'd5;
						end
						else if (x2[255:0] < xm[255:0])//-2和-3，结果为1，结果为正
						begin
							//temp <= xm[255:0] -x2[255:0];
							//x <= {0,temp};
							x <={0,xm[255:0] -x2[255:0]};
							state <= 4'd5;
						end
					end
					default : x <= 257'd0;
			endcase//dit case
			
			end//3
		4'd5:begin
				v <= u;
				u <= r;
				x2 <= x1;
				state <=4'd6;
			end
		4'd6:begin		
				x1 <= x;
				F <= u[31:0]-u[255:224]-u[223:192]-u[191:160]-u[159:128]-u[127:96]-u[95:64]-u[63:32];
				G <= u[31:0];
				state <= 4'd7;
			end
		4'd7:begin
				if (F ==1 && G ==1)
					state <=4'd8;
				else
				begin
					state <=4'd1;
					q <= 4'd0;
					t <= 0;
					xn <= 257'd0;
					n <= n +1;
				end
			end
		//end// 的end
		4'd8:begin
				if (x1[256] == 1)
				begin
					 c1_inv <=  p - x1[255:0];//负数同一数量级，p-x1
					 c1_valid <= 1;
				end
				else 
				begin
					 c1_inv <= x1[255:0];
					 c1_valid <= 1;
				end
			 end
	endcase
	end//1
end	//0
		assign c_inv = c1_inv;
		assign c_valid =c1_valid;
endmodule
