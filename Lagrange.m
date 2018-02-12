function [P_AC P_HE I_Ratio E_Ratio n M_alpha M_pi M_sita M_beta M_gamma M_landa] = Lagrange(UE,a,b,EE,M_alpha,M_delta,M_w,M_pi,M_sita,P_AC,P_HE,n,M_beta,M_gamma,M_landa,U_alpha,U_beta,U_gamma,U_delta,U_landa,U_pi,U_sita)
%% LAGRANGE Summary of this function goes here
%   This function finds resouce allocation solutions in each iterations.
param;

% Re-initialize resouce block
for t=1:T
    n{t}=zeros(num_pico,UE.amount(t),num_RBs);
end

for t=1:T
    for i=1:num_pico
        for k=1:UE.amount(t)
            for r=1:num_RBs
                temp=P_AC{t}(i,k,r);  
                P_AC{t}(i,k,r)=max((a*Wo*(1+M_alpha{t}(i,k)))/(log(2)*(EE*P_efficiency-EE*UE.channel_gain{t}(k,i,r)*H_efficiency+M_landa(t,i)+M_pi{t}(i,k)*UE.channel_gain{t}(k,i,r)-M_sita{t}(i,k)*UE.channel_gain{t}(k,i,r)))-P_HE{t}(i,k,r),10^-9);
                P_HE{t}(i,k,r)=max((a*Wo*(1+M_alpha{t}(i,k)))/(log(2)*(sum(M_gamma(t:T,i)*P_efficiency)-sum(M_beta(t:T,i)*P_efficiency)+M_landa(t,i)+(M_pi{t}(i,k)-EE*H_efficiency-M_sita{t}(i,k))*UE.channel_gain{t}(k,i,r)))-P_AC{t}(i,k,r),10^-9);
                I_Ratio{t}(i,k,r)=min(max((-N_proc+sqrt(N_proc^2+4*Interference/log(2)/M_delta{t}(i,k,r)*(1+M_alpha{t}(i,k))*a*Wo*N_proc))/(2*Interference),0),1);
                E_Ratio{t}(i,k,r)=1-I_Ratio{t}(i,k,r);
                temp_RB(k,r)=a*Wo*(1+M_alpha{t}(i,k))*(log2((I_Ratio{t}(i,k,r)*(P_AC{t}(i,k,r)+P_HE{t}(i,k,r))*UE.channel_gain{t}(k,i,r))/(I_Ratio{t}(i,k,r)*Interference+N_proc))-1/log(2)-N_proc/(log(2)*(I_Ratio{t}(i,k,r)*Interference+N_proc)))+M_delta{t}(i,k,r)+b*Wo+M_alpha{t}(i,k)*b*Wo;
            end
        end
        temp=temp_RB(((i-1)*UE.amount(t)/num_pico+1):(i)*UE.amount(t)/num_pico,:);
        % RB allocation       
        clear I1_RB; clear trash;
        for index_RB=1:num_RBs
            [trash(:,index_RB) I1_RB(:,index_RB)]=sort(temp(:,index_RB),'descend');
            n{t}(i,(i-1)*UE.amount(t)/num_pico+I1_RB(1,index_RB),index_RB)=1;
        end
        clear I_RB; clear trash;
        for index_RB=1:UE.amount(t)/num_pico
            [trash(index_RB,:) I_RB(index_RB,:)]=sort(temp(index_RB,:),'descend');
            flag=0;
            for index_RB2=1:num_RBs
                    if (n{t}(i,(i-1)*UE.amount(t)/num_pico+index_RB,index_RB2)==1)
                        flag=1;
                    end
            end
            if flag==0
               for index_RB3=1:UE.amount(t)/num_pico
                  n{t}(i,(i-1)*UE.amount(t)/num_pico+index_RB3,I_RB(index_RB,1))=0;
               end
               n{t}(i,(i-1)*UE.amount(t)/num_pico+index_RB,I_RB(index_RB,1))=1;
            end
        end

    end
end


end

