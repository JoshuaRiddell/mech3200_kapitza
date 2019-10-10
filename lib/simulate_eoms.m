function [time, state] = simulate_eoms(time_length, y0, model)
    tspan = 0:0.001:time_length;
    [time, state] = ode45(model, tspan, y0);
end