function result = ant_pattern(mobile)
%% ant_pattern Summary of this function goes here
%  This function sets up the antenna pattern.
theta_3dB = 70;
result = mobile;
result.ant = -min(12*((result.angle/theta_3dB).^2),20);