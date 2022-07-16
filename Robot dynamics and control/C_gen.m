function C_q_qd = C_gen(theta_t, q_dot)
    C_q_qd = zeros(6,1);
    Cq_dot = zeros(6,1);
    Cqfcn = evalin('base', 'Cqfcn');
    Cq_dot = Cqfcn(theta_t(1), theta_t(2), theta_t(3), theta_t(4), theta_t(5), theta_t(6), q_dot(1), q_dot(2), q_dot(3), q_dot(4), q_dot(5), q_dot(6));
    C_q_qd = Cq_dot;
end