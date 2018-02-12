function pico=sc_generator(base)   
%% SC_GENERATOR Summary of this function goes here
%   This function generates small cells in considered area.
param;

rand('state',sum(100*clock));    
location = [];

for c=1:num_pico
    b=1;
    while(b==1)
       x = pico_centerx+40*(rand(1,1)*2-1);
       y = pico_centery+40*(rand(1,1)*2-1);
       loc = (x) + 1i*(y);
       if ((sum(abs(loc-location)<=40)==0)||(c==1))&&abs(loc)<=radius*sqrt(3)/2  
            location(c) = loc;
            b=0;
        end
    end
end
rand('state',sum(rand*111*clock));
pico.location=location;

alpha=0:pi/20:2*pi;
R=35;
x=R*cos(alpha);
y=R*sin(alpha);

end