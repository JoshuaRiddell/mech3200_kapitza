clear

syms y dy ddy T1 dT1 ddT1 T2 dT2 ddT2
syms m l g w_f t

variables = [y dy ddy T1 dT1 ddT1 T2 dT2 ddT2];

% double pendulum lagrange based on http://scienceworld.wolfram.com/physics/DoublePendulum.html
x1 = l * sin(T1);
y1 = -l * cos(T1) + sin(w_f * t);  % with vertical oscillation
x2 = l * sin(T1) + l * sin(T2);
y2 = -l * cos(T1) - l * cos(T2) + sin(w_f * t);  % with vertical oscillation

T_pendulum = ...
    1/2 * m * (l * dT1)^2 + ... % m1 motion
    1/2 * m * (l * dT1)^2 + ... % m2 motion due to pendulum arm 1
    1/2 * m * (l * dT2)^2 + ... % m2 motion due to pendulum arm 2
    1/2 * m * (2 * l^2 * dT1 * dT2 * cos(T1-T2)) ...
;

V_pendulum = ...
    m * g * y1 + ...
    m * g * y2 ...
;

T_pendulum = simplify(expand(T_pendulum));
V_pendulum = simplify(expand(V_pendulum));

L = simplify(expand(T_pendulum - V_pendulum));

eom = lagrange(L, variables);

pretty(expand(eom.'))