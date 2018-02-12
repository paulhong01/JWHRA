function result=dist_angle_hexagon(base,heNB,mobile)
param;
location = [base.location];
for t=1:T
    
    for a=1:mobile.amount(t)
        for c=1:length(base.location)
            distance_macro{t}(a,c) = abs(mobile.location{t}(a)-location(c));
            vec{t}(a,c) = mobile.location{t}(a)-location(c);
        end
    end

    angle1{t}(:,:,1) = angle(vec{t});
    angle1{t}(:,:,2) = -((2/3)*pi-angle1{t}(:,:,1));
    angle1{t}(:,:,3) = (2/3)*pi+angle1{t}(:,:,1);

    angle1{t} = angle(exp(j*angle1{t}));
    angle1{t} = angle1{t}/pi*180;

    location = heNB.location;
    for a=1:mobile.amount(t)
        for c=1:num_pico
            distance_smallCell{t}(a,c) = abs(mobile.location{t}(a)-location(c));
        end
    end
 
end
result=mobile;
result.distance_macro=distance_macro;
result.distance_smallCell=distance_smallCell;
result.angle = angle1;
end