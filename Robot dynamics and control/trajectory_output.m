function data = trajectory_output(file_string)
    %traj_data = [time, pos (1x6), vel(1x6)]
    %traj_data = load(file_string+'.mat'); previously
    %disp(file_string);
    traj_data = evalin('base', file_string);
    %disp(traj_data)
    data = traj_data;
end