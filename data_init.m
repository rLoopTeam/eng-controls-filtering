clear all
[data.numerical,data.rext]=xlsread(fullfile(pwd,'total_flight.xlsx')); 

%setup the channel indexes into the csv file
ch_idx__accel_x = 57;
ch_idx__accel_y = 60;
ch_idx__accel_z = 63;

%setup the laser indexes
ch_idx_laser_l_aft_height = 39;
ch_idx_laser_r_aft_height = 42;
ch_idx_laser_aft_yaw = 45;

%read the laser data

data__laser_l_aft_height = data.numerical(:,39);
data__laser_r_aft_height = data.numerical(:,42);
data__laser_aft_yaw = data.numerical(:,45);

all_sensor_data = [data__laser_l_aft_height,data__laser_r_aft_height,data__laser_aft_yaw];

% data__laser_r_fore_height = flip(data__laser_r_aft_height);
% data__laser_l_fore_height = flip(data__laser_l_aft_height);

data__accel_x = data.numerical(:,57);
data__accel_y = data.numerical(:,60);
data__accel_z = data.numerical(:,63);
