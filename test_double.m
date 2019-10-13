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

generate_double_pendulum_eom(values);
[time, state] = simulate_eoms(10, [0.1; 0; 0; 0], @double_pendulum_func);

figure(1);
plot(time, [state(:,1), state(:,3)]);

t = time;
s = state(:,1);
Ts = mean(diff(t));                                             % Sampling Interval
L = numel(t);
Fs = 1/Ts;                                                      % Sampling Frequency
Fn = Fs/2;                                                      % Nyquist Frequency

figure(2);
plot(t,s);

FTs1 = fft(s - mean(s))/L;
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                             % Frequency Vector
Iv = 1:numel(Fv);                                               % Index Vector
[Pks1,Locs1] = findpeaks(abs(FTs1(Iv))*2, 'MinPeakHeight',1.7E-05, 'MinPeakDist',100);

s = state(:,3);
Ts = mean(diff(t));                                             % Sampling Interval
L = numel(t);
Fs = 1/Ts;                                                      % Sampling Frequency
Fn = Fs/2;                                                      % Nyquist Frequency

figure(3);
plot(t,s);

FTs2 = fft(s - mean(s))/L;
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                             % Frequency Vector
Iv = 1:numel(Fv);                                               % Index Vector
[Pks2,Locs2] = findpeaks(abs(FTs2(Iv))*2, 'MinPeakHeight',1.7E-05, 'MinPeakDist',100);

figure(4)
plot(Fv, log(abs(FTs1(Iv))*2))
hold on
plot(Fv, log(abs(FTs2(Iv))*2))
plot(Fv(Locs), log(Pks), '+r')
hold off
grid













% figure(2);
% animate_eoms(time, state, @double_pendulum_spatial, 'double');
% 
% Fs = 1/(time(2) - time(1));
% L = size(state, 1);
% Y = fft([state(:,1), state(:,2)]);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1, :);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% plot(f,20*log(P1)) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% 
% figure(3)
% clf
% plot(state(:,1), state(:,2))
% hold on
% plot(state(:,3), state(:,4))