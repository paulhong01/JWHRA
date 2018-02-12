function mobiles=ue_generator(base,pico,V,UE_flag)
%% UE_GENERATOR Summary of this function goes here
%   This function generates user equipments with random distributed near
%   small cells
param;
rand('state',sum(100*clock));   
location = [];

%% UE number initialize
if (UE_flag==1)
    N=num_pico*randi(UE_max,1,T);
else
    N=[6 6 12 12 6];
end

%% Initialzie
mobiles.location=cell(T,1);
mobiles.direction=cell(T,1);;
mobiles.velocity=V;
mobiles.shadowing = [];
mobiles.distance=[];
mobiles.pathloss=[];
mobiles.angle=[];
mobiles.amount=N;
mobiles.SIR=[];
mobiles.nRx = 2;
mobiles.nfft = 1024;


for t=1:T
    location=0;
    for c=1:N(t)
        b=1;
        while(b==1)
           x = real(pico.location(ceil(c/(N(t)/num_pico))))+10*(rand(1,1)*2-1);
           y = imag(pico.location(ceil(c/(N(t)/num_pico))))+10*(rand(1,1)*2-1);   % 25 m
           loc = (x) + 1i*(y);
           if ((sum(abs(loc-location)<=5)==0)||(c==1))&&abs(loc)<=radius*sqrt(3)/2  %%40m  %% 10
                location(c) = loc;
                b=0;
           end
        end
    end

    rand('state',sum(rand*111*clock));
    direction=2*pi*rand(1,N(t));

    mobiles.location{t}=location;
    mobiles.direction{t}=direction;
    mobiles.velocity(t)=V;
end

end