function [EE flag SINR_next] = EE_get(UE,a,b,EE,M_alpha,M_delta,M_w,M_pi,M_sita,P_AC,P_HE,n,I_Ratio,E_Ratio,M_beta,M_gamma,M_landa,U_alpha,U_beta,U_gamma,U_delta,U_landa,U_pi,U_sita,index_loop2,Harvesting_energy)
%% EE_GET Summary of this function goes here
%  This function collects EE performance
param;
CHECK_Capacity=0;
CHECK_PC_smallcell=0;
CHECK_Pkr_AC=0;
CHECK_PC_UE=0;
CHECK_PHE=0;
temp=0;
Ratio_temp=0;
PAC_temp=0;
PHE_temp=0;
count2=0;
HE_temp=zeros(1,num_pico); 
% EE performance calculation and collection
for t=1:T
   for i=1:num_pico
        CHECK_PC_smallcell=CHECK_PC_smallcell+Pc;
        POWER_temp=0;
        for k=1:UE.amount(t)
           CHECK_PC_UE=CHECK_PC_UE+P_UE;
           Capacity_temp=0;
           WPF_temp=0;
           for r=1:num_RBs
                CHECK_Capacity=CHECK_Capacity+a*n{t}(i,k,r)*Wo*log2((I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc))+b*n{t}(i,k,r)*Wo;
                Capacity_temp=Capacity_temp+a*n{t}(i,k,r)*Wo*log2((I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc))+b*n{t}(i,k,r)*Wo;
                CHECK_Pkr_AC=CHECK_Pkr_AC+P_efficiency*n{t}(i,k,r)*P_AC{t}(i,k,r);
                CHECK_PHE=CHECK_PHE+H_efficiency*E_Ratio{t}(i,k,r)*n{t}(i,k,r)*((P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r)+Interference);
                WPF_temp=WPF_temp+H_efficiency*E_Ratio{t}(i,k,r)*(n{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r)+n{t}(i,k,r)*Interference);
                HE_temp(i)=HE_temp(i)+P_efficiency*n{t}(i,k,r)*P_HE{t}(i,k,r);
                POWER_temp=POWER_temp+n{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r));
                temp=temp+n{t}(i,k,r)*(I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc);
                count2=count2+n{t}(i,k,r);
           end
        end
   end
end
CHECK_EE(index_loop2)=CHECK_Capacity/(CHECK_PC_smallcell+CHECK_Pkr_AC+CHECK_PC_UE-CHECK_PHE);
EE=CHECK_EE(index_loop2);
if (Capacity_temp-R_min>=0)&&(P_UE-WPF_temp>=0)&&(WPF_temp-P_Require>=0)&&(E_B-sum(Harvesting_energy(1:t))+HE_temp(i)>0)&&(sum(Harvesting_energy(1:t))-HE_temp(i)>0)&&(P_max-POWER_temp>0)
    flag=true;
else
    flag=false;
end
SINR_next=temp/count2;

end
