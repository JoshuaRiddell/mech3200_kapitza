clf
close all

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

generate_double_pendulum_eom(values);
[time, state] = simulate_eoms(10, [0.1; 0; 0; 0], @double_pendulum_func);

figure(1);
plot(time, [state(:,1), state(:,3)]);

figure(2);
animate_eoms(time, state, @double_pendulum_spatial, 'double');

Fs = 1/(time(2) - time(1));
L = size(state, 1);
Y = fft([state(:,1), state(:,2)]);
P2 = abs(Y/L);
P1 = P2(1:L/2+1, :);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,20*log(P1)) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

figure(3)
clf
plot(state(:,1), state(:,2))
hold on
plot(state(:,3), state(:,4))