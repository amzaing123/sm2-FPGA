# sm2-FPGA

本项目实现了 SM2 算法在 FPGA 和 MATLAB 上的开发与仿真。
## 目录说明

- **SM2_matlab**：MATLAB 仿真代码，用于验证 SM2 算法的功能与正确性。
- **mod_test**：FPGA 开发程序，包含 SM2 算法在 FPGA 上的实现与测试模块。
## 一、项目内容

- 实现 SM2 数字签名与验签功能
- MATLAB 仿真
- FPGA 部署

## 二、算法说明

### 1. 数字签名生成算法

1. 设待签名的消息为 M，置 M̅ = Z<sub>A</sub> || M
2. 计算 e = H<sub>V</sub>(M̅) 杂凑值
3. 用随机数发生器产生随机数 k ∈ [1, n-1]
4. 计算椭圆曲线点 (x₁, y₁) = [k]G
5. 计算 r = (e + x₁) mod n，若 r = 0 或 r + k = n，返回步骤 3
6. 计算 s = ((1 + d<sub>A</sub>)⁻¹ * (k - r * d<sub>A</sub>)) mod n，若 s = 0 则返回步骤 3
7. 输出消息 M 的签名 (r, s)

### 2. 数字签名验证算法

1. 检查 r′ ∈ [1, n-1]，否则验证失败
2. 检查 s′ ∈ [1, n-1]，否则验证失败
3. 置 M̅′ = Z<sub>A</sub> || M′
4. 计算 e′ = H<sub>V</sub>(M̅′)
5. 计算 t = (r′ + s′) mod n，若 t = 0，验证失败
6. 计算椭圆曲线点 (x₁′, y₁′) = [s′]G + [t]P<sub>A</sub>
7. 计算 R = (e′ + x₁′) mod n，检查 R = r′，成立则通过验证，否则失败

**参数说明：**
- d<sub>A</sub>：私钥
- P<sub>A</sub>：公钥
- 输入：椭圆曲线参数组 (p, E(F<sub>P</sub>), G, n)
- 输出：公钥 P<sub>A</sub> 和私钥 d<sub>A</sub>

> 随机选择 d<sub>A</sub> ∈ [1, n-1]，计算 P<sub>A</sub> = d<sub>A</sub>G，返回 (P<sub>A</sub>, d<sub>A</sub>)

## 三、基本算法

1. **Montgomery 模乘**
2. **点加和倍点**
3. **二进制展开法计算 k 倍点：**

   ```text
   输入：点 P，倍点 k
   输出：Q = kP

   Q ← 0，将 k 从 16 进制转换为 2 进制
   对 j 从 0 到 j-1，重复执行：
     P ← 2P
     若 k_j = 1，Q ← Q + P
   返回 Q
4. **Hash算法**
5. **模逆算法**
## 四、算法参考文章链接

- [Montgomery模乘](https://blog.csdn.net/weixin_46395886/article/details/112988136)
- 点加和倍点：SM2算法快速实现研究
- [Hash算法标准](https://openstd.samr.gov.cn/bzgk/gb/std_list?p.p1=0&p.p90=circulation_date&p.p91=desc&p.p2=sm2)
- 模逆算法：椭圆加密算法研究
## 五、使用说明
1. 进入 `SM2_matlab` 文件夹，可运行 MATLAB 脚本进行 SM2 仿真测试。
2. 进入 `mod_test` 文件夹，获取 FPGA 相关的 Verilog 源码及工程文件。
