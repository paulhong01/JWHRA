function result = harvesting_setup(flag)
%% HARVESTING_SETUP Summary of this function goes here
%   This function simulates green energy distributed with two modes (random
%   distributed and uniform distributed)
param;

if (flag)
    result=E_HE_max*rand(1,T);
else
    result=1.8*ones(1,T);

end

