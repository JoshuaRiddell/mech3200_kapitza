function plot_time_signal(t, y, title_, tlim, lgnd)
    plot(t, y);

    title(title_);
    xlabel('Time (s)');
    ylabel('Amplitude (rad)');
    
    xlim(tlim);
    legend(lgnd);
 end

