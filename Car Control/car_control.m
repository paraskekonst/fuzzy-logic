clear
fzc=readfis('flc_v2.fis');
%initialize 
x(1)=4;       
y(1)=0.4;
z(1)=0; %empodio
theta=-90; %dieuthinsi taxititas
dt=0.1;    %
u=0.05;     %taxitita
i=1;

while(x(i)<10)
   %upologismos dV kai dimiourgia emp?diou
    if(x(i)<=5)
        dV=min(1,y(i));
        z(i)=0;
    elseif(x(i)<=6)
        dV=min(1,y(i)-1);
        z(i)=1;
    elseif(x(i)<=7)
        dV=min(1,y(i)-2);
        z(i)=2;
    else
        dV=min(1,y(i)-3);
        z(i)=3;
    end
    

    
    %upologismos dH
    if(y(i)<=1)
        dH=min(1,5-x(i));
    elseif(y(i)<=2)
        dH=min(1,6-x(i));
    elseif(y(i)<=3)
        dH=min(1,7-x(i));
    else
        dH=1;
    end
    
    
       
    dtheta= evalfis([dV dH theta],fzc);
    theta=theta+dtheta;
    
    uy = u*sind(theta);
	ux = u*cosd(theta);
	
	
    %upologismos neas thesis 
    y(i+1) = uy*dt + y(i);
    
	if abs(theta)<90
		x(i+1) = ux*dt + x(i);
	else
		x(i+1) = ux*dt - x(i);
	end
	
	i=i+1;
end
x(i)
y(i)
z(i)=3;
figure(1);
plot(x, y ,x ,z );
grid on;
saveas(gcf,'t90_2.jpg');
