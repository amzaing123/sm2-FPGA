function result = bit_or(str1, str2)
    if length(str1) ~= 32 || length(str2) ~= 32
        error('Input strings must be 32 bits long.');
    end
    
    result = '';
    for i = 1:32
        if str1(i) == '0' && str2(i) == '0'
            result = strcat(result, '0');
        else
            result = strcat(result, '1');
        end
    end
end