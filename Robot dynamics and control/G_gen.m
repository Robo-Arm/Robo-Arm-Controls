function Gm = G_gen(g, theta_t)
    Gm = zeros(6,1);
    Gqfcn = evalin('base', 'Gqfcn');
    Gm = Gqfcn(g,theta_t(2),theta_t(3),theta_t(4),theta_t(5));
end