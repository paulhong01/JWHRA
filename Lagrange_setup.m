function [M_alpha M_delta M_w M_pi M_sita P_AC P_HE n M_beta M_gamma M_landa U_alpha U_beta U_gamma U_delta U_landa U_pi U_sita] = Lagrange_setup( UE,a,b )
%% Lagrange_setup Summary of this function goes here
%   This function sets up the lagrange parameters
param;
P_equal=P_max/num_RBs;
h_mean=mean([mean(mean(UE.channel_gain{1}(UE.amount(1)*2/3+1:end,3,:),3)),mean(mean(UE.channel_gain{1}(UE.amount(1)/3+1:UE.amount(1)*2/3,2,:),3)),mean(mean(UE.channel_gain{1}(1:UE.amount(1)/3,1,:),3))]);
% Inital lagrange multiplier 
for t=1:T
    M_alpha{t}=zeros(num_pico,UE.amount(t))+((Interference+2*N_proc)*log(2)/4-a*Wo*N_proc)/(a*Wo*N_proc);
    M_delta{t}=ones(num_pico,UE.amount(t),num_RBs);
    M_w{t}=zeros(num_pico,num_RBs);
    M_pi{t}=zeros(num_pico,UE.amount(t))+2.5*10^14;
    M_sita{t}=zeros(num_pico,UE.amount(t))+1*10^14;
    P_AC{t}=zeros(num_pico,UE.amount(t),num_RBs)+P_equal/2;
    P_HE{t}=zeros(num_pico,UE.amount(t),num_RBs)+P_equal/2;
    n{t}=zeros(num_pico,UE.amount(t),num_RBs);
end
M_beta=zeros(T,num_pico)+3*10^10;
M_gamma=zeros(T,num_pico)+3*10^10;
M_landa=zeros(T,num_pico)+6*10^11;  

%% Initial step size
U_alpha=10^-3;
U_beta=3*10^8;
U_gamma=0.5*10^9;
U_delta=1;
U_landa=10^12; 
U_pi=3*10^14;
U_sita=10^17;
end

