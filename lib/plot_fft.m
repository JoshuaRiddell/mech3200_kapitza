function plot_fft(Fv, FTs, title_, flim, amplim, lgnd)
    Iv = 1:numel(Fv);
    
    semilogy(Fv, abs(FTs(Iv, :))*2)

    title(title_);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude (rad)');
    
    xlim(flim);
    ylim(amplim);
    legend(lgnd);
 end

