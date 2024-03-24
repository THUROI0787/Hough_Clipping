clear;close all;clc;

%% 产生随机线段并画出
n = 2000;
m = 100;
k=1600;
t=600;
Xmin = 0; Xmax = 400;
Ymin = 0; Ymax = 300;
% figure(5);title('Original'); hold on;

P1x = rand(1,n-m)*k-t;  
P1x=[P1x,rand(1,m)*Xmax];
P2x = rand(1,n-m)*k-t;
P2x=[P2x,rand(1,m)*Xmax];
P1y = rand(1,n-m)*k-t;  
P1y=[P1y,rand(1,m)*Ymax];
P2y = rand(1,n-m)*k-t;
P2y=[P2y,rand(1,m)*Ymax];

% for i = 1:n 
%     plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'b-');
% end
% hold off;

%% enu 计算与绘图
% fenu(n, Xmin, Xmax, Ymin, Ymax, P1x, P2x, P1y, P2y);

%% CS 计算与绘图
fcs(n, Xmin, Xmax, Ymin, Ymax, P1x, P2x, P1y, P2y);

%% LB 计算与绘图
flb(n, Xmin, Xmax, Ymin, Ymax, P1x, P2x, P1y, P2y);

%% Mine 计算与绘图
fmine(n, Xmin, Xmax, Ymin, Ymax, P1x, P2x, P1y, P2y);