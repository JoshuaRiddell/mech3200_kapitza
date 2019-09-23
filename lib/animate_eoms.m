function [time, state] = animate_eoms(time, state, spatial_cb, filename)
    FRAME_RATE = 20;
    DT = 1/FRAME_RATE;

    dt = time(2) - time(1);
    decimation = ceil(DT / dt);
    
    if (decimation > 1) 
        time = decimate(time, decimation);
        old_state = state;
        state = zeros(ceil(size(old_state, 1)/decimation), size(old_state,2));
        
        for k = 1:size(old_state,2)
            state(:, k) = downsample(old_state(:,k), decimation);
        end

        dt = dt * decimation;
    end

    num_links = size(state, 2)/2;

    
    lines = cell(num_links);
    for k = 1:num_links
        lines{k} = animatedline('MaximumNumPoints', 2);
    end
    
    markers = cell(num_links);
    for k = 1:num_links
        markers{k} = animatedline('MaximumNumPoints', 1, 'Marker', 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'auto');
    end

    offset = 0.5 + num_links;
    axis([-offset, offset, -offset, offset])

    if ~exist('videos', 'dir')
       mkdir('videos')
    end
    
    outputVideo = VideoWriter(['videos/', filename, '.avi']);
    outputVideo.FrameRate = FRAME_RATE;
    open(outputVideo)
    
    fig = gcf;
    
    tic;
    loop_start_time = toc;
    for k = 1:size(time, 1)
        positions = spatial_cb(time(k), state(k, :));

        for m = 1:num_links
            xm = positions(m,1);
            ym = positions(m,2);
            xm1 = positions(m+1,1);
            ym1 = positions(m+1,2);
            addpoints(lines{m}, xm, ym);
            addpoints(lines{m}, xm1, ym1);
            addpoints(markers{m}, xm1, ym1);
        end

        drawnow;
        
        F = getframe(fig);
        [img, ~] = frame2im(F);
        writeVideo(outputVideo, img);
    
        pause((dt*k + loop_start_time) - toc);
    end
    
    close(outputVideo)
end