% Program for Inverse Kinematics on a 2 DOF Robotic Manipulator

% Input Start 

% Link Lengths
L1 = 5;
L2 = 5;

% Final End Effector Position

% Letter "I"

x1 = linspace(3,1,10);
x2 = linspace(1,2,10);
x3 = linspace(2, 2, 10);
x4 = linspace(2,1, 10);
x5 = linspace(1,3,10);
y1 = linspace(3,3,10);
y2 = linspace(3, 3, 10);
y3 = linspace(3,1,10);
y4 = linspace(1,1,10);
y5 = linspace(1,1,10);
% Letter R
x6= linspace(4,4,10);
y6 = linspace(1,3.1,10);
T_tag = linspace(pi/4.9, 3*pi/4.9, 10);
x7= (1*cos(2.45*T_tag)-4);
y7 = T_tag-3.8;
x8= linspace(4,5,10);
y8= linspace(2,1,10);


% Letter "C"

Theta_Traj = linspace(-pi/2, pi/2, 10);
x9 = (1*cos(Theta_Traj)-7);
y9 = (1*sin(Theta_Traj)-2);

Final_Y = horzcat(y1, y2, y3, y4, y5,y6,y7,y8,y9);
Final_X = horzcat(x1, x2, x3, x4, x5,x6,x7,x8,x9 );

% Input End

% Arrays that will stor End Effector Positions
X_Arr = [];
Y_Arr = [];

% Desired End Effector Position Beyond Workspace Start

for k = 1 : length(Final_X)

    Final_x = Final_X(k);
    Final_y = Final_Y(k);

    % Maximum Extened Arm Length
    Arm_Radius = L1 + L2;
    
    % Arm Length Differnece 
    Arm_Diff = abs(L1 - L2);
    
    % End Effector Distance from Origin
    D = sqrt((Final_y.*Final_y) + (Final_x.*Final_x));
    
    % Outer Workspace Boundary
    if (D > Arm_Radius)
        Final_x = (Arm_Radius)*(Final_x)/(D);
        Final_y = (Arm_Radius)*(Final_y)/(D);
    end
    
    % Inner Workspace Boundary
    if(D < Arm_Diff)
        Final_x = (Arm_Diff)*(Final_x)/(D);
        Final_y = (Arm_Diff)*(Final_y)/(D);
    end
    
    % Desired End Effector Position Beyond Workspace End
    
    % Plotting the Workspace Start
    
    Theta_Circle = 0:pi/50:2*pi;
    
    % Plotting the Outer Workspace Boundaries
    X_outer_WS = (Arm_Radius*cos(Theta_Circle));
    Y_outer_WS = (Arm_Radius*sin(Theta_Circle));
    
    % Plotting the Inner Workspace Boundaries
    X_inner_WS = (Arm_Diff*cos(Theta_Circle));
    Y_inner_WS = (Arm_Diff*sin(Theta_Circle));
    
    % Plotting the Workspace End
    
    % Inverse Kinematics Calculation Start
    
    % End Effector State (R, Theta)
    R = sqrt((Final_y.*Final_y) + (Final_x.*Final_x));
    Theta = atan2(Final_y, (Final_x + 0.000001));
    % 0.000001 is added to avoid Undefined Cartesian Points
    
    % Intermediate Angles
    Beta = acos(((L1*L1) + (L2*L2) - (R.*R))/(2*L1*L2));
    Alpha = acos(((L1*L1) + (R.*R) - (L2*L2))/(2*L1.*R));
    
    
    % 2nd Quadrant End Effector Position
    if (Final_x < 0)
    
        Theta = Theta + pi;
        Beta = (1)*Beta;
        Alpha = (1)*Alpha;
    
    end
    
    
    % Final Joint Angles in Radians
    
    % Elbow UP Configuration
    Final_Angle_1 = (Theta + Alpha);
    Final_Angle_2 = (Beta - pi);
    
    % Elbow DOWN Configuration
    % Final_Angle_1 = (Theta - Alpha);
    % Final_Angle_2 = pi - Beta;
    
    % Final Joint Angles in Degrees
    Final_Angle_1 = Final_Angle_1*(180/pi);
    Final_Angle_2 = Final_Angle_2*(180/pi);
    
    % Inverse Kinematics Calculation End
    
    % Angle with the Horizontal (Degrees)
    A1 = linspace(0, (Final_Angle_1), 30);
    A2 = linspace(0, (Final_Angle_2), 30);
    
    % Forward Kinematics:
    
    % Counter and Loop Initialization
    counter = 1;
    
    for i = 1 : length(A1)
    
        Theta_1 = A1(i);
        Theta_2 = A2(i);
        
        % Coordinates:
    
        % Initial points of Link 1
        X0 = 0;
        Y0 = 0;
    
        % Final points of Link 1 
        X1 = L1*cosd(Theta_1);
        Y1 = L1*sind(Theta_1);
        
        % Final points of Link 2
        X2 = X1 + L2*cosd(Theta_1 + Theta_2);
        Y2 = Y1 + L2*sind(Theta_1 + Theta_2);

        % Storing End Effector POsitions to Plot Trajectory
        X_Arr(k) = X2;
        Y_Arr(k) = Y2;
        
        % Storing Initial End Effector Coordinates for Plotting Trajectory
        if (counter == 1)
            
            Eef_X_init = X2;
            Eef_Y_init = Y2;
    
        end
        
        
    end

    % Assigning the Parameters
    txt1 = ['T1 = ', num2str(Theta_1), ' Deg'];
    txt2 = ['T2 = ', num2str(Theta_2), ' Deg'];
    txtend = ['X2 = ', num2str(X2), ', ', 'Y2 = ', num2str(Y2)];

    % Plot
    plot([X0 X1], [Y0 Y1], 'k', [X1 X2], [Y1 Y2], 'k','linewidth', 3)

    hold on

    plot(X0, Y0, '.k', 'MarkerSize', 30)
    plot(X1, Y1, '.k', 'MarkerSize', 30)
    plot(X2, Y2, '.k', 'MarkerSize', 30)
    
    % Plots Trajectory
    plot(X_Arr, Y_Arr, '.b', 'MarkerSize', 5)

    plot(X_inner_WS, Y_inner_WS);
    plot(X_outer_WS, Y_outer_WS);

    % Plots Workspace
    fill([X_inner_WS flip(X_outer_WS)],[Y_inner_WS flip(Y_outer_WS)],'k')

    hold off
    
    % Increases Transparency of Workspace
    alpha(0.1)

    xlabel('X-Axis (m)')
    ylabel('Y-Axis (m)')
    title('Cartesian Path Planning');
    text(X0, Y0, txt1, 'VerticalAlignment', 'top')
    text(X1, Y1, txt2, 'VerticalAlignment', 'top')
    text(X2, Y2, txtend, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom')
    text(0.5*(X0 + X1), 0.5*(Y0 + Y1), '  Link 1')
    text(0.5*(X1 + X2), 0.5*(Y1 + Y2), '  Link 2')
    grid on

    axis([-10 10 -10 10])

    M(counter) = getframe(gcf);
    counter = counter + 1;

end
