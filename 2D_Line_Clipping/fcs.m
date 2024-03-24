function []=fcs(n, Xmin, Xmax, Ymin, Ymax, P1x, P2x, P1y, P2y)
P1code = zeros(n,4);
P2code = zeros(n,4);
for i = 1:n
    
    if P1x(i) < Xmin
        P1code(i,1) = 1;
    end
    if P1x(i) > Xmax
        P1code(i,2) = 1;
    end
    if P1y(i) < Ymin
        P1code(i,3) = 1;
    end
    if P1y(i) > Ymax
        P1code(i,4) = 1;
    end
    
    if P2x(i) < Xmin
        P2code(i,1) = 1;
    end
    if P2x(i) > Xmax
        P2code(i,2) = 1;
    end
    if P2y(i) < Ymin
        P2code(i,3) = 1;
    end
    if P2y(i) > Ymax
        P2code(i,4) = 1;
    end
    
end

P_label = zeros(1,n);
for i = 1:n
    P_or = P1code(i,1:4) | P2code(i,1:4);
    if sum(P_or) == 0
        P_label(i) = 1;  % 起止点都在区域内
    end
    P_and = P1code(i,1:4) & P2code(i,1:4);
    if sum(P_and) > 0
        P_label(i) = 2;  % 一定不经过区域
    end
end

figure(2);title('Cohen-Sutherland'); hold on;
for i = 1:n
    if P_label(i) == 1
        plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'m-','LineWidth',0.8);
        
    elseif P_label(i) == 2
        plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'g-');
        
    elseif P_label(i) == 0
        
        P_or = P1code(i,1:4) | P2code(i,1:4);
        plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'g-');
        
        if P_or(1) == 1
            Py = P1y(i) + (Xmin-P1x(i))*(P2y(i)-P1y(i))/(P2x(i)-P1x(i));
            if P1x(i) < Xmin
                P1x(i) = Xmin; P1y(i) = Py;
            elseif P2x(i) < Xmin
                P2x(i) = Xmin; P2y(i) = Py;
            end
        end
        
        if P_or(2) == 1
            Py = P1y(i) + (Xmax-P1x(i))*(P2y(i)-P1y(i))/(P2x(i)-P1x(i));
            if P1x(i) > Xmax
                P1x(i) = Xmax; P1y(i) = Py;
            elseif P2x(i) > Xmax
                P2x(i) = Xmax; P2y(i) = Py;
            end
        end
        
        if P_or(3) == 1
            Px = P1x(i) + (Ymin-P1y(i))/(P2y(i)-P1y(i))*(P2x(i)-P1x(i));
            if P1y(i) < Ymin
                P1x(i) = Px; P1y(i) = Ymin;
            elseif P2y(i) < Ymin
                P2x(i) = Px; P2y(i) = Ymin;
            end
        end
        
        if P_or(4) == 1
            Px = P1x(i) + (Ymax-P1y(i))/(P2y(i)-P1y(i))*(P2x(i)-P1x(i));
            if P1y(i) > Ymax
                P1x(i) = Px; P1y(i) = Ymax;
            elseif P2y(i) > Ymax
                P2x(i) = Px; P2y(i) = Ymax;
            end
        end
        if P1x(i) >= Xmin && P1x(i) <= Xmax && ...
                P2x(i) >= Xmin && P2x(i) <= Xmax && ...
                P1y(i) >= Ymin && P1y(i) <= Ymax && ...
                P2y(i) >= Ymin && P2y(i) <= Ymax
            plot([P1x(i),P2x(i)],[P1y(i),P2y(i)],'m-','LineWidth',0.8);
        end
        plot([Xmin Xmax Xmax Xmin Xmin],[Ymin Ymin Ymax Ymax Ymin],'b-','LineWidth',0.8);
    end
end
hold off;
end