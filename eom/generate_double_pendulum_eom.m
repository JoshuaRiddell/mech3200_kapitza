function [] = generate_double_pendulum_eom(values)
    setup;

    % double pendulum lagrange based on http://scienceworld.wolfram.com/physics/DoublePendulum.html
    y0 = a * sin(w_f * t);
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

    % substitute in numeric values
    equations = subs(equations, values(:, 1), values(:, 2));

    y0 = subs(y0, values(:, 1), values(:, 2));

    x1 = subs(x1, values(:, 1), values(:, 2));
    y1 = subs(y1, values(:, 1), values(:, 2));
    x1 = subs(x1, diff_f, diff_var);
    y1 = subs(y1, diff_f, diff_var);

    x2 = subs(x2, values(:, 1), values(:, 2));
    y2 = subs(y2, values(:, 1), values(:, 2));
    x2 = subs(x2, diff_f, diff_var);
    y2 = subs(y2, diff_f, diff_var);

    % make equations into function
    FID = fopen('functions/double_pendulum_func.m', 'w');
    fprintf(FID, '%s\n', 'function [dydx] = double_pendulum_func(t, y)');
    fprintf(FID, '%s\n', '    dydx = [0; 0; 0; 0];');
    fprintf(FID, '%s\n', '    T1 = y(1);');
    fprintf(FID, '%s\n', '    dT1 = y(2);');
    fprintf(FID, '%s\n', '    T2 = y(3);');
    fprintf(FID, '%s\n', '    dT2 = y(4);');
    fprintf(FID, '%s\n', '    dydx(1) = dT1;');
    fprintf(FID, '%s\n', ['    dydx(2) = ', char(equations(1)), ';']);
    fprintf(FID, '%s\n', '    dydx(3) = dT2;');
    fprintf(FID, '%s\n', ['    dydx(4) = ', char(equations(2)), ';']);
    fprintf(FID, '%s\n', 'end');
    fclose(FID);

    % export spatial functions
    FID = fopen('functions/double_pendulum_spatial.m', 'w');
    fprintf(FID, '%s\n', 'function [positions] = double_pendulum_spatial(t, y)');
    fprintf(FID, '%s\n', '    T1 = y(1);');
    fprintf(FID, '%s\n', '    T2 = y(3);');
    fprintf(FID, '%s\n', '    x0 = 0;');
    fprintf(FID, '%s\n', ['    y0 = ', char(y0), ';']);
    fprintf(FID, '%s\n', ['    x1 = ', char(x1), ';']);
    fprintf(FID, '%s\n', ['    y1 = ', char(y1), ';']);
    fprintf(FID, '%s\n', ['    x2 = ', char(x2), ';']);
    fprintf(FID, '%s\n', ['    y2 = ', char(y2), ';']);
    fprintf(FID, '%s\n', '    positions = [[x0, y0]; [x1, y1]; [x2, y2]];');
    fprintf(FID, '%s\n', 'end');
    fclose(FID);
end
    
    
    
    
    