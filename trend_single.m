clf
close all
clear

addpath lib functions eom

setup

% parameters to be subsituted into the model
values = [
    m     1.0   %kg
    l     0.95   %m
    g     9.81  %m/s/s
    w_f   200    %rad/s (base oscillation)
    a     0.03  %m (base oscillation)
    c     0.09 %N.s (axial damping)
];


generate_single_pendulum_eom(values);
[time, state] = simulate_eoms(10, [0.1, 0], @single_pendulum_func);
animate_eoms(time, state, @single_pendulum_spatial, 'ansys_single');

get_dominant_frequency(time, state(:, 1))


% x = 50:50:500;
% len = size(x, 2);
% z = zeros(1, len);
% 
% for k = 1:len
%     values(4,2) = x(k);
% 
%     generate_single_pendulum_eom(values);
%     [time, state] = simulate_eoms(10, [0.1, 0], @single_pendulum_func);
%     % animate_eoms(time, state, @single_pendulum_spatial, 'single');
% 
%     y(k) = get_dominant_frequency(time, state(:, 1));
% end

% plot(x,y);

% t = time;
% s = state(:,1);
% % s = sin(0.5*2*pi*t) + sin(0.5*2*pi*t).*0.1.*sin(10*2*pi*t)
% 
% figure
% plot(t,s);
% 
% 
% figure
% plot(Fv, log(abs(FTs(Iv))*2))
% hold on
% plot(Fv(Locs), log(Pks), '+r')
% hold off
% grid
% 
% 
