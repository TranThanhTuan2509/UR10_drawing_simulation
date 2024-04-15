clear all; clc;
%% Add path
addpath('..');
addpath('../VrepConnection','../MFuncs/Robotics_Functions', '../MFuncs/Vrep_Functions', '../MFuncs/Ur10');
vrep = remApi('remoteApi');
vrep.simxFinish(-1);
id = vrep.simxStart('127.0.0.1',19997,true,true,5000,5);

if (id < 0)
    disp('Failed to connect to remote API server.');
    vrep.delete();
    return;
end

fprintf('Connection %d to remote API server open.\n', id);

%% Get object handles
handles = struct('id', id);

[~,dum]= vrep.simxGetObjectHandle(id,'UR10_target',vrep.simx_opmode_blocking);

%%% For the UR10 joints
jointNames = {'UR10_joint1', 'UR10_joint2', 'UR10_joint3', 'UR10_joint4', 'UR10_joint5', 'UR10_joint6'}; 
handles.ur10Joints = -ones(1,6);

for i = 1:6
    [res, handles.ur10Joints(i)] = vrep.simxGetObjectHandle(id, jointNames{i}, vrep.simx_opmode_oneshot_wait);
    vrchk(vrep, res);
end

%% For the table
handles.Table = -ones(1, 1);
[res, handles.Table] = vrep.simxGetObjectHandle(id, 'customizableTable', vrep.simx_opmode_oneshot_wait);
vrchk(vrep, res);

%% For the waypoints

% Waypoints for letter A
handles.A_wayPoints = -ones(1, 8);
A_WayPointsName = {'ctrlPt8', 'ctrlPt24', 'ctrlPt9', 'ctrlPt10', 'ctrlPt11', 'ctrlPt12', 'ctrlPt13', 'ctrlPt14'};
for i = 1:length(A_WayPointsName)
   [res, handles.A_wayPoints(i)] = vrep.simxGetObjectHandle(id, A_WayPointsName{i}, vrep.simx_opmode_oneshot_wait);
   vrchk(vrep, res);
end

% way points for letter U
handles.U_wayPoints = -ones(1, 9);
U_WayPointsName = {'ctrlPt', 'ctrlPt0', 'ctrlPt1',...
    'ctrlPt2', 'ctrlPt3', 'ctrlPt4',...
    'ctrlPt5', 'ctrlPt6', 'ctrlPt7'};
for i = 1:length(U_WayPointsName)
    [res, handles.U_wayPoints(i)] = vrep.simxGetObjectHandle(id, U_WayPointsName{i}, vrep.simx_opmode_oneshot_wait);
    vrchk(vrep, res);
end

% way points for letter E
handles.E_wayPoints = -ones(1, 14);
E_WayPointsName = {'ctrlPt#0', 'ctrlPt0#0', 'ctrlPt1#0', 'ctrlPt2#0', 'ctrlPt3#0', 'ctrlPt4#0', ...
    'ctrlPt5#0', 'ctrlPt6#0', 'ctrlPt7#0', 'ctrlPt7#2', 'ctrlPt7#3', 'ctrlPt7#4', 'ctrlPt7#5', ...
    'ctrlPt7#6'};
for i = 1:length(E_WayPointsName)
    [res, handles.E_wayPoints(i)] = vrep.simxGetObjectHandle(id, E_WayPointsName{i}, ...
        vrep.simx_opmode_oneshot_wait);
    vrchk(vrep, res);
end

% way points for letter D
handles.D_wayPoints = -ones(1, 7);
D_WayPointsName = {'ctrlPt#1', 'ctrlPt0#1', 'ctrlPt1#1', 'ctrlPt2#1', 'ctrlPt3#1', 'ctrlPt4#1', ...
    'ctrlPt5#1'};
for i = 1:length(D_WayPointsName)
    [res, handles.D_wayPoints(i)] = vrep.simxGetObjectHandle(id, D_WayPointsName{i}, ...
        vrep.simx_opmode_oneshot_wait);
    vrchk(vrep, res);
end

% Waypoints for letter Q
handles.Q_wayPoints = -ones(1, 10);
Q_WayPointsName = {'ctrlPt15', 'ctrlPt16', 'ctrlPt17', 'ctrlPt25' , 'ctrlPt18', 'ctrlPt19', 'ctrlPt20', 'ctrlPt21', 'ctrlPt22', 'ctrlPt23'};
for i = 1:length(Q_WayPointsName)
   [res, handles.Q_wayPoints(i)] = vrep.simxGetObjectHandle(id, Q_WayPointsName{i}, vrep.simx_opmode_oneshot_wait);
   vrchk(vrep, res);
end
%%% For the Ref and pen
  % Those Handle Not Used in the Simulation 
handles.ur10Ref = -1;
handles.ur10Pen = -1;
[res, handles.ur10Ref] = vrep.simxGetObjectHandle(id, 'UR10', ...
    vrep.simx_opmode_oneshot_wait); 
vrchk(vrep, res);

[res, handles.ur10Pen] = vrep.simxGetObjectHandle(id, 'feltPen_tip', ...
    vrep.simx_opmode_oneshot_wait);
vrchk(vrep, res);

%%% For the Base frame [Frame2]
handles.base = -1;
[res, handles.base] = vrep.simxGetObjectHandle(id, ...
    'Frame2', vrep.simx_opmode_oneshot_wait);
vrchk(vrep, res);
%%% For the Target frame [Frame3]
handles.Target = -1;
[res, handles.Target] = vrep.simxGetObjectHandle(id, ...
    'Frame3', vrep.simx_opmode_oneshot_wait);
vrchk(vrep, res);


%%% Waypoints [position/orientation]
relativToRef = handles.base;

% Letter A
for i = 1:length(A_WayPointsName)
    res = vrep.simxGetObjectPosition(id, handles.A_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);
    res = vrep.simxGetObjectOrientation(id, handles.A_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);  
end

% Letter U
for i = 1:length(U_WayPointsName)
    res = vrep.simxGetObjectPosition(id, handles.U_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);
    res = vrep.simxGetObjectOrientation(id, handles.U_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);  
end

% Letter E
for i = 1:length(E_WayPointsName)
    res = vrep.simxGetObjectPosition(id, handles.E_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);
    res = vrep.simxGetObjectOrientation(id, handles.E_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);  
end

% Letter D
for i = 1:length(D_WayPointsName)
    res = vrep.simxGetObjectPosition(id, handles.D_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);
    res = vrep.simxGetObjectOrientation(id, handles.D_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);  
end

% Letter Q
for i = 1:length(Q_WayPointsName)
    res = vrep.simxGetObjectPosition(id, handles.Q_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);
    res = vrep.simxGetObjectOrientation(id, handles.Q_wayPoints(i), relativToRef,...
               vrep.simx_opmode_streaming);
    vrchk(vrep, res, true);  
end
% Assuming you have already defined 'relativToRef' variable

%%% Pen  
  res = vrep.simxGetJointPosition(id,handles.ur10Pen,...
             vrep.simx_opmode_streaming); 
  vrchk(vrep, res, true);

%%%% The UR10 Joints position
for i = 1:6
    res = vrep.simxGetJointPosition(id, handles.ur10Joints(i),...
               vrep.simx_opmode_streaming); 
    vrchk(vrep, res, true);
end

%% Start
% to make sure that streaming data has reached to client at least once
vrep.simxGetPingTime(id);
vrep.simxStartSimulation(id, vrep.simx_opmode_oneshot_wait);

%% Simulation

% Set the threshold to check if the end effector has reached its destination
handles.threshold = 1;
%Set The Arm Parameters Using Peter Corke robotics toolbox
handles.ur10Robot= UR10trans();
pause(0.5);
%Rest Joint for 1st time
handles.startingJoints = [0, 0, 0, 0, 0, 0];
res = vrep.simxPauseCommunication(id, true);
vrchk(vrep, res);
for j = 1:6
    vrep.simxSetJointTargetPosition(id, handles.ur10Joints(j),...
    handles.startingJoints(j),vrep.simx_opmode_oneshot);
    vrchk(vrep, res);
end
res = vrep.simxPauseCommunication(id, false);
vrchk(vrep, res);
pause(1);

ConstValue=0.135;

XYZoffset=[0 0 ConstValue];

%Draw letter A
for i = 1:length(A_WayPointsName)
    Go(id, vrep, handles, 'A', i, XYZoffset);
    pause(0.25);
end
pause(1);
ResetJoint(id, vrep, handles, res);
pause(1);

% Draw letter U
for i = 1:length(U_WayPointsName)
    Go(id, vrep, handles, 'U', i, XYZoffset);
    pause(0.25);
end
pause(1);
ResetJoint(id, vrep, handles, res);
pause(1);

% Draw letter E
for i = 1:length(E_WayPointsName)
    Go(id, vrep, handles, 'E', i, XYZoffset);
    pause(0.25);
end
pause(1);
ResetJoint(id, vrep, handles, res);
pause(1);

% Draw letter D
for i = 1:length(D_WayPointsName)
    Go(id, vrep, handles, 'D', i, XYZoffset);
    pause(0.25);
end
pause(1);
ResetJoint(id, vrep, handles, res);
pause(1);

%Draw letter Q
for i = 1:length(Q_WayPointsName)
    Go(id, vrep, handles, 'Q', i, XYZoffset);
    pause(0.25);
end
pause(1);
ResetJoint(id, vrep, handles, res);
pause(1);

disp('finished');


%% END
%clear; clc;
vrep.delete();
