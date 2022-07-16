function size_trac = trajectory_size(file_string)
    %traj_data = [time, pos (1x6), vel(1x6)]
    %traj_data = load(file_string+'.mat'); previously
    traj_data = evalin('base', file_string);
    size_trac = size(traj_data);
end