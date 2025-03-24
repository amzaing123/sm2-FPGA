clear all;
clc
 
% x=[1,2,3,4,5,6,7];
% y1=[128,86,64,52,43,37,32];
% y2=[127,85,63,51,42,36,31];
% y3=[106,77,60,49,41,35,31];
% %y3=[75,66,58,48,41,35,31];
% plot(x,y1,'r.-','LineWidth', 3);     %以x矩阵的值为横坐标，y矩阵值为纵坐标，分别画出点(1,4),(2,5),(3,6),(4,2)
% hold on;
% plot(x,y2,'b.--','LineWidth', 3);              %'*'表示坐标点用*号表示，‘r’表示点为红色，'-'表示用实线连接
% hold on;
% plot(x,y3,'g.-','LineWidth', 3);
% axis([0,8,20,130]);  %设置x轴范围为0~5，y轴范围为0~10（注意，设置x、y轴范围要在plot函数后）
% xlabel('ω');
% ylabel('Computational complexity in the evaluation stage (A)');
% title('Computational complexities of the three algorithms under different window sizes');
% legend('ωNAF', ' The sliding window algorithm', ' The sliding window algorithm and ωNAF'); % Add legends

%%%
x=[1,2,3,4,5,6,7];
y1=[128,86,64,52,43,37,32];
y2=[127,85,63,51,42,36,31];
y3=[75,66,58,48,41,35,31];
%y3=[75,66,58,48,41,35,31];
plot(x,y1,'r.-','LineWidth', 3);     %以x矩阵的值为横坐标，y矩阵值为纵坐标，分别画出点(1,4),(2,5),(3,6),(4,2)
hold on;
plot(x,y2,'b.--','LineWidth', 3);              %'*'表示坐标点用*号表示，‘r’表示点为红色，'-'表示用实线连接
hold on;
plot(x,y3,'g.-','LineWidth', 3);
axis([0,8,20,130]);  %设置x轴范围为0~5，y轴范围为0~10（注意，设置x、y轴范围要在plot函数后）
xlabel('ω');
ylabel('Computational complexity in the evaluation stage (A)');
title('Computational complexities of the scalar k under different window sizes');
legend('ωNAF', ' The sliding window algorithm', ' The sliding window algorithm and ωNAF'); % Add legends