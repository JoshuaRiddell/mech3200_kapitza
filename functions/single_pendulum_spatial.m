function [positions] = single_pendulum_spatial(t, y)
    T1 = y(1);
    x0 = 0;
    y0 = sin(50*t)/20;
    x1 = sin(T1);
    y1 = sin(50*t)/20 + cos(T1);
    positions = [[x0, y0]; [x1, y1]];
end
