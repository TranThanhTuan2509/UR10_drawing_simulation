function [ G ] = UR10trans()
%Creat The Arm  Using Peter Corke robotics toolbox
    a = [0, -0.612, -0.5723, 0, 0, 0];
    d = [0.1273, 0, 0, 0.163941, 0.1157, 0.0922];
    alpha = [1.570796327, 0, 0, 1.570796327, -1.570796327, 0];
    offset= [0, -pi/2, 0,-pi/2, 0, 0];
    for i= 1:6
        L(i) = Link([ 0 d(i) a(i) alpha(i) 0 offset(i)], 'standard');    
    end
    G = SerialLink(L,'name','RUn'); 
end


