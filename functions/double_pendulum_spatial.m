function [positions] = double_pendulum_spatial(t, y)
    T1 = y(1);
    T2 = y(3);
    x0 = 0;
    y0 = sin(50*t)/20;
    x1 = sin(T1);
    y1 = sin(50*t)/20 + cos(T1);
    x2 = sin(T1) + sin(T2);
    y2 = sin(50*t)/20 + cos(T1) + cos(T2);
    positions = [[x0, y0]; [x1, y1]; [x2, y2]];
end
