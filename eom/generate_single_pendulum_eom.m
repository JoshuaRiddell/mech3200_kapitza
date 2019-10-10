function [] = generate_single_pendulum_eom(values)
    setup;

    % double pendulum lagrange based on http://scienceworld.wolfram.com/physics/DoublePendulum.html
    y0 = a * sin(w_f * t);
    x1 = l * sin(theta1);
    y1 = l * cos(theta1) + y0;  % with vertical oscillation

    % kinetic energy
    T_pendulum = 1/2 * m * (diff(x1, t)^2 + diff(y1, t)^2);

    % potential energy
    V_pendulum = m * g * y1;

    % form the lagrangian
    L = T_pendulum - V_pendulum;
    L = subs(L, diff_f, diff_var);
    L = simplify(expand(L));

    % generate equations of motion
    eom = lagrange(L, lagrange_v(1:3));

    % solve for the acceleration terms
    [e1] = solve(eom(1), ddT1) - c * dT1;

    % concat equations into vector
    equations = [e1];

    % save equations to mat file
    if ~exist('outputs', 'dir')
       mkdir('outputs')
    end
    save('outputs/single_eom', 'equations');

    % substitute in numeric values
    e1 = subs(e1, values(:, 1), values(:, 2));

    y0 = subs(y0, values(:, 1), values(:, 2));

    x1 = subs(x1, diff_f, diff_var);
    y1 = subs(y1, diff_f, diff_var);

    x1 = subs(x1, values(:, 1), values(:, 2));
    y1 = subs(y1, values(:, 1), values(:, 2));

    % make equations into function
    if ~exist('functions', 'dir')
       mkdir('functions')
    end
    
    FID = fopen('functions/single_pendulum_func.m', 'w');
    fprintf(FID, '%s\n', 'function [dydx] = single_pendulum_func(t, y)');
    fprintf(FID, '%s\n', '    dydx = [0; 0];');
    fprintf(FID, '%s\n', '    T1 = y(1);');
    fprintf(FID, '%s\n', '    dT1 = y(2);');
    fprintf(FID, '%s\n', '    dydx(1) = dT1;');
    fprintf(FID, '%s\n', ['    dydx(2) = ', char(e1), ';']);
    fprintf(FID, '%s\n', 'end');
    fclose(FID);

    % export spatial functions
    FID = fopen('functions/single_pendulum_spatial.m', 'w');
    fprintf(FID, '%s\n', 'function [positions] = single_pendulum_spatial(t, y)');
    fprintf(FID, '%s\n', '    T1 = y(1);');
    fprintf(FID, '%s\n', '    x0 = 0;');
    fprintf(FID, '%s\n', ['    y0 = ', char(y0), ';']);
    fprintf(FID, '%s\n', ['    x1 = ', char(x1), ';']);
    fprintf(FID, '%s\n', ['    y1 = ', char(y1), ';']);
    fprintf(FID, '%s\n', '    positions = [[x0, y0]; [x1, y1]];');
    fprintf(FID, '%s\n', 'end');
    fclose(FID);
end






