function [f] = get_dominant_frequency(Fv, FTs)
    Iv = 1:numel(Fv);                                               % Index Vector
    [~,Locs] = findpeaks(abs(FTs(Iv))*2, 'MinPeakHeight',1.7E-05, 'MinPeakDist',100, 'NPeaks', 1);

    f = Fv(Locs);
end
