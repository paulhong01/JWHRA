%% Main program
% This program implements JWHRA algorithm with environment settings 
clc; clear all; close all;
param;
run=3;
count=1;
% Resouce allocation results
CHECK_ACt=zeros(1,T);
CHECK_HEt=zeros(1,T);
CHECK_PHEt=zeros(1,T);


while(1)
iteration1=3;
iteration2=30;
%% Environment and small cell setup
eNB=basesetup_19(radius); 
pico = sc_generator(eNB);

% UE setting
UE = ue_generator(eNB,pico,V,2);
UE=dist_angle_hexagon(eNB,pico,UE);

% Channel gain setup: large scale fading + small scale
[D UE]= pathloss_largescale(eNB,pico,UE);
for t=1:T
    H{t}=D{t}.^(-2.8);
end
UE=small_scale(UE);

%% Harvesting energy setup
Harvesting_energy=harvesting_setup(0);

%% Outer loop: SINR approximation
% SINR initialize
SINR(1)=SINR_init(UE);
% Outer loop
for index_loop1=1:iteration1
    old_EE=0;
    % SINR approximation
    a_temp(index_loop1)=SINR(index_loop1)/(1+SINR(index_loop1));
    a=a_temp(index_loop1);
    b_temp(index_loop1)=log(1+SINR(index_loop1))-SINR(index_loop1)/(1+SINR(index_loop1))*log(SINR(index_loop1));
    b=b_temp(index_loop1);
    
    % Lagragange parameter setting 
    [M_alpha M_delta M_w M_pi M_sita P_AC P_HE n M_beta M_gamma M_landa U_alpha U_beta U_gamma U_delta U_landa U_pi U_sita]=Lagrange_setup(UE,a,b);
    % Initial EE
    EE=0;
    
    %% Lagrange inner loop
    for index_loop2=1:iteration2
        % Lagrange iteration find solution
        [P_AC P_HE I_Ratio E_Ratio n]=Lagrange(UE,a,b,EE,M_alpha,M_delta,M_w,M_pi,M_sita,P_AC,P_HE,n,M_beta,M_gamma,M_landa,U_alpha,U_beta,U_gamma,U_delta,U_landa,U_pi,U_sita);
        
        % Lagrange parameter update
        [M_alpha M_pi M_sita M_beta M_gamma M_landa U_alpha U_beta U_gamma U_delta U_landa U_pi U_sita]=Lagrange_update(UE,a,b,EE,M_alpha,M_delta,M_w,M_pi,M_sita,P_AC,P_HE,n,I_Ratio,E_Ratio,M_beta,M_gamma,M_landa,U_alpha,U_beta,U_gamma,U_delta,U_landa,U_pi,U_sita,index_loop2,Harvesting_energy);
        
        %Check EE
        [flag SINR_next CHECK_AC CHECK_HE CHECK_PHEtotal CHECK_Ratio EE]=Lagrange_check(UE,a,b,EE,M_alpha,M_delta,M_w,M_pi,M_sita,P_AC,P_HE,n,I_Ratio,E_Ratio,M_beta,M_gamma,M_landa,U_alpha,U_beta,U_gamma,U_delta,U_landa,U_pi,U_sita,index_loop2,Harvesting_energy);
        EE_iteration(index_loop2)=EE;
    end
    SINR(index_loop1+1)=SINR_next;
    
    
end

%% Resouce allocation policies collection
if (flag && count>=run)
    CHECK_ACt=CHECK_ACt/(count-1);
    CHECK_HEt=CHECK_HEt/(count-1);
    CHECK_PHEt=CHECK_PHEt/(count-1);
    figure();
    draw=[CHECK_ACt' CHECK_HEt'];
    bar(draw);
    xlabel('Index of time intervals'); ylabel('Power(Watt)');
    legend('Allocated on-grid power','Allocated green power');
    figure();
    bar(CHECK_PHEt*1000);
    xlabel('Index of time intervals'); ylabel('Wireless charging capacity (mWatt)');
    legend('Average charging capactiy');
    break;
elseif (flag)
    CHECK_ACt=CHECK_ACt+CHECK_AC;
    CHECK_HEt=CHECK_HEt+CHECK_HE;
    CHECK_PHEt=CHECK_PHEt+CHECK_PHEtotal;
    count=count+1;
end

end




