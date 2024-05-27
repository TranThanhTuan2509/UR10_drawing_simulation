# [UR10_DRAWING_SIMULATION]
# Introduction
- Hello guys, this is my Kinematics and Dynamics project for a mid-term assessment.
- As the head title, the robot (UR10) will be automated to draw letter and i chose 5 letters ( A U E D Q ).
- It still exists some deficiencies so please takes it as a reference.

![CoppeliaSim Edu - newscene - rendering_ 8 ms (8 06 fps) - SIMULATION STOPPED 2024-04-14 22-24-53](https://github.com/TranThanhTuan2509/UR10_drawing_simulation/assets/119112296/b07afa33-a6e6-4aa4-94e3-27c4d7346241)


# Requirements
- Robot toolbox
- Optimization toolbox and many other requirement-toolboxs you must download before working with matlab


# Setting
- In Main folder has main file for both handle's setting_coordinations and handle's positions (UR10, pen and drawing table):
![image](https://github.com/TranThanhTuan2509/UR10_drawing_simulation/assets/119112296/8f8d9102-a60c-40c1-9570-195a20058f19)

- In MFuncs, all computation-functions for robot moving. it includes Rotation matrix in both forward and Inverse, Translation matrix and Transpose matrix:

![Screenshot from 2024-04-15 09-53-31](https://github.com/TranThanhTuan2509/UR10_drawing_simulation/assets/119112296/80d0d1fd-3484-49b2-a3e1-973cd8eb4656)

![Screenshot from 2024-04-15 09-56-59](https://github.com/TranThanhTuan2509/UR10_drawing_simulation/assets/119112296/4f9a750d-9dc6-44f0-bde2-b3ff30ee90be)

![Screenshot from 2024-04-15 09-57-11](https://github.com/TranThanhTuan2509/UR10_drawing_simulation/assets/119112296/0cc744ee-2e14-45f7-a9c2-918dad729648)

- Next is Vrep_Functions in MFuncs folder, Go, GoAndCatch, ModeUR10joints....These files have a funtion that making robot catch the pen, letter_checking, and reset the robot joints after it's completely drawing any letters.
- In coppeliaSim you have to set letter-waypoints for each letter and make sure it's corresponding with waypoint-variables in matlab.
- Here is a picture of all letters' waypoints in coppeliaSim:
![image](https://github.com/TranThanhTuan2509/UR10_drawing_simulation/assets/119112296/3113c777-7a84-44d2-af2f-75e67f9ff3d7)
- Don't forget to connect coppeliaSim-API with matlab.

# Result
![image](https://github.com/TranThanhTuan2509/UR10_drawing_simulation/assets/119112296/64b40dea-0e49-42d9-b9da-2f7fb8017fa4)

- Ink is smeared while drawing the letter. take it as a reference .
- Thanks for reading my project.
