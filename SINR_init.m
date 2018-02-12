function SINR_i = SINR_init( UE )
%% SINR_INIT Summary of this function goes here
%  This function initialize SINR setting
param;
P_equal=P_max/num_RBs;
h_mean=mean([mean(mean(UE.channel_gain{1}(UE.amount(1)*2/3+1:end,3,:),3)),mean(mean(UE.channel_gain{1}(UE.amount(1)/3+1:UE.amount(1)*2/3,2,:),3)),mean(mean(UE.channel_gain{1}(1:UE.amount(1)/3,1,:),3))]);
I_ratio_init=0.5;
SINR_i=(I_ratio_init*P_equal*h_mean)/(I_ratio_init*Interference+N_proc);

end

