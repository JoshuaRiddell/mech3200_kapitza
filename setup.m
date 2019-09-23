clear

% constant parameters
syms m l g w_f a
% independent variable
syms t
% time varying dependent variables
syms theta1(t) theta2(t)
% dependent variable
syms T1 dT1 ddT1 T2 dT2 ddT2

% lagrange variables (used in lagrange function)
lagrange_v = [T1 dT1 ddT1 T2 dT2 ddT2];

% functional form of differentials
diff_f = [
    theta1
    diff(theta1, t)
    diff(theta1, t, 2)
    theta2
    diff(theta2, t)
    diff(theta2, t, 2)
];

% variable form of differentials
diff_var = [
    T1
    dT1
    ddT1
    T2
    dT2
    ddT2
];
