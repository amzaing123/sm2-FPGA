`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 20:01:24
// Design Name: 
// Module Name: mult256
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
module mult256(
input clk,
input rst_n,
input [255:0] str1,
input [255:0] str2,
output [511:0] b,
output b_valid
);
reg [2:0] state;
integer n ;
reg [255:0] temp;//str2中间变量
reg [511:0] temp1;//str1中间变量

reg b1_valid;
reg [511:0] b1;
reg [511:0] b2;
// str1 = 256'hABDC5678AEFCD964BCDEF6123697ADCB21365EFDADEB1248789ADEBC2964ABEC;
// str2 = 256'hADB123654EF2614D3645AADC2379ADB7ADBE52CCAEFB4539AD15BC36ADE367FB;
always@(posedge clk or negedge rst_n)
	begin
		if (~rst_n)
		begin
			temp <= 256'd0;
			temp1 <= 512'd0;
			b1 <= 512'd0;
			b2 <= 512'd0;
			state <= 3'd0;
			n <= 0;
			b1_valid <= 0;
		end
		else 
		begin//str1 根据str2的每一位的1或0逻辑左移
			case(state)
				3'd0:begin
						temp <= str2;
						state <=3'd1;
					end
				3'd1:begin
						temp <= {temp[0],temp[255:1]};//temp为str1的中间变量，不断的把最低为移位到最高位
						state <= 3'd2;//然后判断最高位是否为1，为1，则str1逻辑左移n位，temp1为512位中间变量，
					end
				3'd2:begin
						if (temp[255] == 1)//然后对最高位是1的temp1相加，
						begin
							temp1 <= str1 << n;
							state <= 3'd3;//跳到3进行加法
						end
						else
							state <= 3'd4;//跳到4判断n的值是否小于256，在考虑是否进行循环
					end
				3'd3:begin
						if (n <256)
							begin
								b1 <= b1 + temp1;
								n <= n +1;
								state <= 3'd1;
							end
						else 
							state <= 3'd5;
					end
				3'd4:begin
						if (n <256)
							begin
								n <= n +1;
								state <= 3'd1;
							end
						else
							state <=3'd5;
					end
				3'd5:begin
							b2 <= b1;
							b1_valid <= 1;
					end
			endcase
		end
			

	end
	assign b = b2;
	assign b_valid = b1_valid;
endmodule
