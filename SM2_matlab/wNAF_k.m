% clear all;
% % str1='6CB28D99385C175C94F94E934817663FC176D925DD72B727260DBAAE1FB2F96F';
% % str1='6FC6DAC32C5D5CF10C77DFB20F7C2EB667A457872FB09EC56327A67EC7DEEBE7';
% % str1='0000000000000000000000000000000000000000000000000000000042e576f7';
% array3 = [];
% % array3 =cell(1,1);
% % array4 = {};
% % array4 =zeros(1;256);
% array1 = zeros(1, 4);  % 存储结果的数组
% array2 = zeros(1, 4);
% L=strlength(str1);
% for i = 1:L
%     subStr1i = str1(i);  % 提取子字符串
%     array1 = hex2dec(subStr1i);  % 将子字符串转换为十进制数，并存储到数组中
%     array2 =dec2bin(array1,4);
%     array3 =[array3,array2];
% end
% % for i = 1:256
% %     k_bit(i) = bin2dec(array3(i));
% %     k_bit
% % end
% k_bit = array3;
% % clear all;
% %     v_test =100;
%     sum1 =0;
%     sum2 =0;
% %     for i=1:1%v_test
% %      k_bit = randi(2,1,256)-1;
% 
% 
% %  for i=1:255
% %         k = k +k_bit(i)*2^(256-i); % 将二进制字符串转换为十进制数
% %         % dec = dec + bit * 2^(binLen - i);
% %  end
%  k=k_bit;
clear all;
 k=1122334455;
    % k: 输入的标量
    % w: 窗口大小
    % wNAF: 输出的wNAF表示数组
    w=6;
%     window_mask = 2^w - 1;
    wNAF = [];
    i = 1;    
   window =[];
%     window_mask = 2^w - 1;
%    window= zeros(1,256);
    while k > 0
        if (mod(k, 2) == 1)
            window = mod(k, 2^w);
            if window >= 2^(w-1)
                window = window - 2^w;
            end
            k = k - window;
        else
            window = 0;
        end
       
       
        wNAF(i) = window;
        k = floor(k / 2);
        i = i + 1;
    end
    wNAF = fliplr(wNAF); % 反转数组以匹配从最高有效位到最低有效位的顺序
%     wNAF =cell(1,256);
%     L=strlength(wNAF);
    com1 =0;
    com2 =0;
%  for i= 1:256
%        
%        if (wNAF(i) ==1)
%         com1 = com1+1;
%        end
%         if (wNAF(i)==-1)
%         com2 =com2+1;
%        
%         end
%         
%    end
  
   
for i= 1:length(wNAF)
       
       if (wNAF(i) >0)
        com1 = com1+1;
       end
        if (wNAF(i)<0)
        com2 =com2+1;
       
        end
        
end
n=length(wNAF)
m=(com1+com2)/n
% sum1= sum1 +com1;
% sum2 = sum2 +com2;
%  end