clear all;
str1='6CB28D99385C175C94F94E934817663FC176D925DD72B727260DBAAE1FB2F96F';
array3 = {};
% array3 =cell(1,1);
% array4 = {};
array3 =zeros(1,256);
array1 = zeros(1, 1);  % 存储结果的数组
array2 = zeros(1, 1);
L=strlength(str1);
for i = 1:L
    subStr1i = str1(i);  % 提取子字符串
    array1 = hex2dec(subStr1i);  % 将子字符串转换为十进制数，并存储到数组中
    array2 =dec2bin(array1,4);
%     array3 =[array3,array2];
    array3(i)= array2;
end
% array4 =reshape(array3,1,256);
% for i= 1:L
%     if array3(i) == '1'
%         m =m+1;
%     end
% end