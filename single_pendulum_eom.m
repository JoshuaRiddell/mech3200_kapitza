% import shared libraries
addpath lib
parameters

% setup local syms
syms T dT ddT
syms theta(t)

variables = [T dT ddT];

% double pendulum lagrange based on http://scienceworld.wolfram.com/physics/DoublePendulum.html
x = l * sin(theta);
% y = l * cos(theta) + a * sin(w_f * t);  % with vertical oscillation
y = l * cos(theta);  % with vertical oscillation

replace_old = [
    theta
    diff(theta, t)
    diff(theta, t, 2)
];

replace_new = [
    T
    dT
    ddT
];

dx = subs(diff(x, t), replace_old, replace_new);
dy = subs(diff(y, t), replace_old, replace_new);

x = subs(x, theta, T);
y = subs(y, theta, T);

T_pendulum = ...
    1/2 * m * (dx^2 + dy^2) ...
;

V_pendulum = ...
    m * g * y ...
;

T_pendulum = simplify(expand(T_pendulum));
V_pendulum = simplify(expand(V_pendulum));

L = simplify(expand(T_pendulum - V_pendulum));

eom = lagrange(L, variables);

[e1] = solve(eom(1), ddT);
disp(e1);
    
tspan = [0 5];
y0 = [0.1; 0];
[t, y] = ode45(@eqs, tspan, y0);

plot(t, y);

function dydt = eqs(t, y)
    dydt2 = (9.81*sin(y(1)) - 0.1 * 60^2*sin(t*100)*sin(y(1)))/0.5;

    dydt = [y(2); dydt2];
end

