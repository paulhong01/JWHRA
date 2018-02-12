function result = small_scale( mobile )
%SMALL_SCALE Summary of this function goes here
%   This function sets up Rayleigh fading.
param;

result=mobile;
for t=1:T
   temp=repmat(mobile.pathloss_smallCell{t},1,1,num_RBs);
   small_scale = sqrt(2)/2*randn(mobile.amount(t),num_pico,num_RBs)+1i*(sqrt(2)/2*randn(mobile.amount(t),num_pico,num_RBs));
   result.channel_gain{t}=temp.*abs(small_scale);
    
end

end

