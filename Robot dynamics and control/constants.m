trajectory_filename = "trajectory1.csv";
%traj_data = [time, pos (1x6), vel(1x6)]
trajectory_data = [0 0 pi/2 0 0 0 0 0 0 0 0 0 0;
                   1 0.1745 -1.3090 0.1745 0.1745 0.1745 0.1745 0.1745 0.1745 0.1745 0.0698 0.0349 0.1571;
                   2 0.2045 -0.5 0.2045 0.2545 0.2745 0.2045 0.03 0.2 0.03 0.08 0.1 0.03
                   3 0.6981 1.5708 0.8727 0.6981 0.3491 0.5 0 0 0 0 0 0];

velocity_position = 2;
if velocity_position == 0
    KP = [8,zeros(1,5);0,7,zeros(1,4);0,0,7,zeros(1,3);zeros(1,3),5,0,0;zeros(1,4),4,0;zeros(1,5),2]
    KV = [3,zeros(1,5);0,3.7,zeros(1,4);0,0,5,zeros(1,3);zeros(1,3),3,0,0;zeros(1,4),3,0;zeros(1,5),1]
    goal_point = [40;90;50;40;20;90]*pi/180
    speed_goal = [0;0;0;0;0;0]
else
    KP = [8,zeros(1,5);0,7,zeros(1,4);0,0,7,zeros(1,3);zeros(1,3),5,0,0;zeros(1,4),4,0;zeros(1,5),2]
    KV = [4,zeros(1,5);0,8,zeros(1,4);0,0,7,zeros(1,3);zeros(1,3),5,0,0;zeros(1,4),4,0;zeros(1,5),2]
    goal_point = [10;-75;10;10;10;10]*pi/180
    speed_goal = [10;10;10;4;2;9]*pi/180
end


torque_constant = [8.27/270, 8.27/270, 8.27/410, 8.27/410, 8.27/530, 8.27/330];
gear_ratio = [40, 40, 35, 35, 30, 1];
CtlSat = zeros(1,length(gear_ratio));
for i = 1:length(gear_ratio)
    if i < 3
        CtlSat(i) = 15*torque_constant(i)*gear_ratio(i);
    else
        if i == 3
            CtlSat(i) = 20*torque_constant(i)*gear_ratio(i);
        
        else
            CtlSat(i) = 10*torque_constant(i)*gear_ratio(i);
        end
    end 
end
disp(CtlSat)
CtlSat1 = CtlSat(1);
CtlSat2 = CtlSat(2);
CtlSat3 = CtlSat(3);
CtlSat4 = CtlSat(4);
CtlSat5 = CtlSat(5);
CtlSat6 = CtlSat(6);
%read trajectory array
T = readtable(trajectory_filename);
Tsize = size(T);
Tsize_matrix = Tsize/13;
T = table2array(T);
T = reshape(T, Tsize(2), Tsize(1));
%trajectory_sample = reshape(T.', Tsize_matrix(1),[]);
trajectory_data = zeros(Tsize_matrix(1), 13);
trajectory_data(1,1:13) = T(1:13); 
for i = 2:length(T)/13
    trajectory_data(i,1:13) = T((i-1)*13+1:(i-1)*13+13); 
end