function [time, state] = simulate_eoms(model)
    load(['outputs/' model], 'equations')
    load('outputs/values', 'values')

    num_equations = size(equations, 1);
    
    syms f1(T1, dT1, T2, dT2) f2(T1, dT1, T2, dT2)
    
    if num_equations == 1
        e1 = subs(equations(1), values(:, 1), values(:, 2));
        
        f1(T1, dT1, T2, dT2) = e1;
        
        eqs = @(t, y) [
            y(2)
            eval(f1(y(1), y(2), y(3), y(4)))
        ];
    
        y0 = [0.01; 0];
    elseif num_equations == 2
        e1 = subs(equations(1), values(:, 1), values(:, 2));
        e2 = subs(equations(2), values(:, 1), values(:, 2));
        
        f1(T1, dT1, T2, dT2) = e1;
        f2(T1, dT1, T2, dT2) = e2;
        
        eqs = @(t, y) [
            y(2)
            eval(f1(y(1), y(2), y(3), y(4)))
            y(4)
            eval(f2(y(1), y(2), y(3), y(4)))
        ];
    
        y0 = [0.01; 0; 0.01; 0.0];
    end

    tspan = linspace(0, 5, 200);
    [time, state] = ode45(eqs, tspan, y0);

    figure(1);
    plot(time, state);

%     figure(2);
%     clf
% 
%     syms X1(T1) Y1(T1, t) X2(T1, T2) Y2(T1, T2, t)
%     subs(x1, values(:, 1), values(:, 2))
%     X1(T1) = subs(x1, values(:, 1), values(:, 2));
%     Y1(T1, t) = subs(y1, values(:, 1), values(:, 2));
%     X2(T1, T2) = subs(x2, values(:, 1), values(:, 2));
%     Y2(T1, T2, t) = subs(y2, values(:, 1), values(:, 2));
% 
% 
%     for k = 1:size(time,1)
%         cx1 = eval(X1(y(k, 1)));
%         cy1 = eval(Y1(y(k, 1), time(k)));
%         cx2 = eval(X2(y(k, 1), y(k, 3)));
%         cy2 = eval(Y2(y(k, 1), y(k, 3), time(k)));
% 
%         hold off;
%         plot([0 cx1],[0 cy1],'r-');
%         hold on;
%         plot([cx1 cx2],[cy1 cy2],'g-');
% 
%         axis([-1 1 -1 1])
% 
%         drawnow
%         pause(0.001)
%     end
%     
%     y = 1
end