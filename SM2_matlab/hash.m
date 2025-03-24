% F4A38489 E32B45B6 F876E3AC 2168CA39 2362DC8F 23459C1D 1146FC3D BFB7BC9A 6D657373 61676520 64696765 7374
function result = hash(M)
% M='F4A38489E32B45B6F876E3AC2168CA392362DC8F23459C1D1146FC3DBFB7BC9A6D65737361676520646967657374' ; %M'=ZA||M
% M='26352AF82EC19F207BBC6F9474E11E90CE0F7DDACE03B27F801817E897A81FD56D65737361676520646967657374';
 % M='616263';

L=strlength(M);
L1=rem(L,8);
L2=(L-L1)/8;

% L3 = L2 / 8;  % 子字符串数量
array = zeros(1, L2);  % 存储结果的数组
bit = cell(1,L2);    %存储二进制数组

for i = 1:L2
    subStri = M(8*(i-1)+1:8*i);  % 提取子字符串
    array(i) = hex2dec(subStri);  % 将子字符串转换为十进制数，并存储到数组中
   bit{i} = dec2bin(array(i),32);
end
result = strjoin(bit, '');  % 将二进制字符串连接起来形成一个长的二进制字符串


subStrLast = M(L-L1+1:L);      %将M末尾数据处理"7374"
arrayLast = hex2dec(subStrLast);
arrayLast1 = arrayLast*2^(32-4*L1)+2^(32-4*L1-1);
bitend =dec2bin(arrayLast1,32);

bitdata = [result,bitend];    %整个数据
resultdata = [bitdata,repmat('0',1,448-strlength(bitdata))];%%%%数据后补0合成（512-64=448）位

bitnum =dec2bin(4*L,64); %计算M有多少比特，输出64位的比特数

dataM=[resultdata,bitnum];   %消息拼接以后整个512比特数据
% strlength(dataM);

W = cell(1,132);

W{1}=dataM(  1:32 );
W{2}=dataM( 33:64 );
W{3}=dataM( 65:96 );
W{4}=dataM( 97:128);
W{5}=dataM(129:160);
W{6}=dataM(161:192);
W{7}=dataM(193:224);
W{8}=dataM(225:256);
W{9}=dataM(257:288);
W{10}=dataM(289:320);
W{11}=dataM(321:352);
W{12}=dataM(353:384);
W{13}=dataM(385:416);
W{14}=dataM(417:448);
W{15}=dataM(449:480);
W{16}=dataM(481:512);

for j =17:68                                %%%%%%消息扩展
    x=bit_xor(W{j-16}, W{j-9});
    y=shiftleft(W{j-3},15);
    h=bit_xor(x,y);
    m=P1(h);
    z=shiftleft(W{j-13},7);
    n=bit_xor(m,z);
    W{j}=bit_xor(n,W{j-6});
end

W1=cell(1,64);
for j=1:64                                 %%%%%消息扩展 
    W1{j}=bit_xor(W{j},W{j+4});
end



%%%%%%%压缩函数

A='01110011100000000001011001101111';      %%%%%%%  7380166F
B='01001001000101001011001010111001';      %%%%%%%  4914B2B9
C='00010111001001000100001011010111';      %%%%%%%  172442D7
D='11011010100010100000011000000000';      %%%%%%%  DA8A0600
E='10101001011011110011000010111100';      %%%%%%%  A96F30BC
F='00010110001100010011100010101010';      %%%%%%%  163138AA
G='11100011100011011110111001001101';      %%%%%%%  E38DEE4D
H='10110000111110110000111001001110';      %%%%%%%  B0FB0E4E




for j=1:64
% for j=1:17
    if j >= 1 && j <= 16
        T='01111001110011000100010100011001';   %%%%   79cc4519
    else
        T='01111010100001111001110110001010';   %%%%   7a879d8a
    end

    X=bit_Add(shiftleft(A,12),E);
    Y=shiftleft(T,rem(j-1,32));
    q =bit_Add(X,Y);
    SS1=shiftleft(q,7);
    SS2=bit_xor(SS1,shiftleft(A,12));

    t=FF(A,B,C,j);
    t1=bit_Add(t,D);
    t2=bit_Add(SS2,W1{j});
    TT1=bit_Add(t1,t2);
    t1 =GG(E,F,G,j);
    t3=bit_Add(t1,H);
    t4=bit_Add(SS1,W{j});
    TT2=bit_Add(t3,t4);

    D=C;
    C=shiftleft(B,9);
    B=A;
    A=TT1;
    H=G;
    G=shiftleft(F,19);
    F=E;
    E=P0(TT2);

end    

hash1=bit_xor(A,'01110011100000000001011001101111');
hash2=bit_xor(B,'01001001000101001011001010111001');
hash3=bit_xor(C,'00010111001001000100001011010111');
hash4=bit_xor(D,'11011010100010100000011000000000');
hash5=bit_xor(E,'10101001011011110011000010111100');
hash6=bit_xor(F,'00010110001100010011100010101010');
hash7=bit_xor(G,'11100011100011011110111001001101');
hash8=bit_xor(H,'10110000111110110000111001001110');

% 将二进制字符串转换为对应的十进制数
hash1_dec = bin2dec(hash1);
hash2_dec = bin2dec(hash2);
hash3_dec = bin2dec(hash3);
hash4_dec = bin2dec(hash4);
hash5_dec = bin2dec(hash5);
hash6_dec = bin2dec(hash6);
hash7_dec = bin2dec(hash7);
hash8_dec = bin2dec(hash8);
    
% 将十进制数转换为十六进制字符串
hash1_hex = dec2hex(hash1_dec,8);
hash2_hex = dec2hex(hash2_dec,8);
hash3_hex = dec2hex(hash3_dec,8);
hash4_hex = dec2hex(hash4_dec,8);
hash5_hex = dec2hex(hash5_dec,8);
hash6_hex = dec2hex(hash6_dec,8);
hash7_hex = dec2hex(hash7_dec,8);
hash8_hex = dec2hex(hash8_dec,8);


result=[hash1_hex,hash2_hex,hash3_hex,hash4_hex,hash5_hex,hash6_hex,hash7_hex,hash8_hex];
































































