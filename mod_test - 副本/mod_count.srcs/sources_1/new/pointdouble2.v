`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/16 21:20:06
// Design Name: 
// Module Name: pointdouble2
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
module pointdouble2(
input clk,
input rst_n,
input [255:0] x,
input [255:0] y,
input [255:0] z,
output [255:0] xn,
output [255:0] yn,
output [255:0] zn,
output double_valid);
parameter a1=256'h787968B4FA32C3FD2417842E73BBFEFF2F3C848B6831D7E0EC65228B3937E498;
reg double_rst;
integer cnt_double;
always@ (posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		double_rst <= 0;
		cnt_double <= 0;
		//result_temp <=0;
	end
	else if (cnt_double < 8)
	begin
		cnt_double =cnt_double +1;
		double_rst <=0;
	end
	//999-45399最慢
	else if (7 <cnt_double && cnt_double <6269)//6269 7500
	begin
		double_rst <= 1;
		cnt_double <= cnt_double +1;
		
	end
	else if  (cnt_double ==6269)
	begin
			cnt_double <=0;
			double_rst <=0;
	end

end
wire montgomery_mul_rst;
assign montgomery_mul_rst =double_rst;
wire [255:0]x_common1;
wire [255:0]y_common1;
wire [255:0]z_common1;
wire [255:0]x_common2;
wire [255:0]y_common2;
wire [255:0]z_common2;
wire [255:0]x_common3;
wire [255:0]y_common3;
wire [255:0]z_common3;
wire result_1;
wire result_2;
wire result_3;
montgomery_mul montgomery1 (//1
	.clk(clk),
    .rst_n(montgomery_mul_rst),
	.x(x_common1),
	.y(y_common1),
	.result(z_common1),
	.result_valid(result_1)
  );
montgomery_mul montgomery2 (//2
	.clk(clk),
    .rst_n(montgomery_mul_rst),
	.x(x_common2),
	.y(y_common2),
	.result(z_common2),
	.result_valid(result_2)
  );
montgomery_mul montgomery3 (//3
	.clk(clk),
    .rst_n(montgomery_mul_rst),
	.x(x_common3),
	.y(y_common3),
	.result(z_common3),
	.result_valid(result_3)
  );
wire [255:0]x_mod3;
wire [255:0]z_mod3;
wire mux3_valid;
wire mod3_result;
mod3_integer mod3_integer1 (
	.clk(clk),
    .rst_n(mod3_result),
	.x(x_mod3),
	.z(z_mod3),
	.mux_valid(mux3_valid)
  );
wire [255:0]x_mod4;
wire [255:0]z_mod4;
wire mux4_valid;
wire mod4_result;
mod4_integer mod4_integer1 (
	.clk(clk),
    .rst_n(mod4_result),
	.x(x_mod4),
	.z(z_mod4),
	.mux_valid(mux4_valid)
  );
wire [255:0]x_mod2;
wire [255:0]z_mod2;
wire mux2_valid;
wire mod2_result;
wire [255:0]x_mod8;
wire [255:0]z_mod8;
wire mux8_valid;
wire mod8_result;
mod2_integer mod2_integer1 (
	.clk(clk),
    .rst_n(mod2_result),
	.x(x_mod2),
	.z(z_mod2),
	.mux_valid(mux2_valid)
  );
mod8_integer mod8_integer1 (
	.clk(clk),
    .rst_n(mod8_result),
	.x(x_mod8),
	.z(z_mod8),
	.mux_valid(mux8_valid)
  );
wire [255:0]addx_common;
wire [255:0]addy_common;
wire [255:0]addz_common;
wire result_add;
wire z_result;
mod_add mod_add1 (
	.clk(clk),
    .rst_n(result_add),
	.x(addx_common),
	.y(addy_common),
	.z1(addz_common),
	.z_valid(z_result)
  );
wire result_reduce;
wire [255:0]m_common;
wire [255:0]n_common;
wire [255:0]reduce_common;
wire m_result;
mod_reduce mod_reduce1 (//
	.clk(clk),
    .rst_n(result_reduce),
	.m(m_common),
	.n(n_common),
	.M(reduce_common),
	.m_valid(m_result)
  );
reg result_1_temp1;
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		result_1_temp1<=0;
		
	end
	else
	begin
		result_1_temp1<=result_1;
		
	end	
end
wire result;
wire result_1_temp;
assign result=result_1_temp1;
assign result_1_temp =(result_1_temp1^result_1)&&result_1;
reg [2:0]cnt;
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		cnt<=3'd0;
	end
	else
	begin
		if (result_1_temp==1&&cnt<7)
		begin
			cnt<=cnt+1;
		end
	end
end
reg [255:0]x_common1_temp;//
reg [255:0]y_common1_temp;
reg [255:0]z_common1_temp;
reg [255:0]x_common2_temp;//
reg [255:0]y_common2_temp;
reg [255:0]z_common2_temp;
reg [255:0]x_common3_temp;//D
reg [255:0]y_common3_temp;
reg [255:0]z_common3_temp;
reg [3:0]state1;
reg [255:0]x_mod3_temp;
reg [255:0]x_mod4_temp;
reg [255:0]x_mod8_temp;
reg [255:0]x_mod2_temp;

reg mod2_result_temp;
reg mod3_result_temp;
reg mod4_result_temp;
reg mod8_result_temp;

reg result_add_temp;
reg [255:0] addx_common_temp;
reg [255:0] addy_common_temp;
reg [255:0]B2_temp;
reg [255:0]B_temp;
reg [255:0]C_temp;

reg [255:0]m_common_temp;
reg [255:0]n_common_temp;
reg result_reduce_temp;

reg [255:0]xn_temp;
reg [255:0]yn_temp;
reg [255:0]zn_temp;

reg [255:0]reduce_common_temp;
reg double_valid_temp;
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		x_common1_temp<=256'd0;//1
		y_common1_temp<=256'd0;
		z_common1_temp<=256'd0;
		x_common2_temp<=256'd0;//2
		y_common2_temp<=256'd0;
		z_common2_temp<=256'd0;
		x_common3_temp<=256'd0;//3
		y_common3_temp<=256'd0;
		z_common3_temp<=256'd0;
		state1 <=4'd0;
		x_mod3_temp<=256'd0;
		x_mod4_temp<=256'd0;
		x_mod8_temp<=256'd0;
		x_mod2_temp<=256'd0;
		mod2_result_temp<=0;
		mod3_result_temp<=0;
		mod4_result_temp<=0;
		mod8_result_temp<=0;
		result_add_temp<=0;
		addx_common_temp<=256'd0;
		addy_common_temp<=256'd0;
		B_temp<=256'd0;
		B2_temp<=256'd0;
		C_temp<=256'd0;
		m_common_temp<=256'd0;
		n_common_temp<=256'd0;
		result_reduce_temp<=0;
		xn_temp<=256'd0;
		yn_temp<=256'd0;
		zn_temp<=256'd0;
		reduce_common_temp<=256'd0;
		double_valid_temp<=0;
	end
	else
	begin
	case(state1)
		4'd0:begin
			x_common1_temp<=x;//x*x
			y_common1_temp<=x;
			
			x_common2_temp<=y;//y*y
			y_common2_temp<=y;
			
			x_common3_temp<=z;//z*z
			y_common3_temp<=z;
			state1<=4'd1;
		end
		4'd1:begin
			if(result==1&&cnt==1)
			begin
				x_common1_temp<=x;//x
				y_common1_temp<=z_common2;//y*y
				
				x_common2_temp<=z_common2;//y*y
				y_common2_temp<=z_common2;//y*y
				
				x_common3_temp<=z_common3;//z*z
				y_common3_temp<=z_common3;//z*z	
				
				mod3_result_temp<=1;
				x_mod3_temp<=z_common1;//3*x*x
				state1<=4'd2;
			end
		end
		4'd2:begin
			if (result==1&&cnt==2)
			begin
				x_common1_temp<=y;//y
				y_common1_temp<=z;//z
				
				x_common2_temp<=z_common2;//y*y
				y_common2_temp<=y;//
				
				x_common3_temp<=z_common3;//z*z*z*z
				y_common3_temp<=a1;//a1
				
				mod8_result_temp<=1;			
				x_mod8_temp<=z_common2;//8*y*y*y*y
				
				mod4_result_temp<=1;
				x_mod4_temp<=z_common1;//4*y*y*x
				state1<=4'd3;
			end
		end
		4'd3:begin
			if(result==1&&cnt==2)
			begin
				mod2_result_temp<=0;//计算2*B
			end
			if (mux4_valid==1)
			begin					
				mod2_result_temp<=1;
				x_mod2_temp<=z_mod4;
				B_temp<=z_mod4;
			end
			if (result_1_temp==1&&cnt==2)
				mod2_result_temp<=0;
			if (mux2_valid==1)
				B2_temp<=z_mod2;
			/*if (result==1&&cnt==3)
			begin
				x_common3_temp<=z_common3;//z*z*z*z
				y_common3_temp<=a1;//a
				
				mod8_result_temp<=1;
				mod2_result_temp<=1;
				
				x_mod8_temp<=z_common2;//8*y*y*y*y
				x_mod2_temp<=z_common1;//2*y*z
				mod2_result_temp<=1;
				state1 <=4'd4;
			end			*/
			if (result==1&&cnt==3)//A1+A2
			begin
				result_add_temp<=1;
				addx_common_temp<=z_common3;//a*z*z*z*z
				addy_common_temp<=z_mod3;
				state1<=4'd4;	
				
				x_mod2_temp<=z_common1;//2*y*z
				mod2_result_temp<=1;
			end	
			if(mux8_valid==1)
				C_temp<=z_mod8;
		end
		4'd4:begin		
			/*if (result==1&&cnt==4)//A1+A2
			begin
				result_add_temp<=1;
				addx_common_temp<=z_common3;
				addy_common_temp<=z_mod3;
				state1<=4'd5;				
			end	*/	
			if (z_result==1)//A*A
			begin
				x_common1_temp<=addz_common;//A
				y_common1_temp<=addz_common;//A
				state1<=4'd5;
			end
		end
		4'd5:begin
			/*if (z_result==1)//A*A
			begin
				x_common1_temp<=addz_common;//A
				y_common1_temp<=addz_common;//A
				state1<=4'd6;
			end*/
			if (mux2_valid==1)
				zn_temp<=z_mod2;
			if (result==1&&cnt==4)//A*A-2*B
			begin
				result_reduce_temp<=1;
				m_common_temp<=z_common1;//A*A
				n_common_temp<=B2_temp;//2*B
				state1<=4'd6;
			end
		end
		4'd6:begin
			/*if (result==1&&cnt==5)//A*A-2*B
			begin
				result_reduce_temp<=1;
				m_common_temp<=z_common1;//A*A
				n_common_temp<=B2_temp;//2*B
				state1<=4'd7;
			end*/
			if (m_result==1)
			begin
				xn_temp<=reduce_common;//xn
				result_reduce_temp<=0;	
				reduce_common_temp<=reduce_common;				
				state1<=4'd7;
			end
		end
		4'd7:begin
			/*if (m_result==1)
			begin
				xn_temp<=reduce_common;//xn
				result_reduce_temp<=0;	
				reduce_common_temp<=reduce_common;				
				state1<=4'd8;
			end*/
				result_reduce_temp<=1;						
				m_common_temp<=B_temp;//B
				n_common_temp<=reduce_common_temp;//xn
				state1<=4'd8;
		end
		4'd8:begin
				/*result_reduce_temp<=1;						
				m_common_temp<=B_temp;//B
				n_common_temp<=reduce_common_temp;//xn
				state1<=4'd9;*/
			if (m_result==1)//A*(B-xn)
			begin
				x_common1_temp<=addz_common;//A
				y_common1_temp<=reduce_common;//B-xn
				state1<=4'd9;
			end
		end
		4'd9:begin
			/*if (m_result==1)//A*(B-xn)
			begin
				x_common1_temp<=addz_common;//A
				y_common1_temp<=reduce_common;//B-xn
				state1<=4'd10;
			end*/
			if (m_result==1)
				result_reduce_temp<=0;													
			if (result==1&&cnt==5)
			begin
				result_reduce_temp<=1;
				m_common_temp<=z_common1;//A*(B-xn)
				n_common_temp<=C_temp;//C
				state1<=4'd10;
			end
		end
		4'd10:begin
			/*if (m_result==1)
				result_reduce_temp<=0;													
			if (result==1&&cnt==6)
			begin
				result_reduce_temp<=1;
				m_common_temp<=z_common1;//A*(B-xn)
				n_common_temp<=C_temp;//C
				state1<=4'd11;
			end*/
			if (m_result==1)
			begin
				yn_temp<=reduce_common;
				double_valid_temp<=1;
			end
		end
		/*4'd11:begin
			if (m_result==1)
			begin
				yn_temp<=reduce_common;
				double_valid_temp<=1;
			end
		end
		*/
	endcase
	end
end
assign m_common=m_common_temp;
assign n_common=n_common_temp;
assign result_reduce=result_reduce_temp;
assign addx_common=addx_common_temp;
assign addy_common=addy_common_temp;
assign result_add=result_add_temp;
assign mod2_result=mod2_result_temp;
assign mod3_result=mod3_result_temp;
assign mod4_result=mod4_result_temp;
assign mod8_result=mod8_result_temp;
assign x_mod3=x_mod3_temp;
assign x_mod4=x_mod4_temp;
assign x_mod2=x_mod2_temp;
assign x_mod8=x_mod8_temp;
assign x_common1=x_common1_temp;
assign y_common1=y_common1_temp;
assign x_common2=x_common2_temp;
assign y_common2=y_common2_temp;
assign x_common3=x_common3_temp;
assign y_common3=y_common3_temp;

assign xn=xn_temp;
assign yn=yn_temp;
assign zn=zn_temp;
assign double_valid=double_valid_temp;
endmodule
