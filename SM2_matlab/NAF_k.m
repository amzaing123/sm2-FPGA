% clear all;
% k =1122334455;%241 123 13911
% %     将整数k转换为NAF表示
%     i = 1;
%     naf = []; % 初始化NAF数组
%     while k >= 1
%         if mod(k, 2) == 1
%             if mod(k, 4) == 3
%                 naf(i) = -1;
%             else
%                 naf(i) = 1;
%             end
%             k = k - naf(i);
%         else
%             naf(i) = 0;
%         end
%         k = floor(k / 2); % 右移一位
%         i = i + 1;
%     end
%     naf = fliplr(naf); % 反转数组以匹配从最高有效位到最低有效位的顺序




clear all;
str1='6CB28D99385C175C94F94E934817663FC176D925DD72B727260DBAAE1FB2F96F';
array3 = [];
% array3 =cell(1,1);
% array4 = {};
% array4 =zeros(1;256);
array1 = zeros(1, 4);  % 存储结果的数组
array2 = zeros(1, 4);
L=strlength(str1);
for i = 1:L
    subStr1i = str1(i);  % 提取子字符串
    array1 = hex2dec(subStr1i);  % 将子字符串转换为十进制数，并存储到数组中
    array2 =dec2bin(array1,4);
    array3 =[array3,array2];
end
for i = 1:256
    k_bit(i) = bin2dec(array3(i));
    
end

    % k_bin: 256位二进制数的字符串表示，例如 '1101...'
   sum1=0;
   sum2=0;
%     v_test =100;
%     for i=1:v_test
%      k_bit = randi(2,1,256)-1;
   k=0;

%     com =sum (k_bit)
    for i=1:256
        k = k +k_bit(i)*2^(256-i); % 将二进制字符串转换为十进制数
        % dec = dec + bit * 2^(binLen - i);
    end
%     k=123;
%     naf =[];
    naf = zeros(1, 257); % 初始化NAF数组，长度为257位
    i = 1;
    while k > 0
        if mod(k, 2) == 1
            remainder = mod(k, 4);
            if remainder == 3
                naf(i) = -1;
            else
                naf(i) = 1;
            end
            k = k - naf(i);
        else
            naf(i) = 0;
        end
        k = floor(k / 2); % 右移一位
        i = i + 1;
    end
    naf = fliplr(naf); % 反转数组以匹配从最高有效位到最低有效位的顺序
    com1=0;
    com2 =0;

   for i= 1:257
       
       if (naf(i) ==1)
        com1 = com1+1;
       end
        if (naf(i)==-1)
        com2 =com2+1;
       
        end
        
   end

%    sum1 =sum1 +com1
%    sum2 =sum2 +com2
   
%     end
% v1= sum1/100
% v2 = sum2/100



%%1001001101001101011100100110011011000111101000111110100010100011011010110000011010110001011011001011011111101000100110011100000000111110100010010010011011011010001000101000110101001000110110001101100111110010010001010101000111100000010011010000011010010000