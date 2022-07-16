clc
clear all
close all; clc; clear;
% Define position of arm
theta=0:10:360; %theta is spaced around a circle (0 to 360).
r=0.03; %The radius of our circle.
%Define a circular magenta patch.
x=r*cosd(theta) + 0.075;
y=r*sind(theta) + 1;
% Size figure and draw arms
figure('position', [800, 300, 600, 550]);
myShape2=patch(x,y,'m');
set(myShape2,'Xdata',x,'Ydata',y);
axis([-1.5 3 -1 3]); grid on;
T=0.5; %Delay between images
n = 1;
for theta = pi/2:-pi/90:0,
    if theta >= pi/4;
        theta = theta;
    else
        theta = pi/2 - theta;
    end
    Arot = [sin(theta) cos(theta); -cos(theta) sin(theta)];
    xyRot = Arot * [x; y]; % rotates the points by theta
    xyTrans = xyRot; % translates all points by 0.1
       set(myShape2,'Xdata',(x+xyTrans(1, :)),'Ydata',(y+xyTrans(2, :)));
     t =  text((x(1)+xyTrans(1, n)),(y(1)+xyTrans(2, n)),num2str([(x(1)+xyTrans(1, n)) (y(1)+xyTrans(2, n)) ]),'FontSize',12)
      pause(T); %Wait T seconds
      delete(t)
      n = n+1;
  end