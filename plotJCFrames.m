function [frames, arm] = plotJCFrames(names_JC, JC_org)
%PLOTJCFRAMES Summary of this function goes here
%   Detailed explanation goes here
    
    % Initial orientation of joint coordinate frames
    figure('un','n','nam','Basic movements for human right shoulder',...
        'color','w','pos',[.1 .1 .8 .8])
    axes('pos',[0 .05 0.9 1]);
    rotate3d;
    cla;
    hold on;
    view(3);
    
    frames = cell(length(names_JC), 4);
    for jc_idx = 1:length(names_JC)
        frame = plotFrame(JC_org(jc_idx,:), names_JC(jc_idx));
        if jc_idx == 5
            pt_1 = JC_org(4,:);
            pt_2 = JC_org(5,:);
            
            arm = line([pt_1(1), pt_2(1)], [pt_1(2), pt_2(2)],...
                [pt_1(3), pt_2(3)], 'color', 'k', 'linewidth', 3.5);          
        end
        
        frames(jc_idx, :) = rotateFrame(frame, 'x', 90, JC_org(jc_idx,:));
    end
    
    axis([-25,20,-25,20,-25,20]);
    hold off;
    axis off;
    
end