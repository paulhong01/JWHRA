function [M_alpha M_pi M_sita M_beta M_gamma M_landa U_alpha U_beta U_gamma U_delta U_landa U_pi U_sita] = Lagrange_update(UE,a,b,EE,M_alpha,M_delta,M_w,M_pi,M_sita,P_AC,P_HE,n,I_Ratio,E_Ratio,M_beta,M_gamma,M_landa,U_alpha,U_beta,U_gamma,U_delta,U_landa,U_pi,U_sita,index_loop2,Harvesting_energy)
%% LAGRANGE Summary of this function goes here
%   This function updates lagrange parameters.

param;
% step size
U_alpha=U_alpha/(sqrt(ceil(index_loop2/5)));
U_beta=U_beta/(sqrt(ceil((index_loop2/5))));
U_gamma=U_gamma/(sqrt(ceil(index_loop2/5)));
U_delta=U_delta/(sqrt(ceil(index_loop2/5)));
U_landa=U_landa/(sqrt(ceil(index_loop2/5)));
U_pi=U_pi/sqrt(ceil(index_loop2/5));
U_sita=U_sita/sqrt(ceil(index_loop2/5));

HE_temp=zeros(1,num_pico);  
POWER_temp=zeros(1,T);
for t=1:T
    for i=1:num_pico
       for k=1:UE.amount(t)
           Capacity_temp=0;
           WPF_temp=0;  
           Ratio_temp=0;
           count=1;
           HE_Power=0;
           for r=1:num_RBs
                Capacity_temp=Capacity_temp+a*n{t}(i,k,r)*Wo*log2((I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc))+b*n{t}(i,k,r)*Wo;
                HE_temp(i)=HE_temp(i)+P_efficiency*n{t}(i,k,r)*P_HE{t}(i,k,r);
                POWER_temp(t)=POWER_temp(t)+n{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r));
                WPF_temp=WPF_temp+H_efficiency*E_Ratio{t}(i,k,r)*(n{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r)+n{t}(i,k,r)*Interference);
                M_delta{t}(i,k,r)=(M_delta{t}(i,k,r)-U_delta*(n{t}(i,k,r)*(1-I_Ratio{t}(i,k,r)-E_Ratio{t}(i,k,r))));
                % check the ratio
                Ratio_temp=Ratio_temp+n{t}(i,k,r)*I_Ratio{t}(i,k,r);
                if n{t}(i,k,r)==1
                    count=count+1;
                end
                HE_Power=HE_Power+n{t}(i,k,r)*P_HE{t}(i,k,r);
           end
           % multiplier alpha update
           M_alpha{t}(i,k)=max(M_alpha{t}(i,k)-U_alpha*(Capacity_temp-R_min),0);
           % multiplier pi update
           M_pi{t}(i,k)=max(M_pi{t}(i,k)-U_pi*(P_UE-WPF_temp),0);
           % multiplier sita update
           M_sita{t}(i,k)=max(M_sita{t}(i,k)-U_sita*(WPF_temp-P_Require),0);
       end
       % multiplier beta update
       M_beta(t,i)=max(M_beta(t,i)-U_beta*(E_B-sum(Harvesting_energy(1:t))+HE_temp(i)),0);
       % multiplier gamma update
       M_gamma(t,i)=max(M_gamma(t,i)-U_gamma*(sum(Harvesting_energy(1:t))-HE_temp(i)),0);
       % multiplier landa update
       M_landa(t,i)=max(M_landa(t,i)-U_landa*(P_max-POWER_temp(t)),0);
    end
end

end

