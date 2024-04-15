function ResetJoint(id, vrep, handles, res)
    for j = 1:6
        vrep.simxSetJointTargetPosition(id, handles.ur10Joints(j),...
        handles.startingJoints(j),vrep.simx_opmode_oneshot);
        vrchk(vrep, res);
    end
end