# sm2-FPGA
The SM2 algorithm is implemented using FPGA and matlab
一、项目内容：完成SM2数字签名和验签，在matlab上仿真实验，并在FPGA上面实现。
二、算法：
	1.数字签名的生成算法：
	(1).设待签名的消息为M,置M ̅=Z_A ||M ;
	(2).计算e=H_V (M ̅)杂凑值;
	(3).用随机数发生器计算产生随机数kϵ[1,n-1];
	(4).计算椭圆曲线点(x_1,y_1 )=[k]G；
	(5).计算r=(e+x_1 )modn,如果r=0或r+k=n,返回(3)；
	(6).计算s=((1+d_A )^(-1)*(k-r*d_A ))modn,若s=0则返回(3)；
	(7).输出消息M的签名(r,s)。

	2.数字签名验证算法：
	(1).检验r^' ϵ[1,n-1]是否成立，若不成立则验证不成功；
	(2).检验s^' ϵ[1,n-1]是否成立，若不成立则验证不成功；
	(3).置¯(M^' )=Z_A ||M^';
	(4).计算e^'=H_v (¯(M^' ));
	(5).计算t=(r^'+s^' )modn,若t=0则验证不通过；
	(6).计算椭圆曲线点(x_1^',y_1^' )=[s^' ]G+[t]P_A;
	(7).计算R=(e^'+x_1^')modn,检验R=r^'是否成立，成立则通过验证，否则验证失败。
	d_A为私钥，P_A为公钥。
	输入：椭圆曲线参数组(p,E(F_P),G,n)
	输出：公钥P_A和私钥d_A
		随机选择d_A∈[1,n-1];
		计算P_A=d_A G;
		返回（P_A，d_A）
三、基本算法
	基本算法：
	1. Montgomery模乘：	
	2. 点加和倍点：
	3. 二进制展开法计算k倍点：
	输入：点P，倍点k；
	输出：Q=kp；
		Q←0，将k从16进制转换成二进制；
		对j从0到j-1，重复执行：
		P←2P；
		若k_j=1，Q←Q+P；
		返回Q；
	4.hash算法:
	5.模逆算法：
四、算法参考文章链接
	1、 Montgomery模乘：https://blog.csdn.net/weixin_46395886/article/details/112988136
	2、点加和倍点：SM2算法快速实现研究
	3、hash算法:https://openstd.samr.gov.cn/bzgk/gb/std_list?p.p1=0&p.p90=circulation_date&p.p91=desc&p.p2=sm2
 	4、模逆算法：椭圆加密算法研究
