function []=fenu(n, Xmin, Xmax, Ymin, Ymax, P1x, P2x, P1y, P2y)

figure(1);title('enumeration'); hold on;
delta = 0.05;

for i = 1:n
    plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'g-');
    k0 = (P2y(i)-P1y(i))/(P2x(i)-P1x(i));
    b0 = P1y(i) - k0*P1x(i);
    x0=min(P1x(i),P2x(i));
    x1=max(P1x(i),P2x(i));
    y0 = k0*x0 + b0;
    y1 = k0*x1 + b0;
    if Xmin<=x0 && x0<=Xmax && Ymin<=y0 && y0<=Ymax
        flag = 1;   % 指示起点在边界内
    else
        flag = 0;
    end
    for j = x0+delta:delta:x1  % 遍历X坐标
        yj = k0*j + b0;
        if Xmin<=j && j<=Xmax && Ymin<=yj && yj<=Ymax
            if flag ==1
                plot([j-delta,j],[yj-delta*k0,yj],'m-','LineWidth',0.8);
            end
            flag=1;
        else
            flag=0;
        end
    end
end
plot([Xmin Xmax Xmax Xmin Xmin],[Ymin Ymin Ymax Ymax Ymin],'b-','LineWidth',0.8);
hold off;
end