function Go(id, vrep, handles, letter, iwayPoint, XYZoffset)
    relativToRef = handles.base;    
    switch(letter)
        case 'Q'
            [res , TargPos] = vrep.simxGetObjectPosition(id, handles.Q_wayPoints(iwayPoint), ...
                          relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
            [res , Targtheta] = vrep.simxGetObjectOrientation(id,handles.Q_wayPoints(iwayPoint), ...
                           relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
        case 'A'
            [res , TargPos] = vrep.simxGetObjectPosition(id, handles.A_wayPoints(iwayPoint), ...
                          relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
            [res , Targtheta] = vrep.simxGetObjectOrientation(id,handles.A_wayPoints(iwayPoint), ...
                           relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
        case 'U'
            [res , TargPos] = vrep.simxGetObjectPosition(id, handles.U_wayPoints(iwayPoint), ...
                          relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
            [res , Targtheta] = vrep.simxGetObjectOrientation(id,handles.U_wayPoints(iwayPoint), ...
                           relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
        case 'E'
            [res , TargPos] = vrep.simxGetObjectPosition(id, handles.E_wayPoints(iwayPoint), ...
                          relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
        
            [res , Targtheta] = vrep.simxGetObjectOrientation(id,handles.E_wayPoints(iwayPoint), ...
                           relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
        case 'D'
            [res , TargPos] = vrep.simxGetObjectPosition(id, handles.D_wayPoints(iwayPoint), ...
                          relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res,true);
            [res , Targtheta] = vrep.simxGetObjectOrientation(id,handles.D_wayPoints(iwayPoint), ...
                           relativToRef,vrep.simx_opmode_buffer);
            vrchk(vrep, res, true);
    end
    
    %% Get the arm to be above the way points   
    %Calculate And make offset
    %Note that Targtheta is in radian not deg.   
    G=EulerZYX(Targtheta)*ROT('Z',pi/2)*ROT('X',pi);
    %G(1:3, 4)= TargPos + TotOffset; % XYZ
    G(1:3, 4) = TargPos + XYZoffset;
    G=double(G); 
    %Get Target Joint Value 
    q = handles.ur10Robot.ikunc(G); %1*6 vector
    %Move
    moveFrame(id, vrep, G, handles.Target, relativToRef); %move Target Frame
    
    MoveUR10Joints(id, vrep, handles, q); %Then move the Arm  
    
end


