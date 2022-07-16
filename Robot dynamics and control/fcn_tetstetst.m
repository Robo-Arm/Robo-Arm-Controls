function [qd, q_dot] = fcn(file_string, simulation_time)
    %#codegen
    %traj_data = [time, pos (1x6), vel(1x6)]
    trajectory_index = 0;
    file_string = char(file_string)
    data_size = zeros(1,2);
    coder.extrinsic("trajectory_size");
    coder.extrinsic("trajectory_output");
    data_size = trajectory_size(file_string);
    data_all = zeros(data_size(1), data_size(2));
    data_all = trajectory_output(file_string);
    %time = get_param('Robot_control','SimulationTime');
    %disp(simulation_time)
    data_time_size = size(data_all, 1);
    data_time = data_all(1:data_time_size, 1) - data_all(1);
    disp(data_time);
    trajectory_index = find( data_time > simulation_time, 1 );
    qd = reshape(data_all(trajectory_index, 2:7), 6,1);
    q_dot = reshape(data_all(trajectory_index, 8:size(data_all, 2)), 6,1);
    %num_time_stamps = (data_time(length(data_time))-data_time(1))/length(data_time);
end