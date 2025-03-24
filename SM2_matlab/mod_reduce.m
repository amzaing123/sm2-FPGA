% % % %  mod_reduce  模减 

% function M= mod_reduce(m,n)
% 
% n='2454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';
% m='3159ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';
% n='1000000000000000000000000000000000000000000000000000000000000000';
% m='f000000000000000000000000000000000000000000000000000000000000000';
% P='8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3';
% P='8000000000000000000000000000000000000000000000000000000000000000';
% 
% L=strlength(m);
% for i=1:L
%     if(m(i)>n(i))
%         z=data_reduce(m,n);
%         if(z(i) >P(i))
%             M = data_reduce(z,P);
%         break
%         elseif (z(i) <P(i))
%             M = z;
%         break
%         elseif (z(i) ==P(i))
%              M(i)=0;
%         end
%        
%   
%     elseif(m(i)<n(i))
%         z1=data_reduce(n,m);
%         if (z1(i) <P(i))
%             M =data_reduce(P,z1);
%          break
%         elseif (z1(i)>P(i))
%             z2=data_reduce(z1,P);
%             M= data_reduce(P,z2);
%             break
%         elseif (z1(i)==P(i))
%             M(i)=0;
%         end
%     end
% 
% end
% if(m(i)==n(i))
%     M='0000000000000000000000000000000000000000000000000000000000000000';
% end
% % z2=data_add(z1,P);
% % % %  mod_reduce  模减 

function M= mod_reduce(m,n)

% % a='2454ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';
% % b='3159ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';

P='8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3';


L=strlength(m);
for i=1:L
    if(m(i)>n(i))
        M=data_reduce(m,n);
        break
    elseif(m(i)<n(i))
        z=data_add(m,P);
        M=data_reduce(z,n);
        break
    end
end


if(m(i)==n(i))
    M='0000000000000000000000000000000000000000000000000000000000000000';
end

% z2=data_add(z1,P);