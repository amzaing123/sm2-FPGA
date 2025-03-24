% % % % %  mod_reduce  模减 

function M= mod_reduce_N(m,n)

% n='2454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';
% m='3159ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';
% n='0454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';
% m='9159ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';
P='8542D69E4C044F18E8B92435BF6FF7DD297720630485628D5AE74EE7C32E79B7';


L=strlength(m);
for i=1:L
    if(m(i)>n(i))
        z=data_reduce(m,n);
        if(z(i) >P(i))
            M = data_reduce(z,P);
         break
        
        elseif (z(i) <P(i))
            M = z;
          break
        end
%      break           
    elseif(m(i)<n(i))
        z1=data_add(m,P);
        M=data_reduce(z1,n);
        break
    end
end


if(m(i)==n(i))
    M='0000000000000000000000000000000000000000000000000000000000000000';
end

% z2=data_add(z1,P);