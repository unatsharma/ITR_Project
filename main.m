close all;

%% ORIGINAL POSITIONS OF JOINT COORDINATE FRAMES
% Global constants;
global JC_org names_JC names_Moves frames arm;

% Position of joint coordinate frames
JC_org = zeros(5,4);
JC_org(1,:) = [0, 0, 0, 0];
JC_org(2,:) = [0, 0, -1, 0];
JC_org(3,:) = [0, -1, -1, 0];
JC_org(4,:) = [0, -4.5, -1, 0];
JC_org(5,:) = [0, -4.6, -19.2, 0];

% Names of JC frames
names_JC = ["thor", "clav", "scap", "hume", "fore"];
% Names of shoulder movements
names_Moves = ["Extension", "Flexion", "Abduction", "Adduction"];

% Plot JCs
[frames, arm] = plotJCFrames(names_JC, JC_org);

%% VARIOUS MOVEMENTS OF SHOULDER
createPushbuttons(names_Moves);




%% FUNCTIONS
function createPushbuttons(names_Moves)
    
    for mov_idx = 1:length(names_Moves)
        eval(['uicontrol(''style'', ''pushbutton'', ''units'', ''norm'','...
            '''pos'', [.01 ', num2str(mov_idx*.1/4), ' .1 .025], ''string'','...
            '''',char(names_Moves(mov_idx)),''','...
            '''callback'', @showMove)']);
        
    end
    
end

function showMove(varargin)
    global names_Moves;
    oj = findobj('type','uicontrol','style','pushbutton', 'Value', 1);
    
    switch(oj.String)
        case names_Moves(1)
            extension();
        case names_Moves(2)
            flexion();
        case names_Moves(3)
            abduction();
        case names_Moves(4)
            adduction();
    end
end

function flexion()
%SAGFLEXION Summary of this function goes here
%   Detailed explanation goes here
    global names_JC JC_org frames arm;
    o = JC_org(4,:);
    axis = 'z';
    hold on;
    
    angles = ones(1,18) * 10;
    for angle_idx = 1:length(angles)
        for jc_idx = 4:length(names_JC)
            rotateFrame(frames(jc_idx,:), axis,...
                angles(angle_idx), o);
        end
        rotateArm(arm, axis, angles(angle_idx), o); 
        pause(0.5);
    end
end

function extension()
%SAGFLEXION Summary of this function goes here
%   Detailed explanation goes here
    global names_JC JC_org frames arm;
    o = JC_org(4,:);
    axis = 'z';
    hold on;
    
    angles = -ones(1,18) * 10;
    for angle_idx = 1:length(angles)
        for jc_idx = 4:length(names_JC)
            rotateFrame(frames(jc_idx,:), axis,...
                angles(angle_idx), o);         
        end
        rotateArm(arm, axis, angles(angle_idx), o); 
        pause(0.5);
    end
end

function abduction()
%SAGFLEXION Summary of this function goes here
%   Detailed explanation goes here
    global names_JC JC_org frames arm;
    o = JC_org(4,:);
    axis = 'x';
    hold on;
    
    angles = -ones(1,9) * 10;
    for angle_idx = 1:length(angles)
        for jc_idx = 4:length(names_JC)
            rotateFrame(frames(jc_idx,:), axis,...
                angles(angle_idx), o);        
        end
        rotateArm(arm, axis, angles(angle_idx), o); 
        pause(0.5);
    end
end

function adduction()
%SAGFLEXION Summary of this function goes here
%   Detailed explanation goes here
    global names_JC JC_org frames arm;
    o = JC_org(4,:);
    axis = 'x';
    hold on;
    
    angles = ones(1,9) * 10;
    for angle_idx = 1:length(angles)
        for jc_idx = 4:length(names_JC)
            rotateFrame(frames(jc_idx,:), axis,...
                angles(angle_idx), o);        
        end
        rotateArm(arm, axis, angles(angle_idx), o);
        pause(0.5);
    end
end

function rotateArm(arm, axis, angle, o)
    global frames;
    
    lx = frames{4,1};
    ly = frames{4,2};
    lz = frames{4,3};
    
    switch(axis)
        case 'x'
            pxx=get(lx,'xdata');
            pyy=get(lx,'ydata');
            pzz=get(lx,'zdata');
        case 'y'
            pxx=get(ly,'xdata');
            pyy=get(ly,'ydata');
            pzz=get(ly,'zdata');
        case 'z'
            pxx=get(lz,'xdata');
            pyy=get(lz,'ydata');
            pzz=get(lz,'zdata');
    end

    dir = [pxx(2)-pxx(1), pyy(2)-pyy(1), pzz(2)-pzz(1)];
    dir(abs(dir) < 1e-10) = 0;
    rotate(arm, dir, angle, o');
end