clf
close all
clear

addpath lib functions eom

setup

% parameters to be subsituted into the model
values = [
    m     1.0   %kg
    l     1.1   %m
    g     9.81  %m/s/s
    w_f   62.8    %rad/s (base oscillation)
    a     0.11  %m (base oscillation)
    c     0.09 %N.s (axial damping)
];

generate_single_pendulum_eom(values);
[time, state] = simulate_eoms(10, [0.1, 0], @single_pendulum_func);
% animate_eoms(time, state, @single_pendulum_spatial, 'single');

t = time;
% s = state(:,1);
s = sin(0.5*2*pi*t) + sin(0.5*2*pi*t).*0.1.*sin(10*2*pi*t)
Ts = mean(diff(t));                                             % Sampling Interval
L = numel(t);
Fs = 1/Ts;                                                      % Sampling Frequency
Fn = Fs/2;                                                      % Nyquist Frequency

figure
plot(t,s);

FTs = fft(s - mean(s))/L;
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                             % Frequency Vector
Iv = 1:numel(Fv);                                               % Index Vector
[Pks,Locs] = findpeaks(abs(FTs(Iv))*2, 'MinPeakHeight',1.7E-05, 'MinPeakDist',100);

figure
plot(Fv, log(abs(FTs(Iv))*2))
hold on
plot(Fv(Locs), log(Pks), '+r')
hold off
grid


