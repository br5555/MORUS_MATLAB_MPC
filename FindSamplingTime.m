clc
clear all 
close all
min_error = 1.558927362347432e+11;
for i = 759:1000
    error = uav_error_function_yaw(i);
    if(min_error > error)
        i
        min_error = error;
    end
end