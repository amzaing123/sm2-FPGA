% function [XX,YY]= k_point(k,x,y)

tic;
% k='6CB28D99385C175C94F94E934817663FC176D925DD72B727260DBAAE1FB2F96F';%原始K
% k='00000000755DB064E4ED4EBBA49B6E83FC66E812C9729F293AE83A1C99B10000';
k='F69F4DF8755DB064E4ED4EBBA49B6E83FC66E812C9729F293AE83A1C99B14D36';%倒转K
% k='6FC6DAC32C5D5CF10C77DFB20F7C2EB667A457872FB09EC56327A67EC7DEEBE7';
% k='FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF';
% k='0000000000000000000000000000000000000000000000000000000000000000';
% k ='6FC6DAC32C5D5CF10C77DFB20F7C2EB667A457872FB09EC56327A67EC7DEEBE7';%s
% k='E7D77BE37E65E4C6A3790DF4E1EA25E66D743EF04DFBEE308F3ABA34C35B63F6';%翻转s
% t='2B75F07E D7ECE7CC C1C8986B 991F441A D324D6D6 19FE06DD 63ED32E0 C997C801;%t
% k='8013E993074CB7C6BB607F986B6B24CB5822F899D619138333E737EB7E0FAED4';%t翻转
% 421DEBD61B62EAB6746434EBC3CC315E32220B3BADD50BDC4C4E6C147FEDD43D0680512BCBB42C07D47349D2153B70C4E5D7FDFCBFA36EA1A85841B9E46E09A2
x='421DEBD61B62EAB6746434EBC3CC315E32220B3BADD50BDC4C4E6C147FEDD43D';
y='0680512BCBB42C07D47349D2153B70C4E5D7FDFCBFA36EA1A85841B9E46E09A2';
% x ='0AE4C7798AA0F119471BEE11825BE46202BB79E2A5844495E97C04FF4DF2548A';%xa
% y ='7C0240F88F1CD4E16352A73C17B7F16F07353E53A176D684A9FE0C6BB798E857';%ya
z='0000000000000000000000000000000000000000000000000000000000000001';
% k='4C62EEFD6ECFC2B95B92FD6C3D9575148AFA17425546D49018E5388D49DD7B4F';
% x='435B39CCA8F3B508C1488AFC67BE491A0F7BA07E581A0E4849A5CF70628A7E0A';
% y='75DDBA78F15FEECB4C7895E2C1CDF5FE01DEBB2CDBADF45399CCF77BBA076A42';
% X1='2b7bc705bdbf1d8bb390825fee2447f4552b88a1b8b87b38078f4eca97f72645';
% Y1='6fceb4a6cd27d4cf4b5f8c81fcc85639035632c36d9f28e63411f3be9bd03186';
% Z1='479f6e107bd4fad05efe228d14388617a54ecb83e752236a8edf779b5f958636';


% X1='0CEDE21DF2CFA2A028C6C3F32A36B6B9D59AB7FC6FD2F37B8D0A53230591DEF9';
% Y1='5F703512FDA3B29A5627EDF61C00F77FD3E8A96EF913C620AA68ED708FF0A257';
% Z1='0132D8D43682BBB8EF1245C2619952E717E4C027EB2D723B8BE8010DE5FD03B0';

L=strlength(k);
L3 = L / 8;  % 子字符串数量
array = zeros(1, L/8);  % 存储结果的数组
bit = cell(1,L/8);    %存储二进制数组

for i = 1:L/8
    subStri = k(8*(i-1)+1:8*i);  % 提取子字符串
    array(i) = hex2dec(subStri);  % 将子字符串转换为十进制数，并存储到数组中
   bit{i} = dec2bin(array(i),32);
end
k1 = strjoin(bit, '');  % 将二进制字符串连接起来形成一个长的二进制字符串
% k1='0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011011';
% 创建一个空矩阵用于存储结果字符串
array=cell(256, 1);
% % % % % k正着算
% for i=1:k_L-1
%     x1=x;
%     y1=y;
%     z1=z;
%      if k1(i)=='1'
%         for l = 1:(256-i)
%             [X,Y,Z] = pointdouble(x1,y1,z1);
%             x1=X;
%             y1=Y;
%             z1=Z;
%         end
%         array{i} = [X,Y,Z];
%     else
%         array{i} = '0';
%     end
% end
k_L=length(k1);
for i=2:k_L
    x1=x;
    y1=y;
    z1=z;
     if k1(i)=='1'
        for l = 1:(i-1)%%(256-i)
        % for l = 1:(256-i)
            [X,Y,Z] = pointdouble(x1,y1,z1);
            x1=X;
            y1=Y;
            z1=Z;
        end
        array{i} = [X,Y,Z];
    else
        array{i} = '0';
    end
end

if k1(1)=='1'
    array{1}=[x,y,z];
else
    array{1}='0';
end

% 要除去的元素 val
val = '0';

% 创建一个空的单元格数组用于存储保留的元素
array_new = {};
array_new_add={};

% 迭代遍历 array，仅保留不等于 val 的元素
for i = 1:256
    if ~isequal(array{i}, val)
        array_new = [array_new; array{i}];
    end
end

m=size(array_new,1);       %求矩阵array_new的行数

X1=array_new{1}(1:64);
Y1=array_new{1}(65:128);
Z1=array_new{1}(129:192);

for n=1:m-1
%     if(n ==255)
%         temp_1=  X1;
%         temp_2=  Y1;
%         temp_3=  Z1;
%         temp_a = array_new{n+1}(1:64);
%         temp_b = array_new{n+1}(65:128);
%         temp_c = array_new{n+1}(129:192);
%         end
    
[X10,Y10,Z10] = pointadd(X1,Y1,Z1,array_new{n+1}(1:64),array_new{n+1}(65:128),array_new{n+1}(129:192));
%      [X10,Y10,Z10] = pointadd(X1,Y1,Z1,array_new{m-n}(1:64),array_new{m-n}(65:128),array_new{m-n}(129:192));
    array_new_add{i}(1:64) =X10;
    array_new_add{i}(65:128)=Y10;
    array_new_add{i}(129:192)=Z10;
    X1=X10;
    Y1=Y10;
    Z1=Z10;
   
end
% X1=array_new{m}(1:64);
% Y1=array_new{m}(65:128);
% Z1=array_new{m}(129:192);
% 
% for n=1:m-1
%     if(n ==2)
%         temp_a=  X1;
%         temp_b = array_new{m-n}(1:64);
%         end
%     [X10,Y10,Z10] = pointadd(X1,Y1,Z1,array_new{m-n}(1:64),array_new{m-n}(65:128),array_new{m-n}(129:192));
%     X1=X10;
%     Y1=Y10;
%     Z1=Z10;
% end

Z2=mod_inv(Z1,1);

Z3=montgomery_mul(Z2,Z2);
Z4=montgomery_mul(Z3,Z2);

XX=montgomery_mul(X1,Z3);
YY=montgomery_mul(Y1,Z4);
elapsed_time = toc;
disp(['程序运行时间为：', num2str(elapsed_time), ' 秒']);

















