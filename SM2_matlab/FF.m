% j=17;
% 
% bit1='10101101010000001010101010101010';
% bit2='10111010101010101101001011101011';
% bit3='11010110011101111111101000111100';

function result = FF(bit1, bit2,bit3,j)

result='';
                                                        
if j>=1 && j<=16
    result=bit_xor(bit1,bit_xor(bit2,bit3));    %%%%%%% 1100 0001 1001 1101 1000 0010 0111 1101
else
    result=bit_or(bit_or(bit_and(bit1,bit2),bit_and(bit1,bit3)),bit_and(bit2,bit3)); %%%%%%% 1011 1110 0110 0010 1111 1010 1010 1011
end


% result