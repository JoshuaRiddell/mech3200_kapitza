function [Fv, FTs] = generate_fft(t, y)
    Ts = mean(diff(t));                                             % Sampling Interval
    L = numel(t);
    Fs = 1/Ts;                                                      % Sampling Frequency
    Fn = Fs/2;                                                      % Nyquist Frequency

    FTs = fft(y - mean(y))/L;
    Fv = linspace(0, 1, fix(L/2)+1)*Fn;                             % Frequency Vector
end

