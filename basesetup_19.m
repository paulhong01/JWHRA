function zz=basesetup_19(Radius)
% This Sub-code is used to setup the location of 19 base stations using secound_wrap_arround tech
%               also used to get the range of the whole map
%  zz=basesetup(Radius)
%    Radius is the coverage of one basel station  (meter)
%    zz.location is complex output
%    zz.vertex is a matrix composed with the 6 boundery vertex points 
%    zz.range is the range of map along one of the axis
%    zz.radius is the radius of the base station



K=0;  
N=6*sum([1:K])+1;
Base_step=sqrt(3)*Radius;
xx=[0];
yy=[0];
if K>0
    temp_k=1;
    for ii=1:(N-6*K)
        for jj=0:5
            exist=0;
            newx=xx(ii)+Base_step*cos(jj*pi/3);
            newy=yy(ii)+Base_step*sin(jj*pi/3);
                for iii=1:length(xx)
                    if abs(newx-xx(iii))<0.1    % precision problem! sin(pi)~=0 
                        if abs(newy-yy(iii))<0.1
                           exist=1;
                       end
                    end
                end
                if exist==0
                    xx=[xx,newx];
                    yy=[yy,newy];
                end

        end
    end
end

zz.location=xx+i*yy;

%setup the boundery vertex of the map
r=0.5*Base_step;
R=Radius;
zz.vertex=[(5*r-i*0.5*R) (3*r+i*3.5*R) (-2*r+i*4*R) (-5*r+i*0.5*R) (-3*r-i*3.5*R) (2*r-i*4*R) (5*r-i*0.5*R)];
zz.range=abs(zz.vertex(3)-zz.vertex(1))+0.2;  % +0.2 is to solve the matlab presision problems
zz.radius=Radius;
end