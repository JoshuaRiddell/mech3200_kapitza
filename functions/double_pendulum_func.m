function [dydx] = double_pendulum_func(t, y)
    dydx = [0; 0; 0; 0];
    T1 = y(1);
    dT1 = y(2);
    T2 = y(3);
    dT2 = y(4);
    dydx(1) = dT1;
    dydx(2) = (2000*cos(T1 - 100*t) - (981*sin(T1))/25 - 2000*cos(T1 + 100*t) - 1000*cos(T1 - T2)*cos(T2 - 100*t) + 1000*cos(T1 - T2)*cos(T2 + 100*t) + (981*sin(T2)*cos(T1 - T2))/50 + 2*dT2^2*sin(T1 - T2) + 2*dT1^2*cos(T1 - T2)*sin(T1 - T2))/(2*(cos(T1 - T2)^2 - 2));
    dydx(3) = dT2;
    dydx(4) = -((981*sin(T2))/50 - 1000*cos(T2 - 100*t) + 1000*cos(T2 + 100*t) + 1000*cos(T1 - T2)*cos(T1 - 100*t) - 1000*cos(T1 - T2)*cos(T1 + 100*t) - (981*sin(T1)*cos(T1 - T2))/50 + 2*dT1^2*sin(T1 - T2) + dT2^2*cos(T1 - T2)*sin(T1 - T2))/(cos(T1 - T2)^2 - 2);
end