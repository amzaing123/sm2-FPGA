function result = GG(bit1, bit2, bit3, j)

% j=17;
% 
% bit1='10101101010000001010101010101010';
% bit2='10111010101010101101001011101011';
% bit3='11010110011101111111101000111100';
    result = '';
    
    if j >= 1 && j <= 16
        bit1_dec = bin2dec(bit1);
        bit2_dec = bin2dec(bit2);
        bit3_dec = bin2dec(bit3);
        
        result = dec2bin(bitxor(bit1_dec, bitxor(bit2_dec, bit3_dec)), 32);
    else
        
        x=bit_and(bit1,bit2);
        

        y='';
        for i = 1:32
        if bit1(i) == '0'
            y = strcat(y, '1');
        else
            y = strcat(y, '0');
        end
        end

        result=bit_or(x,bit_and(y,bit3));

    end

end

% result
