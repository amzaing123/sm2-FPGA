function b = mult256(str1,str2)%乘法
% str1 = 'ABDC 5678 AEFC D964 BCDE F612 3697 ADCB 2136 5EFD ADEB 1248 789A DEBC 2964 ABEC';
% str2 = 'ADB1 2365 4EF2 614D 3645 AADC 2379 ADB7 ADBE 52CC AEFB 4539 AD15 BC36 ADE3 67FB';
%
% str1 = 'ABDC5678AEFCD964BCDEF6123697ADCB21365EFDADEB1248789ADEBC2964ABEC';
% str2 = 'ADB123654EF2614D3645AADC2379ADB7ADBE52CCAEFB4539AD15BC36ADE367FB';

% str1 = '7ABD2961B3FBB0E71746DBCA40900821BA8D7C6EA3BAAE828DD12474F70E203D';
% str2 = '7ABD2961B3FBB0E71746DBCA40900821BA8D7C6EA3BAAE828DD12474F70E203D';

% str1 = '8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3';  %%%%%%%%%%% P
% str2 = '710C2CDAAC5BBAD286A0C577156B4DF639CEAF2525510A6B0CBF5D8C3840699D';
% str2 = '53173FE6EE846E57837A1D78D3F722F2C47B9A4363D162F95D5FC7F3AF0888EB';  %%%%%%%%%%% n  计算P'

% str1='7ABD2961B3FBB0E71746DBCA40900822D688DF9CFB7A9D72A518B1183CD18649';
% str2='7ABD2961B3FBB0E71746DBCA40900822D688DF9CFB7A9D72A518B1183CD18649';
% 

% 79AB54211ECAA5B34B2A1D2C914B09675281E3C452A593344EA9B67806734533
% %%%(R-N)

% str1 = '8542D69E4C044F18E8B92435BF6FF7DD297720630485628D5AE74EE7C32E79B7';  %%%%%%%%%%% N
% str2 = '710C2CDAAC5BBAD286A0C577156B4DF935D4FB91B0603BF8FB5421E7425F6B72';  
% '20E365EEC8BE957D1C68F7892719F189B89E29E8BD53BF730DE3063E62F54BF8'


subStr1  = str1( 1:4 );% 提取子字符串
subStr2  = str1( 5:8 );
subStr3  = str1( 9:12);
subStr4  = str1(13:16);
subStr5  = str1(17:20);
subStr6  = str1(21:24);
subStr7  = str1(25:28); 
subStr8  = str1(29:32);
subStr9  = str1(33:36);
subStr10 = str1(37:40);
subStr11 = str1(41:44);
subStr12 = str1(45:48);
subStr13 = str1(49:52);  
subStr14 = str1(53:56);
subStr15 = str1(57:60);
subStr16 = str1(61:64);

subStr17 = str2( 1:4 );% 提取子字符串
subStr18 = str2( 5:8 );
subStr19 = str2( 9:12);
subStr20 = str2(13:16);
subStr21 = str2(17:20);
subStr22 = str2(21:24);
subStr23 = str2(25:28); 
subStr24 = str2(29:32);
subStr25 = str2(33:36);
subStr26 = str2(37:40);
subStr27 = str2(41:44);
subStr28 = str2(45:48);
subStr29 = str2(49:52);  
subStr30 = str2(53:56);
subStr31 = str2(57:60);
subStr32 = str2(61:64);

array1 = hex2dec(subStr1);  %将字符串转换为10进制存储到数组中
array2 = hex2dec(subStr2);
array3 = hex2dec(subStr3);
array4 = hex2dec(subStr4);
array5 = hex2dec(subStr5);
array6 = hex2dec(subStr6);
array7 = hex2dec(subStr7);
array8 = hex2dec(subStr8);
array9 = hex2dec(subStr9);
array10= hex2dec(subStr10);
array11= hex2dec(subStr11);
array12= hex2dec(subStr12);
array13= hex2dec(subStr13);
array14= hex2dec(subStr14);
array15= hex2dec(subStr15);
array16= hex2dec(subStr16);
A =[array1,array2,array3,array4,array5,array6,array7,array8,array9,array10,array11,array12,array13,array14,array15,array16];

array17 = hex2dec(subStr17);   %将字符串转换为10进制存储到数组中
array18 = hex2dec(subStr18);
array19 = hex2dec(subStr19);
array20 = hex2dec(subStr20);
array21 = hex2dec(subStr21);
array22 = hex2dec(subStr22);
array23 = hex2dec(subStr23);
array24 = hex2dec(subStr24);
array25 = hex2dec(subStr25);
array26 = hex2dec(subStr26);
array27 = hex2dec(subStr27);
array28 = hex2dec(subStr28);
array29 = hex2dec(subStr29);
array30 = hex2dec(subStr30);
array31 = hex2dec(subStr31);
array32 = hex2dec(subStr32);
B =[array17,array18,array19,array20,array21,array22,array23,array24,array25,array26,array27,array28,array29,array30,array31,array32];

C=zeros(1,32);

for i=1:16
    for j=1:16
        k=i+j-1;
        data=A(i)*B(j);
        if(data>=2^16)
            C(k+1)=rem(data,2^16)+C(k+1);
            C(k)=((data-rem(data,2^16))/(2^16))+C(k);
        else
            C(k+1)=data+C(k+1);
            C(k)=C(k);
        end
        data=0;
    end
end


for L=1:31 
    if(C(33-L)>=2^16)
        C(32-L)=C(32-L)+((C(33-L)-rem(C(33-L),2^16))/(2^16));
        C(33-L)=rem(C(33-L),2^16);
    else
        C(33-L)=C(33-L);
        C(32-L)=C(32-L);
    end
end


a=dec2hex(C,4);

b=[a(1,:),a(2,:),a(3,:),a(4,:),a(5,:),a(6,:),a(7,:),a(8,:),a(9,:),a(10,:),a(11,:),a(12,:),a(13,:),a(14,:),a(15,:),a(16,:),a(17,:),a(18,:),a(19,:),a(20,:),a(21,:),a(22,:),a(23,:),a(24,:),a(25,:),a(26,:),a(27,:),a(28,:),a(29,:),a(30,:),a(31,:),a(32,:)];






