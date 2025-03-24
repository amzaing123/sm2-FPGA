`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/23 15:28:54
// Design Name: 
// Module Name: k_point
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
module k_point(
input clk,
input rst_n,
input [255:0]x,
input [255:0]y,
input [255:0]k,
output [255:0]xx,
output [255:0]yy,
output k_valid
);
wire [255:0]x1;
wire [255:0]y1;
wire [255:0]z1;
//reg [255:0] temp1;

reg result1 =0;
reg result2=0;
reg [1:0]state;
integer n=0;

wire add_valid;
wire add_valid1;
wire [255:0]xn2;
wire [255:0]zn2;
wire [255:0]yn2;
wire result_double;
wire double_valid;
//倍点的输出变釿
wire [255:0]xn1;
wire [255:0]yn1;
wire [255:0]zn1;
//q变量不断点加的中间变釿
wire [255:0]xq1;
wire [255:0]yq1;
wire [255:0]zq1;
//输出结果变量
wire [255:0]xr1;
wire [255:0]yr1;
wire [255:0]zr1;
wire result_inv;

wire [255:0]z2;
wire c_1;


//wire result_s ;
wire result_256;
//reg result3 =0;
//wire result_s1;
 
//reg [1:0]state1;
integer m=0;
integer q=0;
//integer p=0;

/*reg m_valid =0;
wire m1_valid =0;*/
//wire double_valid1;
//wire double_valid12;
//integer cnt;
//integer clk_temp;
integer double_rst;
integer cnt_double;


integer result_temp;
reg result;
wire rst_240;
//wire clk100; 
reg [255:0]xn;
reg [255:0]zn;
reg [255:0]yn;

reg [255:0]xr;
reg [255:0]zr;
reg [255:0]yr;

reg [255:0]x_temp;
reg [255:0]y_temp;
reg [255:0]z_temp;
// wire [255:0]x_temp1;
// wire [255:0]z_temp1;
// wire [255:0]y_temp1;

// reg [255:0]x_temp1;
// reg [255:0]y_temp1;
// reg [255:0]z_temp1;



reg [255:0]xr2;
reg [255:0]yr2;
reg [255:0]zr2;



integer double_valid_delay;
wire double_valid_up1;
wire double_valid_delay1;
//integer temp;
//integer ad_up;
reg add_valid1_delay;
wire add_valid_up;
wire add_valid_up1;
parameter z=256'h0000000000000000000000000000000000000000000000000000000000000001;
//时钟分频周期200us
//倍点复位
always@ (posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		double_rst <= 0;
		cnt_double <= 0;
		result_temp <=0;
	end
	else if (cnt_double < 100)
	begin
		cnt_double =cnt_double +1;
		double_rst <=0;
	end
	else if (99 <cnt_double && cnt_double <37999)//45399 15499 1549 1649
	begin
		double_rst <= 1;
		cnt_double <= cnt_double +1;
		if (100<cnt_double && cnt_double<200)//1000-2000
		begin
			result_temp <=1;
		end
		else 
		begin
			result_temp <=0;
		end
	end
	/*else if (1000<cnt_double && cnt_double<2000)
	begin
		result_temp <=1;
	end*/
	else if  (cnt_double ==37999)
	begin
			cnt_double <=0;
			double_rst <=0;
	end

end
//assign result = result_temp;
reg rst_240_delay;
wire rst_240_delay1;
wire rst_240_up1;
assign rst_240 = double_rst; 

assign result_double = rst_240 && (~result);

always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		rst_240_delay <=0;
	end
	else
	begin
		if (rst_240 ==1)
			rst_240_delay <=rst_240;
		else
			rst_240_delay <=0;	
	end
end
assign rst_240_delay1 =rst_240 ^ rst_240_delay;
assign rst_240_up1 = rst_240_delay1 && rst_240;
pointdouble2 pointdouble_tb (
	.clk(clk),
    .rst_n(result_double),
	.x(x1),
	.y(y1),
	.z(z1),
	.xn(xn1),
	.yn(yn1),
	.zn(zn1),
	.double_valid(double_valid)
  );
//倍点完成标志位延时
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		double_valid_delay <=0;
		//temp <=0;
	end
	else
	begin
		if (double_valid == 1)		
		double_valid_delay <= double_valid;
		/*begin
			if (temp == 13299)
			begin
				double_valid_delay <= double_valid;
				temp <=0;				
			end
			else
			begin
				temp <= temp +1;
			end
		end*/
		else
		begin
			double_valid_delay <=0;
		end
	end
end
assign  double_valid_delay1 = double_valid_delay ^ double_valid;//double_valid延时127us信号与原信号与运算
/*always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
		ad_up <=0;
	else
	begin
		if (double_valid_delay1 == 1)
		begin
			ad_up <= double_valid_delay1;
		end
		else
		begin
			ad_up <=0;
		end
		
	end
end*/
//assign  double_valid_up = ad_up ^ double_valid_delay1;
assign double_valid_up1 = double_valid_delay1 && double_valid;//取double_valid_delay1 的中间上升沿
always@(posedge clk or negedge rst_n )
begin
		if (~rst_n)
		begin
			xn <= 256'd0;
			yn <= 256'd0;
			zn <= 256'd0;
			/*xn2 <= 256'd0;
			yn2 <= 256'd0;
			zn2 <= 256'd0;*/
		end
		else if (double_valid_up1 == 1)
		begin
			xn <= xn1;
			yn <= yn1;
			zn <= zn1;
			/*xn2 <= xn1;
			yn2 <= yn1;
			zn2 <= zn1;*/
		end
end
assign x1 = (q < 1) ? x:xn;
assign y1 = (q < 1) ? y:yn;
assign z1 = (q < 1) ? z:zn;
always@(posedge clk or negedge rst_n)
begin
		if (~rst_n)
		begin
			q <= 0;
			result1 <=0;			
		end
		else if (double_valid_up1 == 1 && q <255)
				begin
					q <= q+1;
					result1 <=0;
				end	
		else if (q == 255)
				begin
					//q <= 0;
					result1 <=1;//为点加运算是否完成的标志位，完成为1，否则为0
				end	


end						
always@(posedge clk or negedge rst_n)
begin
		if (~rst_n)
		begin
			n <= 0;
			result2 <=0;
			result <=0;
			m <= 0;
			state <=2'd0;
			x_temp <=256'd0;
			y_temp <=256'd0;
			z_temp <=256'd0;
			x_temp <=256'd0;
			y_temp <=256'd0;
			z_temp <=256'd0;
		end
		else begin												
			case (state)
			2'd0:begin
					if (rst_240_up1 ==1)
					begin
						n <= n+1;
						state <=2'd1;
					end	
			end
			2'd1:begin
					if (k[n] == 1)
						begin
							result2 <=1;//k[n]为1的标志符号	
							m <= m+1;
							state <=2'd2;
						end
						else
						begin
							result2 <=0;
							state <=2'd2;
						end
				end
						/*
						else if (m == 2)
						begin
							x_temp <=xn1;
							z_temp <=yn1;
							y_temp <=zn1;
						end*/
			2'd2:begin
					//if (double_valid_up1 == 1 && result2 ==1)//old
					/*if (m==2 && double_valid_up1 == 1)
					begin
						n <=n+1;
					
					end*/
					//if (double_valid_up1 == 1 && result2 ==1 && m>2)//old
				if (m>2)
				begin
					if (add_valid_up1 == 1 && result2 ==1 )
						begin
							x_temp <=xn1;
							y_temp <=yn1;
							z_temp <=zn1;
							
						end
				end
				else if (m <=2)
						state <=2'd3;
				/*if (double_valid_up1 == 1 && result2 ==1 && m ==2)
				begin
							x_temp <=xn1;
							y_temp <=yn1;
							z_temp <=zn1;
							
						end*/
					if (m >2 && add_valid_up1 ==1 && n<257)//old
						//if ( n<257)
						begin	
								/*if (m ==3 )//new add	
								begin
									result <=0;
									state <=2'd0;																
								end
								else
								begin*/
								
									//n <= n+1;									
									result <=0;
									state <=2'd0;
								//end
							if (k[0] == 1 && n == 255)
							begin
									/*x_temp1 <=x;
									y_temp1 <=y;
									z_temp1 <=z;*/
									x_temp <=x;
									y_temp <=y;
									z_temp <=z;								
									//result <=1;									
							end								
							/*if (k[0] ==1 && n ==257)
							 result <=1;
							if (k[0]==0 && n ==256)
							result<=1;*/
							
						end
					else if (n == 256 && k[0] ==0 )
						begin	
								result <=1;//为点加运算是否完成的标志位，完成为1，否则为0
						end	
					else if (k[0] == 1 && n==257 )
					begin
								result <=1;		
					end
					
					
			end
			2'd3:begin
					// if (double_valid_up1 == 1 && k[0] ==1)
						// begin							
							// result_s <=1;
						// end
					// else result_s <=0;
					if (double_valid_up1 == 1 && result2 ==1 && m ==2)
						begin
							x_temp <=xn1;
							y_temp <=yn1;
							z_temp <=zn1;
							
						end//old
						
					//if (double_valid_up1 == 1 && n <255)//old
					if(double_valid_up1 == 1 && n <255 ) //||(add_valid_up1 == 1 && n <255 && m==2)
						begin
							
							
							result <=0;
							state <=2'd0;
							
						end	
						/*if( n <255 ) //||(add_valid_up1 == 1 && n <255 && m==2)
						begin
							
							
							result <=0;
							state <=2'd0;
							
						end
					/*else if (n == 255)
						begin
							if (k[0] == 1)
								begin
									x_temp <=x;
									y_temp <=y;
									z_temp <=z;	
									result <=0;
								end
								
							else
								result <=1;//为点加运算是否完成的标志位，完成为1，否则为0
						end		*/		
				 end
			
			endcase
		end

end
assign xn2 = x_temp;
assign yn2 = y_temp;
assign zn2 = z_temp;

//点加运算
// assign xn2 = (result_s)? x:x_temp;
// assign yn2 = (result_s)? y:y_temp;
// assign zn2 = (result_s)? z:z_temp;
//assign result_s = result && add_valid;
//assign result_s1= result && result_s;
assign result_256 = rst_240 && (~result) ;//&& result2;
pointadd2 pointadd_tb1 (
	.clk(clk),
    .rst_n(result_256),
	.x(xq1),
	.y(yq1),
	.z(zq1),
	.x1(xn2),
	.y1(yn2),
	.z1(zn2),
	.xr(xr1),
	.yr(yr1),
	.zr(zr1),
	.xyz_valid(add_valid)
  );

//点加复位延迟
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		add_valid1_delay <=0;
		
	end
	else
	begin
		if (add_valid == 1)		
		add_valid1_delay <= add_valid;
		else
		begin
			add_valid1_delay <=0;
		end
	end
end  
assign add_valid_up = add_valid1_delay ^ add_valid;
assign add_valid_up1 = add_valid_up && add_valid;
always@(posedge clk or negedge rst_n )
begin
		if (~rst_n)
		begin
			xr <= 256'd0;
			yr <= 256'd0;
			zr <= 256'd0;			
		end
		else begin
		if (double_valid_up1 == 1 && m==1 && result2 ==1)
		begin
			xr <= xn1;
			yr <= yn1;
			zr <= zn1;
			/*if (m == 2)
			begin
				xr = xn;
				yr = yn;
				zr = zn;			
			end	*/			
		end
		else if (m >2 && add_valid_up1==1 && result2 ==1)
			begin			
				xr <= xr1;
				yr <= yr1;
				zr <= zr1;
			end	
		else if (k[0] == 1 && add_valid_up1 ==1 && n == 255 )
			begin
				/*xr_temp <= xr1;
				yr_temp <= yr1;
				zr_temp <= zr1;	*/	
				xr <= xr1;
				yr <= yr1;
				zr <= zr1;
			end
		end
end
assign xq1 = xr;
assign yq1 = yr;
assign zq1 = zr;
/* pointadd pointadd_tb2 (
	.clk(clk),
    .rst_n(result),
	.x(xr_temp),
	.y(yr_temp),
	.z(zr_temp),
	.x1(x_temp1),
	.y1(y_temp1),
	.z1(z_temp1),
	.xr(xr2),
	.yr(yr2),
	.zr(zr2),
	.xyz_valid(add_valid1)
  );*/

always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		xr2 <= 256'd0;
		yr2 <= 256'd0;
		zr2 <= 256'd0;
	end
	else
	begin
		if (k[0]==0 && n==255 && add_valid_up1 ==1)
		begin
			xr2 <= xr1;
			yr2 <= yr1;
			zr2 <= zr1;		
		end
		else if (k[0] ==1 && n==256 &&add_valid_up1 ==1)
		begin
			xr2 <= xr1;
			yr2 <= yr1;
			zr2 <= zr1;	
		
		end
	
	
	end

end
assign result_inv = result; //&& result_s;
// assign zr3
mod_inv mod_inv_1 (
	.clk(clk),
    .rst_n(result_inv),
	.c(zr2),
	.c_inv(z2),
	.c_valid(c_1)
  );
wire montgomery_mul_result1;
wire result_1;
wire [255:0]x_common1;
wire [255:0]y_common1;
wire [255:0]z_common1;

wire montgomery_mul_result2;
wire result_2;
wire [255:0]x_common2;
wire [255:0]y_common2;
wire [255:0]z_common2;


montgomery_mul montgomery_mul_1 (
	.clk(clk),
    .rst_n(montgomery_mul_result1),
	.x(x_common1),
	.y(y_common1),
	.result(z_common1),
	.result_valid(result_1)
  );
montgomery_mul montgomery_mul_2 (
	.clk(clk),
    .rst_n(montgomery_mul_result2),
	.x(x_common2),
	.y(y_common2),
	.result(z_common2),
	.result_valid(result_2)
  );
reg [1:0]cnt1;
reg result_1_temp;
wire result_cnt;
wire result_m;
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		result_1_temp<=0;
	end
	else
	begin
		result_1_temp<=result_1;		
	end
end
assign result_cnt=(result_1_temp^result_1)&&result_1;
assign result_m=result_1_temp;
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		cnt1<=0;
	end
	else
	begin
		if (result_cnt==1&&cnt1<4)
			cnt1<=cnt1+1;		
	end
end
reg [255:0]x_common1_temp;
reg [255:0]y_common1_temp;
reg [255:0]z_common1_temp;
reg [255:0]x_common2_temp;
reg [255:0]y_common2_temp;
//reg [255:0]z_common2_temp;
reg [1:0]state1;
reg montgomery_mul_result1_temp;
reg montgomery_mul_result2_temp;
reg[255:0]yy_temp;
reg yy_valid;
always@(posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		x_common1_temp<=256'd0;//1
		y_common1_temp<=256'd0;
		z_common1_temp<=256'd0;
		x_common2_temp<=256'd0;//2
		y_common2_temp<=256'd0;
		//z_common2_temp<=256'd0;
		state1<=2'd0;
		montgomery_mul_result1_temp<=0;
		montgomery_mul_result2_temp<=0;
		yy_temp<=256'd0;
		yy_valid<=0;
	end
	else
	begin
		case(state1)
		2'd0:begin
			if (c_1==1)
			begin
				x_common1_temp<=z2;//1
				y_common1_temp<=z2;
				state1<=2'd1;
				montgomery_mul_result1_temp<=1;								
			end
		end
		2'd1:begin
			if (result_cnt==1)
			begin
				montgomery_mul_result1_temp<=0;
				z_common1_temp<=z_common1;
			end
			if (result_m==1&&cnt1==1)
			begin
				montgomery_mul_result1_temp<=1;
				x_common1_temp<=z_common1_temp;//1
				y_common1_temp<=z2;
				
				montgomery_mul_result2_temp<=1;
				x_common2_temp<=z_common1_temp;//2
				y_common2_temp<=xr2;
				state1<=2'd2;
			end
		end
		2'd2:begin
			if (result_cnt==1)
			begin
				montgomery_mul_result1_temp<=0;
				z_common1_temp<=z_common1;
			end
			if (result_m==1&&cnt1==2)
			begin
				montgomery_mul_result1_temp<=1;
				x_common1_temp<=z_common1_temp;//1
				y_common1_temp<=yr2;
				state1<=2'd3;
			end
		end
		2'd3:begin
			if (result_cnt==1)
			begin
				yy_temp<=z_common1;
				yy_valid<=1;
			end
		end
		endcase
	end
end
assign montgomery_mul_result1=montgomery_mul_result1_temp;
assign montgomery_mul_result2=montgomery_mul_result2_temp;
assign x_common1=x_common1_temp;
assign y_common1=y_common1_temp;
assign x_common2=x_common2_temp;
assign y_common2=y_common2_temp;

assign xx = z_common2;
assign yy = yy_temp;
assign k_valid = yy_valid;
endmodule
