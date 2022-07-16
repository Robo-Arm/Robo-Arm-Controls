clear all
tic % sheck run time

%% parts weights
harmonic_weight = 0.126;
odrive_weight = 0.431;
aluminum_exweight_cm = 0.00554;
print_30cm = 0.276*0.9;
hobbyking1_weight = 0.26;
link4_weight = 0.2225
joint4_weight = 0.7345;
link3_weight = 0.4845;
joint3_weight = 0.7345;
joint6_weight = 0.17+0.2+0.1; % motor + camera + enclosure
link_joint4_weight = joint4_weight+link4_weight
link_joint3_weight = 1.4165
joint_5_weight = 0.5;
end_eff_length = 0.08;
end_eff_weight = 0.25;

%% DH and Inertia Parameters of our robot (based on UR5)

%alpha = [0,pi/2,0,0,-pi/2, pi/2];
alpha = [pi/2,0,0,pi/2, -pi/2,0]; %changed
a = [0,-.30,-.18,0,0,0];%changed
%a = [0,0,.30,.18,0,0];%changed

d = [.2,0,0,.0935,.08,end_eff_length/2];
%m = [1.5,1.5,link_joint3_weight,link_joint4_weight,0.528,joint6_weight];
m = [2,link_joint3_weight,link_joint4_weight,joint_5_weight,joint6_weight,end_eff_weight]; %changed
% centre of mass for the entire link
p_c1 = [0,0,0]*10^(-3);
p_c2 = [110,0,20]*10^(-3);%changed
p_c3 = [180-159,0,5]*10^(-3);%changed
%p_c2 = [200,0,20]*10^(-3);%changed
%p_c3 = [159,0,5]*10^(-3);%changed
p_c4 = [0,0,10]*10^(-3);
p_c5 = [0,0,5]*10^(-3);
p_c6 = [0,0,50]*10^(-3);
% inertia tensor of the entire link
% In_1 = [84,0,0;0,64,0;0,0,84]*10^(-4);
% In_2 = [78,0,0;0,21,0;0,0,21]*10^(-4);
% In_3 = [16,0,0;0,462,0;0,0,462]*10^(-4);
% In_4 = [16,0,0;0,16,0;0,0,9]*10^(-4);
% In_5 = [16,0,0;0,16,0;0,0,9]*10^(-4);
% In_6 = eye(3)*10^(-4);
In_1_xyz = [m(1)*0.025^2/4+1/12*m(1)*0.154^2,m(1)*0.025^2/2,m(1)*0.025^2/4+1/12*m(1)*0.154^2];
a_l_2 = 0.2165; a_l_3 = 0.119; b_l_23 = 0.05; c_l_23 = 0.03; radius_2_3 = 0.031; H_2_3 = 0.113;
a_5 = 0.067; b_5 = 0.055; c_5 = 0.084; radius_6 = 0.035; H_6 = 0.035;
radius_7 = 0.035; H_7 = end_eff_length;
In_2_xyz_l = [1/12*link3_weight*(a_l_2^2+b_l_23^2), 1/12*link3_weight*(b_l_23^2+c_l_23^2), 1/12*link3_weight*(a_l_2^2+c_l_23^2)];
In_2_3_xyz_j = [1/2*joint3_weight*radius_2_3^2, 1/12*joint3_weight*H_2_3^2+1/4*joint3_weight*radius_2_3^2, 1/12*joint3_weight*H_2_3^2+1/4*joint3_weight*radius_2_3^2];
In_3_xyz_l = [1/12*link4_weight*(a_l_3^2+b_l_23^2), 1/12*link4_weight*(b_l_23^2+c_l_23^2), 1/12*link4_weight*(a_l_3^2+c_l_23^2)];
In_1 = [In_1_xyz(1),0,0;0,In_1_xyz(2),0;0,0,In_1_xyz(3)];
In_2 = [In_2_xyz_l(1) + In_2_3_xyz_j(1),0,0;0,In_2_xyz_l(2) + In_2_3_xyz_j(2),0;0,0,In_2_xyz_l(3) + In_2_3_xyz_j(3)];
In_3 = [In_3_xyz_l(1) + In_2_3_xyz_j(1),0,0;0,In_3_xyz_l(2) + In_2_3_xyz_j(2),0;0,0,In_3_xyz_l(3) + In_2_3_xyz_j(3)];
In_4 = [1/12*joint_5_weight*(a_5^2+b_5^2), 0, 0; 0, 1/12*joint_5_weight*(b_5^2+c_5^2), 0; 0, 0, 1/12*joint_5_weight*(a_5^2+c_5^2)];
In_5 = [1/12*joint6_weight*H_6^2+1/4*joint6_weight*radius_6^2,0,0;0,1/2*joint6_weight*radius_6^2,0;0,0,1/12*joint6_weight*H_6^2+1/4*joint6_weight*radius_6^2];
In_6 = [1/12*m(6)*H_7^2+1/4*m(6)*radius_7^2,0,0;0,1/2*m(6)*radius_7^2,0;0,0,1/12*m(6)*H_7^2+1/4*m(6)*radius_7^2];
% inertia tensor & centre of mass of different component of a link
% centre of mass for partial links NOTE: need to change later
p_c1_l = [0,-1.93,-26.51]*10^(-3);
p_c2_l = [a(2)/2,0,d(4)]*10^(-3);
p_c3_l = [a(3)/2,0,0]*10^(-3);
p_c4_l = [0,16.34,107.35]*10^(-3);
p_c5_l = [0,-16.34,-1.8]*10^(-3);
p_c6_l = [0,0,-1.159]*10^(-3);
%inertia tensor for the partial link
In_1_l = [84,0,0;0,64,0;0,0,84]*10^(-4);
In_2_l = [78,0,0;0,21,0;0,0,21]*10^(-4);
In_3_l = [16,0,0;0,462,0;0,0,462]*10^(-4);
In_4_l = [16,0,0;0,16,0;0,0,9]*10^(-4);
In_5_l = [16,0,0;0,16,0;0,0,9]*10^(-4);
In_6_l = eye(3)*10^(-4);
% centre of mass for joints
p_c1_j = [0,-1.93,-26.51]*10^(-3);
p_c2_j = [212.5,0,113.36]*10^(-3);
p_c3_j = [272.32,0,26.5]*10^(-3);
p_c4_j = [0,16,34,107.35]*10^(-3);
p_c5_j = [0,-16.34,-1.8]*10^(-3);
p_c6_j = [0,0,-1.159]*10^(-3);
% inertia tensor for the joint
In_1_j = [84,0,0;0,64,0;0,0,84]*10^(-4);
In_2_j = [78,0,0;0,21,0;0,0,21]*10^(-4);
In_3_j = [16,0,0;0,462,0;0,0,462]*10^(-4);
In_4_j = [16,0,0;0,16,0;0,0,9]*10^(-4);
In_5_j = [16,0,0;0,16,0;0,0,9]*10^(-4);
In_6_j = eye(3)*10^(-4);
%% PARAMETERs AND SYMBOLs
g=sym('g');
alpha_0=alpha(1);alpha_1=alpha(2);alpha_2=alpha(3);alpha_3=alpha(4);alpha_4=alpha(5);alpha_5=alpha(6);
a_0=a(1);a_1=a(2);a_2=a(3);a_3=a(4);a_4=a(5);a_5=a(6);
d_1=d(1);d_2=d(2);d_3=d(3);d_4=d(4);d_5=d(5);d_6=d(6);
p_cx1=p_c1(1);p_cy1=p_c1(2);p_cz1=p_c1(3);
p_cx2=p_c2(1);p_cy2=p_c2(2);p_cz2=p_c2(3);
p_cx3=p_c3(1);p_cy3=p_c3(2);p_cz3=p_c3(3);
p_cx4=p_c4(1);p_cy4=p_c4(2);p_cz4=p_c4(3);
p_cx5=p_c5(1);p_cy5=p_c5(2);p_cz5=p_c5(3);
p_cx6=p_c6(1);p_cy6=p_c6(2);p_cz6=p_c6(3);
m_1=m(1);m_2=m(2);m_3=m(3);m_4=m(4);m_5=m(5);m_6=m(6);
q_1=sym('q_1');q_2=sym('q_2');q_3=sym('q_3');q_4=sym('q_4');q_5=sym('q_5');q_6=sym('q_6');
dq_1=sym('dq_1');dq_2=sym('dq_2');dq_3=sym('dq_3');dq_4=sym('dq_4');dq_5=sym('dq_5');dq_6=sym('dq_6');
%% ROTATION MATRICEs  
% R_1=[cos(q_1) -sin(q_1) 0;
%      sin(q_1)*cos(alpha_0) cos(q_1)*cos(alpha_0) -sin(alpha_0);
%      sin(q_1)*sin(alpha_0) cos(q_1)*sin(alpha_0)  cos(alpha_0)];
% R_2=[cos(q_2) -sin(q_2) 0;
%      sin(q_2)*cos(alpha_1) cos(q_1)*cos(alpha_1) -sin(alpha_1);
%      sin(q_2)*sin(alpha_1) cos(q_2)*sin(alpha_1)  cos(alpha_1)];
% R_3=[cos(q_3) -sin(q_3) 0;
%      sin(q_3)*cos(alpha_2) cos(q_3)*cos(alpha_2) -sin(alpha_2);
%      sin(q_3)*sin(alpha_2) cos(q_3)*sin(alpha_2)  cos(alpha_2)];
% R_4=[cos(q_4) -sin(q_4) 0;
%      sin(q_4)*cos(alpha_3) cos(q_4)*cos(alpha_3) -sin(alpha_3);
%      sin(q_4)*sin(alpha_3) cos(q_4)*sin(alpha_3)  cos(alpha_3)];
% R_5=[cos(q_5) -sin(q_5) 0;
%      sin(q_5)*cos(alpha_4) cos(q_5)*cos(alpha_4) -sin(alpha_4);
%      sin(q_5)*sin(alpha_4) cos(q_5)*sin(alpha_4)  cos(alpha_4)];
% R_6=[cos(q_6) -sin(q_6) 0;
%      sin(q_6)*cos(alpha_5) cos(q_6)*cos(alpha_5) -sin(alpha_5);
%      sin(q_6)*sin(alpha_5) cos(q_6)*sin(alpha_5)  cos(alpha_5)];

%based on roll pitch yaw
R_1 = Rotaion_Matrix(q_1, alpha_0); %changed
R_2 = Rotaion_Matrix(q_2-pi/2, alpha_1);
R_3 = Rotaion_Matrix(q_3, alpha_2);
R_4 = Rotaion_Matrix(q_4-pi/2, alpha_3);
R_5 = Rotaion_Matrix(q_5, alpha_4);
R_6 = Rotaion_Matrix(q_6, alpha_5);

%based on skew matrix
% skew01 = [1 0 0; 0 0 1; 0 -1 0];
% skew12 = [0 -1 0; 1 0 0; 0 0 1];
% skew23 = [1 0 0; 0 1 0; 0 0 1];
% skew34 = [0 -1 0;  0 0 1; -1 0 0];
% skew45 = [1 0 0; 0 0 -1; 0 1 0];
% skew56 = [-1 0 0; 0 -1 0; 0 0 1];
% R_1 = Rotaion_skew(q_1)*skew01;
% R_2 = Rotaion_skew(q_2)*skew12;
% R_3 = Rotaion_skew(q_3)*skew23;
% R_4 = Rotaion_skew(q_4)*skew34;
% R_5 = Rotaion_skew(q_5)*skew45;
% R_6 = Rotaion_skew(q_6)*skew56;

%% POSITION VECTORs
% p_1=[a_0;-sin(alpha_0)*d_1;cos(alpha_0)*d_1];
% p_2=[a_1;-sin(alpha_1)*d_2;cos(alpha_1)*d_2];
% p_3=[a_2;-sin(alpha_2)*d_3;cos(alpha_2)*d_3];
% p_4=[a_3;-sin(alpha_3)*d_4;cos(alpha_3)*d_4];
% p_5=[a_4;-sin(alpha_4)*d_5;cos(alpha_4)*d_5];
% p_6=[a_5;-sin(alpha_5)*d_6;cos(alpha_5)*d_6];
p_1=[cos(q_1)*a_0;sin(q_1)*a_0;d_1];
p_2=[cos(q_2-pi/2)*a_1;sin(q_2-pi/2)*a_1;d_2];
p_3=[cos(q_3)*a_2;sin(q_3)*a_2;d_3];
p_4=[cos(q_4)*a_3;sin(q_4)*a_3;d_4];
p_5=[cos(q_5)*a_4;sin(q_5)*a_4;d_5];
d_camera_o5 = 0.0554;
p_5_camera=[cos(q_5)*a_4;sin(q_5)*a_4;d_5+d_camera_o5];
p_6=[cos(q_6)*a_5;sin(q_6)*a_5;d_6];
%% TRANSLATION MATRICES AND FORWARD KINEMATICS
T_1 = [R_1,p_1;zeros(1,3),1];
T_2 = [R_2,p_2;zeros(1,3),1];
T_3 = [R_3,p_3;zeros(1,3),1];
T_4 = [R_4,p_4;zeros(1,3),1];
T_5 = [R_5,p_5;zeros(1,3),1];
T_6 = [R_6,p_6;zeros(1,3),1];
T = T_1*T_2*T_3*T_4*T_5*T_6;

%% COMs' POSITION VECTORs
p_c1=p_1+R_1*[p_cx1;p_cy1;p_cz1];
p_c2=p_1+R_1*(p_2+R_2*[p_cx2;p_cy2;p_cz2]);
p_c3=p_1+R_1*(p_2+R_2*(p_3+R_3*[p_cx3;p_cy3;p_cz3]));
p_c4=p_1+R_1*(p_2+R_2*(p_3+R_3*(p_4+R_4*[p_cx4;p_cy4;p_cz4])));
p_c5=p_1+R_1*(p_2+R_2*(p_3+R_3*(p_4+R_4*(p_5+R_5*([p_cx5;p_cy5;p_cz5])))));
p_c5_camera=p_1+R_1*(p_2+R_2*(p_3+R_3*(p_4+R_4*(p_5_camera+R_5*([p_cx5;p_cy5;p_cz5])))));
p_c6=p_1+R_1*(p_2+R_2*(p_3+R_3*(p_4+R_4*(p_5+R_5*(p_6+R_6*[p_cx6;p_cy6;p_cz6])))));
% simplify every step
p_c1 = simplify(p_c1);p_c2 = simplify(p_c2);p_c3 = simplify(p_c3);p_c4 = simplify(p_c4);p_c5 = simplify(p_c5);p_c6 = simplify(p_c6);
%% SYSTEM's STATEs
q=[q_1;q_2;q_3;q_4;q_5;q_6];
% dq=[dq_1;dq_2;dq_3;dq_4;dq_5;dq_6];
%% LINEAR PART of JACOBIANs
J_v1=jacobian(p_c1,q);
J_v2=jacobian(p_c2,q);
J_v3=jacobian(p_c3,q);
J_v4=jacobian(p_c4,q);
J_v5=jacobian(p_c5,q);
J_v5_camera=jacobian(p_c5_camera,q);
J_v6=jacobian(p_c6,q);
% simplify every step
J_v1 = simplify(J_v1);J_v2 = simplify(J_v2);J_v3 = simplify(J_v3);J_v4 = simplify(J_v4);J_v5 = simplify(J_v5);J_v6 = simplify(J_v6);
%% ROTATION MATRICEs FROM BASE
R_20=R_1*R_2;
R_30=R_20*R_3;
R_40=R_30*R_4;
R_50=R_40*R_5;
R_60=R_50*R_6;
% simplify every step
R_20 = simplify(R_20);R_30 = simplify(R_30);R_40 = simplify(R_40);R_50 = simplify(R_50);R_60 = simplify(R_60);
%% ANGULAR PART of JACOBIANs
%o=zeros(3,7);
J_o1=[R_1(:,3),zeros(3,5)];
J_o2=[R_1(:,3),R_20(:,3),zeros(3,4)];
J_o3=[R_1(:,3),R_20(:,3),R_30(:,3),zeros(3,3)];
J_o4=[R_1(:,3),R_20(:,3),R_30(:,3),R_40(:,3),zeros(3,2)];
J_o5=[R_1(:,3),R_20(:,3),R_30(:,3),R_40(:,3),R_50(:,3),zeros(3,1)];
J_o6=[R_1(:,3),R_20(:,3),R_30(:,3),R_40(:,3),R_50(:,3),R_60(:,3)];
%% JACOBIAN MATRIX OF THE END-EFFECTOR
Jacobi = [J_v6;J_o6];
Jacobi_camera = [J_v5_camera;J_o5];
Jacobi3 = [J_v3;J_o3];
Jacobi4 = [J_v4;J_o4];
Jacobi5 = [J_v5;J_o5];
Jacobi6 = [J_v6;J_o6];
%% ROBOT's INERTIA (MASS) MATRIX
M=J_v1.'*m_1*eye(3)*J_v1+J_o1.'*R_1*In_1*R_1.'*J_o1...
 +J_v2.'*m_2*eye(3)*J_v2+J_o2.'*R_20*In_2*R_20.'*J_o2...
 +J_v3.'*m_3*eye(3)*J_v3+J_o3.'*R_30*In_3*R_30.'*J_o3...
 +J_v4.'*m_4*eye(3)*J_v4+J_o4.'*R_40*In_4*R_40.'*J_o4...
 +J_v5.'*m_5*eye(3)*J_v5+J_o5.'*R_50*In_5*R_50.'*J_o5...
 +J_v6.'*m_6*eye(3)*J_v6+J_o6.'*R_60*In_6*R_60.'*J_o6;
%% CORIOLIS and CENTRIFUGAL MATRIX
for k=1:6
   for s=1:6
      C(k,s)=.5*((diff(M(k,s),q_1)+diff(M(k,1),q(s,1))-diff(M(1,s),q(k,1)))*dq_1...
                +(diff(M(k,s),q_2)+diff(M(k,2),q(s,1))-diff(M(2,s),q(k,1)))*dq_2...
                +(diff(M(k,s),q_3)+diff(M(k,3),q(s,1))-diff(M(3,s),q(k,1)))*dq_3...
                +(diff(M(k,s),q_4)+diff(M(k,4),q(s,1))-diff(M(4,s),q(k,1)))*dq_4...
                +(diff(M(k,s),q_5)+diff(M(k,5),q(s,1))-diff(M(5,s),q(k,1)))*dq_5...
                +(diff(M(k,s),q_6)+diff(M(k,6),q(s,1))-diff(M(6,s),q(k,1)))*dq_6);
   end
end
%% POTENTIAL ENERGIES and GRAVITY VECTOR
P1=m_1*[0,0,g]*p_c1;
P2=m_2*[0,0,g]*p_c2;
P3=m_3*[0,0,g]*p_c3;
P4=m_4*[0,0,g]*p_c4;
P5=m_5*[0,0,g]*p_c5;
P6=m_6*[0,0,g]*p_c6;
P=P1+P2+P3+P4+P5+P6;
%P=P2+P3+P4+P5+P6;
g_1=diff(P,q_1);
g_2=diff(P,q_2);
g_3=diff(P,q_3);
g_4=diff(P,q_4);
g_5=diff(P,q_5);
g_6=diff(P,q_6);
G=[g_1;g_2;g_3;g_4;g_5;g_6];
%% DYNAMICAL EQUATIONs of MOTION
% % % % %           M(q)*ddq + C(q,dq)dq + G(q) = u
save ('UR5.mat','T','Jacobi','M','C','G');

fid = fopen('UR5T.txt', 'w');
fwrite(fid, char(T), 'char');
fclose(fid);

fid = fopen('UR5M.txt', 'w');
fwrite(fid, char(M), 'char');
fclose(fid);

fid = fopen('UR5C.txt', 'w');
fwrite(fid, char(C), 'char');
fclose(fid);

fid = fopen('UR5G.txt', 'w');
fwrite(fid, char(G), 'char');
fclose(fid);

fid = fopen('UR5J.txt', 'w');
fwrite(fid, char(Jacobi), 'char');
fclose(fid);
toc

%simplify symbolic functions
%disp("simplify M(q)")
%M = simplify(M)
%disp("simplify C(q)")
%C = simplify(C)
%disp("simplify G(q)")
%G = simplify(G)
%toc

tic
Mfcn = matlabFunction(M);
%invMfcn = matlabFunction(inv(M));
%C_collect = collect(C_q);
Cqfcn = matlabFunction(C);
%G_collect = collect(G_q);
Gqfcn = matlabFunction(G);
toc
qqq = Gqfcn(9.81, pi/2, 0, 0, 0)
%% get jacobian into files
jacobian_fcn = matlabFunction(Jacobi_camera);
J3 =  matlabFunction(Jacobi3,'File','J3');
J4 =  matlabFunction(Jacobi4,'File','J4');
J5 =  matlabFunction(Jacobi5,'File','J5');
J6 =  matlabFunction(Jacobi6,'File','J6');
%% get FK into files
T_03 = T_1*T_2*T_3;
T03 =  matlabFunction(T_03,'File','T03');
T3 =  matlabFunction(T_3,'File','T3');
T4 =  matlabFunction(T_4,'File','T4');
T5 =  matlabFunction(T_5,'File','T5');
T6 =  matlabFunction(T_6,'File','T6');