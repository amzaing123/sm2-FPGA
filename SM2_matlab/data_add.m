function b = data_add(str1,str2)%字符相加

% str1='79AB54211ECAA5B34B2A1D2C914B09675281E3C452A593344EA9B67806734533';
% str2='8542D69E4C044F18E8B92435BF6FF7DD297720630485628D5AE74EE7C32E79B7';

% str1='00000000000000000000000000000000000000000000000000000000000000008542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3';
% str2='00000000000000000000000000000000000000000000000000000000000000007ABD2961B3FBB0E71746DBCA40900821BA8D7C6EA3BAAE828DD12474F70E203D';
% str1='8454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';%64
% str2='8659ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';

L=strlength(str1);
L1=L/4;
array1 = zeros(1, L1);  % 存储结果的数组
array2 = zeros(1, L1);  % 存储结果的数组
for i = 1:L1
    subStr1i = str1(4*(i-1)+1:4*i);  % 提取子字符串
    array1(i) = hex2dec(subStr1i);  % 将子字符串转换为十进制数，并存储到数组中

    subStr2i = str2(4*(i-1)+1:4*i);  % 提取子字符串
    array2(i) = hex2dec(subStr2i);  % 将子字符串转换为十进制数，并存储到数组中
end

array3 = zeros(1, L1);
for i=1:L1
    array3(i)=array2(i)+array1(i);
end

for i=1:L1-1
    if(array3(L1-i+1)>=2^16)
        array3(L1-i)=array3(L1-i)+1;
        array3(L1-i+1)=array3(L1-i+1)-2^16;
    else
        array3(L1-i)=array3(L1-i);
        array3(L1-i+1)=array3(L1-i+1);
    end
end

if (array3(1)>=65535)
    array3(1)=array3(1)-65536;
    bot=1;
else
    bot=0;
end

a=dec2hex(array3,4);
b1 =  reshape(a', 1, []);
switch bot
    case 1 
       b = ['1',b1];
    case 0
       b = ['0',b1];
end








