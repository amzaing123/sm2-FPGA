% clear all;
% str1='6CB28D99385C175C94F94E934817663FC176D925DD72B727260DBAAE1FB2F96F';
% % 0110110010110010100011011001100100111000010111000001011101011100100101001111100101001110100100110100100000010111011001100011111111000001011101101101100100100101110111010111001010110111001001110010011000001101101110101010111000011111101100101111100101101111
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
% 
% for i = 1:256
%     k_bit(i) = bin2dec(array3(i));
% end
clear all;
v_test = 10000;
cnt1_sqr =0;
cnt2_sqr =0;
cnt3_sqr =0;
cnt4_sqr =0;
cnt5_sqr =0;
cnt6_sqr =0;
cnt7_sqr =0;
cnt8_sqr =0;
cnt9_sqr =0;
cnt10_sqr =0;
cnt11_sqr =0;
cnt12_sqr =0;
cnt13_sqr =0;
num_sqr =0
for n_test = 1:v_test;
    cnt1  = 0;
    cnt2  = 0;
    cnt3  = 0;
    cnt4  = 0;
    cnt5  = 0;
    cnt6  = 0;
    cnt7  = 0;
    cnt8  = 0;
    cnt9  = 0;
    cnt10  = 0;
    cnt11  = 0;
    cnt12  = 0;
    cnt13  = 0;
    k_bit = randi(2,1,192)-1;

    k_bit = [k_bit 0];
    next_st = 0;
    pres_st = 0;
    for i = 1:length(k_bit)
        pres_st = next_st;

        switch pres_st
            case(0)
                if(k_bit(i)==1)
                    next_st = 1;
                else
                    next_st = 0;
                end
            case(1)
                if(k_bit(i)==1)
                    next_st = 2;
                else
                    next_st = 0;
                    cnt1 = cnt1 + 1;

                end
            case(2)
                if(k_bit(i)==1)
                    next_st = 3;
                else
                    next_st = 0;
                    cnt2 = cnt2 + 1;

                end
            case(3)
                if(k_bit(i)==1)
                    next_st = 4;
                else
                    next_st = 0;
                    cnt3 = cnt3 + 1;
                end
            case(4)
                if(k_bit(i)==1)
                    next_st = 5;
                else
                    next_st = 0;
                    cnt4 = cnt4 + 1;
                end
            case(5)
                if(k_bit(i)==1)
                    next_st = 6;
                else
                    next_st = 0;
                    cnt5 = cnt5 + 1;
                end
            case(6)
                if(k_bit(i)==1)
                    next_st = 7;
                else
                    next_st = 0;
                    cnt6 = cnt6 + 1;
                end
            case(7)
                if(k_bit(i)==1)
                    next_st = 8;
                else
                    next_st = 0;
                    cnt7 = cnt7 + 1;
                end
            case(8)
                if(k_bit(i)==1)
                    next_st = 9;
                else
                    next_st = 0;
                    cnt8 = cnt8 + 1;
                end
            case(9)
                if(k_bit(i)==1)
                    next_st = 10;
                else
                    next_st = 0;
                    cnt9 = cnt9 + 1;
                end
            case(10)
                if(k_bit(i)==1)
                    next_st = 11;
                else
                    next_st = 0;
                    cnt10 = cnt10 + 1;
                end
            case(11)
                if(k_bit(i)==1)
                    next_st = 12;
                else
                    next_st = 0;
                    cnt11 = cnt11 + 1;
                end
            case(12)
                if(k_bit(i)==1)
                    next_st = 13;
                else
                    next_st = 0;
                    cnt12 = cnt12 + 1;
                end
            case(13)
                if(k_bit(i)==1)
                    next_st = 13;
                else
                    next_st = 0;
                    cnt13 = cnt13 + 1;
                end                
        end

    end
    cnt = [cnt1
        cnt2
        cnt3
        cnt4
        cnt5
        cnt6
        cnt7
        cnt8
        cnt9
        cnt10
        cnt11
        cnt12
        cnt13];
cnt1_sqr =cnt1_sqr+cnt1;
cnt2_sqr =cnt2_sqr+cnt2;
cnt3_sqr =cnt3_sqr+cnt3;
cnt4_sqr =cnt4_sqr+cnt4;
cnt5_sqr =cnt5_sqr+cnt5;
cnt6_sqr =cnt6_sqr+cnt6;
cnt7_sqr =cnt7_sqr+cnt7;
cnt8_sqr =cnt8_sqr+cnt8;
cnt9_sqr =cnt9_sqr+cnt9;
cnt10_sqr =cnt10_sqr+cnt10;
cnt11_sqr =cnt11_sqr+cnt11;
cnt12_sqr =cnt12_sqr+cnt12;
cnt13_sqr =cnt13_sqr+cnt13;
cnt_sqr =[cnt1_sqr
cnt2_sqr 
cnt3_sqr 
cnt4_sqr 
cnt5_sqr 
cnt6_sqr 
cnt7_sqr 
cnt8_sqr 
cnt9_sqr 
cnt10_sqr 
cnt11_sqr 
cnt12_sqr
cnt13_sqr ];
    num_1 = 0;
    for i = 1:length(cnt)
        num_1 = num_1+i*cnt(i);
    end
num_sqr =num_sqr +num_1;
    if(num_1==sum(k_bit))
        flag_successful = 1;
        com  = sum(k_bit);
        com1 = sum(cnt)*2;
        com2 = cnt(1)+ sum(cnt(2:end))*2;
    else
        cnt
    end
    com_sav(n_test) = com2/com;

end
[m_val,m_index] = max(1-(com_sav))
cnt
cnt_sqr
num_sqr