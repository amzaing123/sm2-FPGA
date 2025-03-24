function b2 = data_reduce(str1,str2)

% str1='C7F03D2CFA8EB3C1CC3E8B70FE14CEA9F0E9F6D93A5927CC791D021EC1A280D1';
% str2='65B369F20445BE420F7E7F951A43F1E61BA401AEFF7D1C47AAFBD68AB07AB07E';

% str1='08CB35B979CCBF4D19BD748CB596893D171F135B379490643789CCB4979E8D4DC';
% str2='8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3';
% str1='1E000000000000000000000000000000000000000000000000000000000000000';
% str2='08000000000000000000000000000000000000000000000000000000000000000';
if(length(str1)==65)&&(str1(1)=='1') 
    str10=data_add(str1(2:65),'0000000000000000000000000000000000000000000000000000000000000001');
    str1='FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF';
else
    str1=str1(length(str1)-63:end);
    str10='000000000000000000000000000000000000000000000000000000000000000000';
end

L=strlength(str1);
L1=L/4;

for i=1:L
    if(str1(i)>str2(i))
        str3=str1;
        str4=str2;
        break
    elseif(str2(i)>str1(i))
        str3=str2;
        str4=str1;
        break
%     else
%         i=i+1;
%     end
    end
end

array1 = zeros(1, L1);  % 存储结果的数组
array2 = zeros(1, L1);  % 存储结果的数组
for i = 1:L1
    subStr3i = str3(4*(i-1)+1:4*i);  % 提取子字符串
    array1(i) = hex2dec(subStr3i);  % 将子字符串转换为十进制数，并存储到数组中

    subStr4i = str4(4*(i-1)+1:4*i);  % 提取子字符串
    array2(i) = hex2dec(subStr4i);  % 将子字符串转换为十进制数，并存储到数组中
end


array3 = zeros(1, L1);
for i=1:L1-1
    if(array1(L1-i+1)>=array2(L1-i+1))
        array1(L1-i)=array1(L1-i);
        array3(L1-i+1)=array1(L1-i+1)-array2(L1-i+1);
    else
        array1(L1-i)=array1(L1-i)-1;
        array3(L1-i+1)=array1(L1-i+1)-array2(L1-i+1)+2^16;    
    end
end

array3(1)=array1(1)-array2(1);
a=dec2hex(array3,4);
b =  reshape(a', 1, []);

b1=data_add(b,str10(2:65));

b2=b1(2:65);








