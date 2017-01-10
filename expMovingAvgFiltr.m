%The script calculates exponential moving average for different alpha
%coefficients

%define maximum range
f32_max_range = 50.0;
%define alpha
f32_alpha = 0.01;

%set influences to 0
f32_new_sample_influence = 0;
f32_old_value_influence = 0;

%loop through all of the sensors
for j=1:3
    
    
%set the previous value for the first iteration
f32_previous_value = all_sensor_data(1,j);    
    
    
    %loop through all of the samples
    for i=1:size(all_sensor_data,1)

    %take the latest sample
    f32_new_sample = all_sensor_data(i,j);

        %check whether within range
        if abs(f32_new_sample - f32_previous_value) < 5
        %if f32_new_sample < f32_max_range
            % Calculate a new f32_current_value
            % @see http://dsp.stackexchange.com/questions/20333/how-to-implement-a-moving-average-in-c-without-a-buffer
            f32_new_sample_influence = f32_alpha * f32_new_sample;
            f32_old_value_influence = (1 - f32_alpha) * f32_previous_value;

            f32_current_value = f32_new_sample_influence + f32_old_value_influence;

            %remember the latest value
            f32_previous_value = f32_current_value;

        else
            %if above max threshold set to previous value
            f32_current_value = f32_previous_value;
        end

    all_sensor_data_filt(i,j) = f32_current_value;

    end
    
end

clf
plot(all_sensor_data);
hold on
plot(all_sensor_data_filt);