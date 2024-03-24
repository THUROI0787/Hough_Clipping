function []=fmine(n, Xmin, Xmax, Ymin, Ymax, P1x, P2x, P1y, P2y)

d = Ymax;
c = Xmax;
figure(4);title('Mine'); hold on;
for i = 1:n
    plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'g-');
    k0 = (P2y(i)-P1y(i))/(P2x(i)-P1x(i));
    b0 = P1y(i) - k0*P1x(i);
    y0=min(P1y(i),P2y(i));
    y1=max(P1y(i),P2y(i));
    if (k0<0 && b0<0) || (k0>0 && b0>d)
        y0_=0;
        y1_=0;
    elseif k0>0 && b0<0
        y0_=0;
        if k0>(d-b0)/c
            y1_=d;
        elseif -b0/c<k0 && k0<=(d-b0)/c
            y1_=c*k0+b0;
        else
            y1_=y0_;
        end
    elseif k0<0 && b0>d
        y1_=d;
        if k0<-b0/c
            y0_=0;
        elseif -b0/c<=k0 && k0<(d-b0)/c
            y0_=c*k0+b0;
        else
            y0_=y1_;
        end
    elseif k0>=0 && b0>0 && b0<d
        y0_=b0;
        if k0>(d-b0)/c
            y1_=d;
        else
            y1_=c*k0+b0;
        end
    elseif k0<0 && b0>0 && b0<d
        y1_=b0;
        if k0<0-b0/c
            y0_=0;
        else
            y0_=c*k0+b0;
        end
    else
        y0_=0;
        y1_=0;
    end
    
    % 一维剪裁
    if y1_ == y0_
    elseif y1_>y0_
        if y1>y0_ && y0<y1_ && y1>y0
            if y1>=y1_ && y0>=y0_
                y1e=y1_;
                y0e=y0;
            elseif y0<=y0_ && y1<=y1_
                y0e=y0_;
                y1e=y1;
            elseif y1>=y1_ && y0<=y0_
                y1e=y1_;
                y0e=y0_;
            else
                y1e=y1;
                y0e=y0;
            end
            x0e=(y0e-b0)/k0;
            x1e=(y1e-b0)/k0;
            plot([x0e,x1e],[y0e,y1e],'m-','LineWidth',0.8);
        else
        end
    else
    end
end
plot([Xmin Xmax Xmax Xmin Xmin],[Ymin Ymin Ymax Ymax Ymin],'b-','LineWidth',0.8);
hold off;

end