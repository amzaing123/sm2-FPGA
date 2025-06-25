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
	(1)montgomery形式：通过一次Montgomery reduce计算a^'=aR(modN)
		aR(modN)=aR^2*R^(-1) (modN)=montgomery reduce(a〖，R〗^2 (modN)，N)
		R^2 (modN)是预计算，确定好模数后该值不变，可以提前算出。
	(2)Montgomery约减：例 计算ab(modN)
		a^'=aR(modN)  b^'=bR(modN)   x=a^' b^'   
		调用两次Montgomery约减：x_1=montgomery reduce(x,R,N)=X/R=abR(modN)
		                        X=montgomery reduce(x_1,R,N)=X_1/R=ab(modN)
	(3)y=montgomery reduce(x,R,N)  x=a^' b^' R=2^256 N为模数 输出为y
		计算N^'=-N^(-1) (modR), m=xN^' (modR)	模R等于将数转换成16进制移位64
		计算y=(x+mN)/R, 若y>N, 则y=y-N, 否则返回y。
2. 点加和倍点：
(1).在素数域上椭圆曲线E，规定点p=(x_p,y_p )与点Q=(x_q,y_q )的加法计算为：
{█(x_r=μ^2-x_p-x_q@   y_r=μ-(x_p-x_r )-y_p )┤
其中：
μ={█((y_q-y_p)/(x_q-x_p )                  x_p≠x_q@   (3x_p^2+a)/(2y_p )                   x_p= x_q      )┤
		
		(2).椭圆曲线在Jacobi坐标上的表示：
	P(x_1,y_1,z_1)     Q(x_2,y_2,z_2)
           点加：
	 A=x_1 z_2^2  B=x_2 z_1^2   C=A-B  D=y_1 z_2^3  E=y_2 z_1^3         F=D-E            G=A+B      H=D+E           I=GC^2-2x_r
	x_r=F^2-GC^2      y_r=((FI-HC^3))⁄2       z_r=z_1 z_2 C   
           倍点：
	A=3x^2+az^4   B=4xy^2    C=8y^4
	x_r=A^2-2B    y_r=A(B-x_r )-C   Z_r=2yz

         (3).倍点和点加完后将Jacibo坐标系转换成素数域：
	X=x_r/(z_r^2 )      Y=y_r/(z_r^3 )

3. 二进制展开法计算k倍点：
输入：点P，倍点k；
输出：Q=kp；
	Q←0，将k从16进制转换成二进制；
	对j从0到j-1，重复执行：
	P←2P；
2.2 若k_j=1，Q←Q+P；
	返回Q；
  4.verilog在vivado实现基本语句
迭代过程：
	将填充的消息m^'按512位进行分组：m^'=B^((0))…. B^((n-1))，其中 n=(l +k+65)/512。
对 i从0到n-1：
V^((i+1))=CF(V^((i)),B^((i)))，
CF为压缩函数，V^((0))是256比特初始值IV。
	  5.消息扩展：
		对 i从16到67：
			W_i =P_1(W_(i-16)  ^ W_(i-9) ^ (W_(i-3)) <<<15) ^ (W_(i-13) <<<7) ^(W_(i-6))
		对 i从0到63：
			W_i^' = W_i ^ W_(i+4)
	  6.函数压缩：
		对 i从0到63：
			SS1 = ((A<<<12) +E +(T_i<<<(imod32))) <<<7
			SS2 = SS1 ^ (A <<<12)
			TT1 =〖FF〗_i(A, B, C) +D +SS2+W_i^'
			TT2 =〖GG〗_i(A, B, C) +H +SS1 +W_i
			D = C
			C = B <<<9
			B = A
			A = TT1
			H = G
			G = F <<<19
			F = E
			E = P_0 (TT2)
	  7. V^((i+1)) = ABCDEFGH ^ V^((i)),
		ABCDEFGH = V^((n))
		然后输出杂凑值 y = ABCDEFGH。
	 8.模逆算法：
输入：p和a∈[1，p-1].
输出：a^(-1)mod p.
	u ← a, v ← p.
	x_1 ← 1, x_2 ← 0.
	当u≠1时，重复执行
	q ← [v/u], r ← v – q*u, x ←x_2 – q*x_1.
	v ← u , u ← r, x_2← x_1, x_1 ← x.
	返回（x_1  mod p）
四、算法参考文章链接
1、
