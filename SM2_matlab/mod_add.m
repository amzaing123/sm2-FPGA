% % % % %  mod_add  模加 

function z1 = mod_add(x,y)

% x='8454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';
% y='8659ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';

% P='8542D69E4C044F18E8B92435BF6FF7DD297720630485628D5AE74EE7C32E79B7';%N
P='8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3';

z=data_add(x,y);

P1=['0',P];
L=strlength(z);
for i=1:L
    if(z(i)>P1(i))
        z1=data_reduce(z,P);
        break
    elseif(z(i)<P1(i))
        z3=z;
        z1=z3(2:end);
        break
    end
end


% z2=data_add(z1,P);