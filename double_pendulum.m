% import shared libraries
addpath lib
setup

% double pendulum lagrange based on http://scienceworld.wolfram.com/physics/DoublePendulum.html
x1 = l * sin(theta1);
y1 = l * cos(theta1) + a * sin(w_f * t);  % with vertical oscillation
x2 = l * sin(theta1) + l * sin(theta2);
y2 = l * cos(theta1) + l * cos(theta2) + a * sin(w_f * t);  % with vertical oscillation

% kinetic energy
T_pendulum = ...
    1/2 * m * (diff(x1, t)^2 + diff(y1, t)^2) + ...
    1/2 * m * (diff(x2, t)^2 + diff(y2, t)^2) ...
;

% potential energy
V_pendulum = ...
    m * g * y1 + ...
    m * g * y2 ...
;

% form the lagrangian
L = T_pendulum - V_pendulum;
L = subs(L, diff_f, diff_var);
L = simplify(expand(L));

% generate equations of motion
eom = lagrange(L, lagrange_v);

% solve for the acceleration terms
[e1, e2] = solve(eom(1), eom(2), ddT1, ddT2);

% concat equations into vector
equations = [e1; e2];

% save equations to mat file
save('outputs/double_eom', 'equations');
