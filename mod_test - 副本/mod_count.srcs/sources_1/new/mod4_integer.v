`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/12 19:56:18
// Design Name: 
// Module Name: mod3_integer
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


module mod4_integer(//x*4
input clk,
input rst_n,
input [255:0]x,
output [255:0]z,
output mux_valid
    );
reg [257:0]z_temp1;
reg [255:0]z_temp;
reg [1:0]state;
reg mux_valid1;
parameter P=256'h8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3;
reg [257:0]	P1;
always@ (posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		state<=2'd0;
		z_temp1<=258'd0;
		P1<=258'd0;
		mux_valid1<=0;
		z_temp<=256'd0;
	end
	else
	begin
		case(state)
		2'd0:begin
			z_temp1<=x<<2;
			state<=2'd1;
			P1<={2'd0,P};
		end
		2'd1:begin
			if (z_temp1>P1)
			begin
				//z_temp1<=z_temp1-P1;
				state<=2'd2;
			end
			else if(z_temp1<P1)
			begin
				z_temp<=z_temp1[255:0];
				mux_valid1<=1;
			end
		end
		2'd2:begin
			z_temp1<=z_temp1-P1;
			state<=2'd1;
		
		end
		endcase
	end

end
assign z=z_temp;
assign mux_valid=mux_valid1;
endmodule
