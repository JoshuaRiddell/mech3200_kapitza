function [time, state] = simulate_eoms(tstart, tend, y0, model)
    tspan = tstart:0.001:tend;
    [time, state] = ode45(model, tspan, y0);
end