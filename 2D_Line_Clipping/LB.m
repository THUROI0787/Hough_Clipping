clear;close all;clc;

%% 产生随机线段并画出
n = 100;
Xmin = 0; Xmax = 8;
Ymin = 0; Ymax = 6;
figure(1);title('Original'); hold on;

P1x = rand(1,n-5)*32-12;
P1x=[P1x,rand(1,5)*8];
P2x = rand(1,n-5)*32-12;
P2x=[P2x,rand(1,5)*8];
P1y = rand(1,n-5)*32-12;
P1y=[P1y,rand(1,5)*6];
P2y = rand(1,n-5)*32-12;
P2y=[P2y,rand(1,5)*6];

for i = 1:n
    plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'b-');
end
hold off;

%% LB 计算与绘图
figure(3);title('Liang-Barsky'); hold on;
for t = 1:n
    plot([P1x(t),P2x(t)],[P1y(t),P2y(t)],'g-');
    p1=P1x(t)-P2x(t);
    p2=P2x(t)-P1x(t);
    p3=P1y(t)-P2y(t);
    p4=P2y(t)-P1y(t);
    p=[p1,p2,p3,p4];
    q1=P1x(t)-Xmin;
    q2=Xmax-P1x(t);
    q3=P1y(t)-Ymin;
    q4=Ymax-P1y(t);
    q=[q1,q2,q3,q4];
    u=q./p;
    
    % 冒泡排序
    for i=1:4
        for j=(i+1):4
            if(u(j)>u(i))
                temp=u(i);
                u(i)=u(j);
                u(j)=temp;
                temp1=p(i);
                p(i)=p(j);
                p(j)=temp1;
                temp2=q(i);
                q(i)=q(j);
                q(j)=temp2;
            end
        end
    end
    
    u1=0;
    u2=1;
    for m=1:4
        if (u(5-m)>0 && p(5-m)<0)
            u1=u(5-m);
        end
        if (u(m)<1 && p(m)>0)
            u2=u(m);
        end
    end
    
    if(p1==0||p2==0||p3==0||p4==0&&u1<u2)
        if((q1<0||q2<0||q3<0||q4<0))
        else
            x_1=P1x(t)+u1*(P2x(t)-P1x(t));
            y_1=P1y(t)+u1*(P2y(t)-P1y(t));
            x_2=P1x(t)+u2*(P2x(t)-P1x(t));
            y_2=P1y(t)+u2*(P2y(t)-P1y(t));
            plot([x_1,x_2],[y_1,y_2],'m-','LineWidth',0.8);
        end
    elseif(u1<=u2)
        x_1=P1x(t)+u1*(P2x(t)-P1x(t));
        y_1=P1y(t)+u1*(P2y(t)-P1y(t));
        x_2=P1x(t)+u2*(P2x(t)-P1x(t));
        y_2=P1y(t)+u2*(P2y(t)-P1y(t));
        plot([x_1,x_2],[y_1,y_2],'m-','LineWidth',0.8);
    end
end
plot([Xmin Xmax Xmax Xmin Xmin],[Ymin Ymin Ymax Ymax Ymin],'b-','LineWidth',0.8);
hold off;