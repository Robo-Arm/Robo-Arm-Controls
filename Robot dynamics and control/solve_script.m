%the robot goes through a sigularity when q_dot (velocity) or q_dotdot
%(acceleration) because very large with a sudden spike in the graph, or if 
%q (displacement) has a sudden large change,  this is because for 
%Moore-Penrose pseudo-inverse  singular value decomposition, for every 
%singular value, the damping factor goes to 0 which increase velocity by a lot 
close all; clear all;
prompt = 'What is the end-effecter location od? ';
od = input(prompt);
prompt = 'What is the approach vector kd? ';
kd = input(prompt);
prompt = 'What is the Sliding vector jd? ';
jd = input(prompt);

O0 = [0;0;0]; %define the origin at start
id = cross(jd, kd);%get final end-effector pose i vector
C_final = [(id) (jd) (kd)]; %get final end-effector rotational matrix

theta_start = deg2rad([0 0 0 0 0 0]);
theta_offset = deg2rad([0 0 0 0 0 0]);
di = [.08916,0,0,.10915,.09456,.0823]*1000;
ai = [0,0,.425,.39225,0,0]*1000;
alpha = [0,pi/2,0,0,-pi/2,pi/2];
k0 = [0;0;1];
j0 = [0;1;0];

o6i = [471.5; 149.1; 433.1]; %initial end-effector position
c6i = [0 0 1; 0 -1 0; 1 0 0];%initial rotational matrix

axang = rotm2axang(C_final); %get the final rataional vector s_hat and the angle of rotation 
cc = rotm2axang(c6i);
accel = 4/1^2 * [od - o6i; (axang(4))*(axang(1:3)')]; %derived from the fact that 1/2*acceleration * time^2 = 1/2*[final position - initial position; e] e is the error in position 

dt = 0.005; %time steps
%t_half = [0:dt:1/2];
%t_half2 = [1/2:dt:1];

v_dot_first_half = accel; % V_dot duing the first half second
v_dot_second_half = -accel;% V_dot duing the second half second
vt = [0;0;0;0;0;0];

q = theta_start'; q_dot = [0;0;0;0;0;0];%since initial velocity is 0 and q_dot = J^(-1)*vn(t)
i = 0; 
[Tn, J_past] = fork(q' + theta_offset,di, ai, alpha);

J = J_past;
q_dd = inv(J_past)*v_dot_first_half;
q_record = q;
q_dot_record = q_dot;
q_dd_record = q_dd;
vt_record= vt;
v_dot = v_dot_first_half;
%variables for 3d display
joint1_p = [];
joint2_p = [];
joint3_p = [];
joint4_p = [];
joint5_p = [];
joint6_p = [];
tt = [];
k6_r = [];
j6_r = [];
for t = dt:dt:1
    %%%collecting all the coordinates of each origin for visualizing the robot later
    [tt1, Cn1] = DH_homog(q(1), di(1), ai(1), alpha(1));
    tt = tt1;
    o1 = tt*[O0; 1];
    joint1_p = [joint1_p, o1(1:3)];
    
    [tt2, Cn2] = DH_homog(q(2), di(2), ai(2), alpha(2));
    tt = tt*tt2;
    o2 = tt*[O0; 1];
    joint2_p = [joint2_p, o2(1:3)];
    
    [tt3, Cn3] = DH_homog(q(3) + pi/2, di(3), ai(3), alpha(3));
    tt = tt*tt3;
    o3 = tt*[O0; 1];
    joint3_p = [joint3_p, o3(1:3)];
    
    [tt4, Cn4] = DH_homog(q(4), di(4), ai(4), alpha(4));
    tt = tt*tt4;
    o4 = tt*[O0; 1];
    joint4_p = [joint4_p, o4(1:3)];
    
    [tt5, Cn5] = DH_homog(q(5), di(5), ai(5), alpha(5));
    tt = tt*tt5;
    o5 = o4+tt5*[O0;1];
    joint5_p = [joint5_p, o5(1:3)];
    
    [tt6, Cn6] = DH_homog(q(6), di(6), ai(6), alpha(6));
    tt = tt*tt6;
    o6 = tt*[O0; 1];
    joint6_p = [joint6_p, o6(1:3)];
    %%%
    
    %%updating all the joints
    q = q + dt * q_dot + 1/2*(dt^2)*(q_dd);
    q_record = [q_record, q]; %record the new q
    
    [Tn, J]= fork(q' + theta_offset,di, ai, alpha); %get the new Jacobian using forward kinematics
    O6 = Tn*[O0;1];
    J_dot = (J - J_past)/dt; %approximate J_dot
    J_past = J;
    if(t <= 0.5) %get the next v(t) and v_dot value 
        vt = t*v_dot_first_half;
        v_dot = v_dot_first_half;
    else
        vt = (1-t)*v_dot_first_half;
        v_dot = v_dot_second_half;
    end
    vt_record = [vt_record, vt];
    q_dot = inv(J) * vt; %get new q_dot = J^-1 * v(t)
    q_dot_record = [q_dot_record,q_dot];%record the new q_dot
    
    q_dd = inv(J)*(v_dot - J_dot*q_dot);
    q_dd_record = [q_dd_record,q_dd];%record the new q_dotdot
end
position = Tn*[O0;1];
final_position = position(1:3)

%% Bonus: Visualising robot arm, I did it by tracking the coordinates of all the origin, so there will only be 5 '*' since origin 4 and 5 will come out to always have the same coordinate since they are the same position
rail = [1:1000];
for i=1:200
    hold off;
    figure(100);
    plot3(rail,rail, rail, joint1_p(1, i), joint1_p(2, i), joint1_p(3, i), '*');
    line([joint1_p(1, i), joint2_p(1, i)], [joint1_p(2, i), joint2_p(2, i)], [joint1_p(3, i), joint2_p(3, i)]);
    hold on;
    plot3(rail,rail, rail, joint2_p(1, i), joint2_p(2, i), joint2_p(3, i), '*');
    line([joint3_p(1, i), joint2_p(1, i)], [joint3_p(2, i), joint2_p(2, i)], [joint3_p(3, i), joint2_p(3, i)]);
    plot3(rail,rail, rail, joint3_p(1, i), joint3_p(2, i), joint3_p(3, i), '*');
    line([joint3_p(1, i), joint4_p(1, i)], [joint3_p(2, i), joint4_p(2, i)], [joint3_p(3, i), joint4_p(3, i)]);
    plot3(rail,rail, rail, joint4_p(1, i), joint4_p(2, i), joint4_p(3, i), '*');
    line([joint5_p(1, i), joint4_p(1, i)], [joint5_p(2, i), joint4_p(2, i)], [joint5_p(3, i), joint4_p(3, i)]);
    plot3(rail,rail, rail, joint5_p(1, i), joint5_p(2, i), joint5_p(3, i), '*');
    line([joint5_p(1, i), joint6_p(1, i)], [joint5_p(2, i), joint6_p(2, i)], [joint5_p(3, i), joint6_p(3, i)]);
    plot3(rail,rail, rail, joint6_p(1, i), joint6_p(2, i), joint6_p(3, i), '*');
    
    pause(0.005);
end

%% plotting q
figure();
plot([0:dt:1], q_record(1,:));
hold on;
plot([0:dt:1], q_record(2,:));
plot([0:dt:1], q_record(3,:));
plot([0:dt:1], q_record(4,:));
plot([0:dt:1], q_record(5,:));
plot([0:dt:1], q_record(6,:));
title("displacememt");
legend('joint 1','joint 2','joint 3','joint 4','joint 5','joint 6');

%% plotting q_dot
hold off
figure();
plot([0:dt:1], q_dot_record(1,:));
hold on; 
plot([0:dt:1], q_dot_record(2,:));
plot([0:dt:1], q_dot_record(3,:));
plot([0:dt:1], q_dot_record(4,:));
plot([0:dt:1], q_dot_record(5,:));
plot([0:dt:1], q_dot_record(6,:));
title("velocity");
legend('joint 1','joint 2','joint 3','joint 4','joint 5','joint 6');

%% plotting q_dot_dot
hold off
figure();
plot([0:dt:1], q_dd_record(1,:));
hold on;
plot([0:dt:1], q_dd_record(2,:));
plot([0:dt:1], q_dd_record(3,:));
plot([0:dt:1], q_dd_record(4,:));
plot([0:dt:1], q_dd_record(5,:));
plot([0:dt:1], q_dd_record(6,:));
ylim([-30, 30]);
title("acceleration");
legend('joint 1','joint 2','joint 3','joint 4','joint 5','joint 6');