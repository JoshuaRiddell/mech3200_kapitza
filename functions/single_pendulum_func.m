function [dydx] = single_pendulum_func(t, y)
    dydx = [0; 0];
    T1 = y(1);
    dT1 = y(2);
    dydx(1) = dT1;
    dydx(2) = (981*sin(T1))/100 - 125*sin(50*t)*sin(T1);
end
