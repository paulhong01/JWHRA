function [flag SINR_next CHECK_AC CHECK_HE CHECK_PHEtotal Average_Ratio EE] = Lagrange_check(UE,a,b,EE,M_alpha,M_delta,M_w,M_pi,M_sita,P_AC,P_HE,n,I_Ratio,E_Ratio,M_beta,M_gamma,M_landa,U_alpha,U_beta,U_gamma,U_delta,U_landa,U_pi,U_sita,index_loop2,Harvesting_energy )
%% LAGRANGE_CHECK Summary of this function goes here
%   This function collects resouce allocation policies.
param;
CHECK_Capacity=0;
CHECK_PC_smallcell=0;
CHECK_Pkr_AC=0;
CHECK_PC_UE=0;
CHECK_PHE=0;
CHECK_AC=zeros(1,T);
CHECK_HE=zeros(1,T);
CHECK_Ratio=zeros(1,T);
CHECK_Count=zeros(1,T);
CHECK_PHEtotal=zeros(1,T);
POWER_temp=zeros(1,T);
temp=0;
count2=0;
for t=1:T
   for i=1:num_pico
        CHECK_PC_smallcell=CHECK_PC_smallcell+Pc;
        for k=1:UE.amount(t)
           CHECK_PC_UE=CHECK_PC_UE+P_UE;
           Capacity_temp=0;
           WPF_temp=0;
           for r=1:num_RBs
                CHECK_Capacity=CHECK_Capacity+a*n{t}(i,k,r)*Wo*log2((I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc))+b*n{t}(i,k,r)*Wo;
                Capacity_temp=Capacity_temp+a*n{t}(i,k,r)*Wo*log2((I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc))+b*n{t}(i,k,r)*Wo;
                CHECK_Pkr_AC=CHECK_Pkr_AC+P_efficiency*n{t}(i,k,r)*P_AC{t}(i,k,r);
                CHECK_PHE=CHECK_PHE+H_efficiency*E_Ratio{t}(i,k,r)*n{t}(i,k,r)*((P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r)+Interference);
                CHECK_PHEtotal(t)=CHECK_PHEtotal(t)+H_efficiency*E_Ratio{t}(i,k,r)*n{t}(i,k,r)*((P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r)+Interference);
                CHECK_AC(t)=CHECK_AC(t)+P_efficiency*n{t}(i,k,r)*P_AC{t}(i,k,r);
                CHECK_HE(t)=CHECK_HE(t)+P_efficiency*n{t}(i,k,r)*P_HE{t}(i,k,r);
                CHECK_Ratio(t)=CHECK_Ratio(t)+n{t}(i,k,r)*I_Ratio{t}(i,k,r);
                CHECK_Count(t)=CHECK_Count(t)+n{t}(i,k,r);
                WPF_temp=WPF_temp+H_efficiency*E_Ratio{t}(i,k,r)*(n{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r)+n{t}(i,k,r)*Interference);
                POWER_temp(t)=POWER_temp(t)+n{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r));
                temp=temp+n{t}(i,k,r)*(I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc);
                count2=count2+n{t}(i,k,r);
           end
        end
   end
   Average_Ratio(t)=CHECK_Ratio(t)/CHECK_Count(t);
end
CHECK_EE(index_loop2)=CHECK_Capacity/(CHECK_PC_smallcell+CHECK_Pkr_AC+CHECK_PC_UE-CHECK_PHE);
EE=CHECK_EE(index_loop2);
SINR_next=temp/count2;
flag=true;
for t=1:T
    if (Capacity_temp-R_min<0)||(P_UE-WPF_temp<0)||(WPF_temp-P_Require<0)||(E_B-sum(Harvesting_energy(1:t))+CHECK_HE(t)/3<0)||(P_max-POWER_temp(t)/3<0)
        flag=false;
    end
end
CHECK_AC=CHECK_AC/P_efficiency/num_pico;
CHECK_HE=CHECK_HE/P_efficiency/num_pico;

end

