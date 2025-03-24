function result1 = bit_Add(bit1, bit2)     %%%%%加取模2^32
% bit1 = '00101101101100001110011000000001';
% bit2 = '11011010100010100000011000000000';
result = '';

% 将比特串转换为数值向量
bit1_vec = dec2bin(bin2dec(bit1), length(bit1)) - '0';
bit2_vec = dec2bin(bin2dec(bit2), length(bit2)) - '0';

carry = 0;  % 初始进位为 0

% 从右向左逐位进行加法运算
for i = length(bit1):-1:1
    % 当前位的加法结果为 bit1(i) XOR bit2(i) XOR carry
    bit_sum = xor(xor(bit1_vec(i), bit2_vec(i)), carry);
    
    % 更新进位值
    carry = (bit1_vec(i) & bit2_vec(i)) | (bit1_vec(i) & carry) | (bit2_vec(i) & carry);
    
    % 将加法结果插入到结果字符串的最前面
    result = [char(bit_sum + '0') result];
end

% 添加最终的进位
result = [char(carry + '0') result];

result1 = result(2:end);
