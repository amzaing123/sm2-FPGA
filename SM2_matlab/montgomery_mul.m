
% montgomery  

function result = montgomery_mul(x,y)

%%%%预计算aR(mod_P)=Monpro(a,R^2mod_P) ,bR(mod_P)=Monpro(b,R^2mod_P)   R=2^256
%%%%  P='8542D69E 4C044F18 E8B92435 BF6FF7DE 45728391 5C45517D 722EDB8B 08F1DFC3'  
%%%%  R^2mod(p)='0AE55229 283CD96A EE4D87DA 90D8C66C EB372DA8 3FC9C636 3D579C46 F6DE18F2'
%%%%  P'='ACE8C019 117B91A8 7C85E287 2C08DD0D 3B8465BC 9C2E9D06 A2A0380C 50F77715';
P='8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC3';
R2='0AE55229283CD96AEE4D87DA90D8C66CEB372DA83FC9C6363D579C46F6DE18F2';


% x='8542D69E4C044F18E8B92435BF6FF7DE457283915C45517D722EDB8B08F1DFC5';
% x='8654ABDEE1355A4CB4D5E2D36EB4F698AD7E1C3BAD5A6CCBB1564987F98CBACC';
% y='4659ADCBCE65FA68CDEBA465ACB449E8B8F89AD9BCA48321BC4E65A4BCF46A6E';
% x='0000000000000000000000000000000000000000000000000000000000000001';
% y='0000000000000000000000000000000000000000000000000000000000000001';

%%%%% xR(mod_P)=Monpro(x,R^2mod_P)
P_1='ACE8C019117B91A87C85E2872C08DD0D3B8465BC9C2E9D06A2A0380C50F77715';  %% (-P^-1)mod_R

X=mult256(x,R2);
X1=mult256(P_1,X(65:128));
m_X=X1(65:128);
mp_X=mult256(m_X,P);
X3=data_add(X,mp_X);
X4=X3(1:65);

P1=['0',P];
L=strlength(X4);
for i=1:L
    if(X4(i)>P1(i))
        X10=data_reduce(X4,P);
        X5=['0',X10];
        break
    elseif(X4(i)<P1(i))
        X5=X4;
        break
    end
end


%%%%% yR(mod_P)=Monpro(y,R^2mod_P)
P_1='ACE8C019117B91A87C85E2872C08DD0D3B8465BC9C2E9D06A2A0380C50F77715';  %% (-P^-1)mod_R

Y=mult256(y,R2);
Y1=mult256(P_1,Y(65:128));
m_Y=Y1(65:128);
mp_Y=mult256(m_Y,P);
Y3=data_add(Y,mp_Y);
Y4=Y3(1:65);

L=strlength(Y4);
for i=1:L
    if(Y4(i)>P1(i))
        Y10=data_reduce(Y4,P);
        Y5=['0',Y10];
        break
    elseif(Y4(i)<P1(i))
        Y5=Y4;
        break
    end
end

%%%%%  A=X5*Y5 进行两次蒙哥马利约减

A=mult256(Y5(2:65),X5(2:65));
A1=mult256(P_1,A(65:128));
m_A=A1(65:128);
mp_A=mult256(m_A,P);
A3=data_add(A,mp_A);
A4=A3(1:65);

L=strlength(A4);
for i=1:L
    if(A4(i)>P1(i))
        A10=data_reduce(A4,P);
        A5=['0',A10];
        break
    elseif(A4(i)<P1(i))
        A5=A4;
        break
    end
end

B1=mult256(P_1,A5(2:65));
m_B=B1(65:128);
mp_B=mult256(m_B,P);
B2=['0000000000000000000000000000000000000000000000000000000000000000',A5(2:65)];
B3=data_add(B2,mp_B);
B4=B3(1:65);

L=strlength(B4);
for i=1:L
    if(B4(i)>P1(i))
        B10=data_reduce(B4,P);
        B5=['0',B10];
        break
    elseif(B4(i)<P1(i))
        B5=B4;
        break
    end
end

result=B5(2:65);
























