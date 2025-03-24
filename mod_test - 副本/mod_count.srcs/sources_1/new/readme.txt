k_point最慢版本，模块为256*256乘法器
倍点复位中 时间需根据具体点加时间进行调整。
//倍点复位
always@ (posedge clk or negedge rst_n)
begin
	if (~rst_n)
	begin
		double_rst <= 0;
		cnt_double <= 0;
		result_temp <=0;
	end
	else if (cnt_double < 1000)
	begin
		cnt_double =cnt_double +1;
		double_rst <=0;
	end
	//999-45399最慢
	else if (999 <cnt_double && cnt_double <45399)//45399 15499 1549
	begin
		double_rst <= 1;
		cnt_double <= cnt_double +1;
		//1000-2000最慢
		if (1000<cnt_double && cnt_double<2000)//1000-2000
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
	else if  (cnt_double ==45399)
	begin
			cnt_double <=0;
			double_rst <=0;
	end

end