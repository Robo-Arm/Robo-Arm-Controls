vector = [-2,-1,-10];
vector = vector/norm(vector)
rx = -asin(vector(2));
ry = asin(vector(1)/cos(rx));

%ry = pi-asin(vector(1)/cos(rx));
check = cos(rx)*cos(ry)
vectorz = [0;0;norm(vector)];
if sign(check) ~= sign(vector(3))
    ry = pi-ry;
end
Rx = rotx(rx);
Ry = roty(ry);
Rz = rotz(30);
vxz = Ry*(Rx*vectorz)
% if vector(3)<0
%     vxz(3)=vxz(3)*-1;
% end
% vxz