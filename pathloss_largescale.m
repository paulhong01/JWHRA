function [d result]=pathloss_largescale(eNB,pico,mobile)
%% PATHLOSS_LARGESCALE Summary of this function goes here
%  This function sets up large scale fading
param;
h=20;
W=20;
result = mobile;
cc_freq_tmp = cc_freq/1e9; 
%% outdoor smallCell
for t=1:T
    if num_pico>0
    result.LOS_smallCell{t} = zeros(result.amount(t),length(pico.location));
    result.LOS_prob_smallCell{t} = 0.5-min(0.5,5*exp(-156./result.distance_smallCell{t})) + min(0.5,5*exp( -result.distance_smallCell{t}/30));
    r = rand(result.amount(t),length(pico.location));
    result.LOS_smallCell{t}(r < result.LOS_prob_smallCell{t}) = true ;
    result.LOS_smallCell{t}(r >= result.LOS_prob_smallCell{t}) = false;
    result.shadowing_LOS_smallCell = 3;
    result.shadowing_NLOS_smallCell = 4;
    result.pathloss_smallCell{t} = zeros(result.amount(t),length(pico.location));
    d{t} = result.distance_smallCell{t};
    LoS = result.LOS_smallCell{t};
    for a=1:result.amount(t)
        result.pathloss_smallCell{t}(a,LoS(a,:)==1) = 22.0*log10(d{t}(a,LoS(a,:)==1)) + 28.0 + 20*log10(cc_freq_tmp(1)) + result.shadowing_LOS_smallCell;
        result.pathloss_smallCell{t}(a,LoS(a,:)==0) = 36.7*log10(d{t}(a,LoS(a,:)==0)) + 22.7 + 26*log10(cc_freq_tmp(1)) + result.shadowing_NLOS_smallCell;
    end

    result.pathloss_smallCell{t} = result.pathloss_smallCell{t} + pene_loss;
    result.pathloss_smallCell{t}=10.^(-result.pathloss_smallCell{t}./10);
    result.pathloss_smallCell{t}=10.^-((20*log10(mobile.distance_smallCell{t})+20*log10(cc_freq)-147.55)./20);
    end
end

end

