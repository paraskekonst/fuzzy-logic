
clear
sys = tf([25 25*0.3], [1 10.1 1 0]);
rlocus(sys);

axis([-0.6 0 -1 1]);
a=feedback( 1.2*sys, 1, -1);
step( a);
