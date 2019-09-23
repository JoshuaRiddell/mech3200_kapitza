clear
setup

values = [
    m     1.0   %kg
    l     0.5   %m
    g     9.81  %m/s/s
    w_f   200   %rad/s (base oscillation)
    a     0.005 %m (base oscillation)
];

save('outputs/values', 'values')