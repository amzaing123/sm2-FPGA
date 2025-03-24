
x='792DBFF323BF447350ED77DB0F13CD2543F56EFB006B377C83926AA80BBE2521';
y='1C00C158C12E57B5DC18B532A16F4F6C7057AF44B25F2924517E6601EBF08367';
z='1214A8958B8F6BC0BAE037BA2E4C924D5A5E852006F128F4A10515CE4100A8DA';
% x='421DEBD61B62EAB6746434EBC3CC315E32220B3BADD50BDC4C4E6C147FEDD43D';
% y='0680512BCBB42C07D47349D2153B70C4E5D7FDFCBFA36EA1A85841B9E46E09A2';
% z='0000000000000000000000000000000000000000000000000000000000000001';

[x2,y2,z2]=pointdouble(x,y,z);   %%%%2
A=[x2,y2,z2];


[x4,y4,z4]=pointdouble(x2,y2,z2);  %%%%4
B=[x4,y4,z4];

[x8,y8,z8]=pointdouble(x4,y4,z4);  %%%%8
C=[x8,y8,z8];

[x16,y16,z16]=pointdouble(x8,y8,z8);  %%%%16
D=[x16,y16,z16];

[x32,y32,z32]=pointdouble(x16,y16,z16);  %%%%32
E=[x32,y32,z32];

[x64,y64,z64]=pointdouble(x32,y32,z32);  %%%%64
F=[x64,y64,z64];

[x128,y128,z128]=pointdouble(x64,y64,z64);  %%%%128
G=[x128,y128,z128];

[x256,y256,z256]=pointdouble(x128,y128,z128);  %%%%256
H=[x256,y256,z256];

[x512,y512,z512]=pointdouble(x256,y256,z256);  %%%%256
I=[x512,y512,z512];

[x1024,y1024,z1024]=pointdouble(x512,y512,z512);  %%%%256
J=[x1024,y1024,z1024];

[x211,y211,z211]=pointdouble(x1024,y1024,z1024);  %%%%256
K=[x211,y211,z211];



[x3,y3,z3]=pointadd(x,y,z,x2,y2,z2);
[x7,y7,z7]=pointadd(x3,y3,z3,x4,y4,z4);
[x15,y15,z15]=pointadd(x7,y7,z7,x8,y8,z8);
[x31,y31,z31]=pointadd(x15,y15,z15,x16,y16,z16);
[x63,y63,z63]=pointadd(x31,y31,z31,x32,y32,z32);
[x127,y127,z127]=pointadd(x63,y63,z63,x64,y64,z64);
[x255,y255,z255]=pointadd(x127,y127,z127,x128,y128,z128);
[x511,y511,z511]=pointadd(x255,y255,z255,x256,y256,z256);


Z2=mod_inv(z511,1);

Z3=montgomery_mul(Z2,Z2);
Z4=montgomery_mul(Z3,Z2);

XX=montgomery_mul(x511,Z3);
YY=montgomery_mul(y511,Z4);


% Z12=mod_inv(z18,1);
% 
% Z13=montgomery_mul(Z12,Z12);
% Z14=montgomery_mul(Z13,Z12);
% 
% XX1=montgomery_mul(x18,Z13);
% YY1=montgomery_mul(y18,Z14);



















