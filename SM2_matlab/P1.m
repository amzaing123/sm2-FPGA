function result = P1(str)
% str = '10101010101010101010101010101010';  % 32位比特串
shift1 = 15;  % 左移的位数
shift2 = 23;
% 对比特串进行循环左移
result1 = [str(shift1+1:end) str(1:shift1)];
result2 = [str(shift2+1:end) str(1:shift2)];

result3 =bit_xor(str,result1);

result = bit_xor(result3,result2);