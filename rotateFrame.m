function frame = rotateFrame(frame, axis, angle, rot_org)
%ROTATEFRAME Summary of this function goes here
%   Detailed explanation goes here

    lx = frame{1}; ly = frame{2}; lz = frame{3}; JC_name = frame{4};
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
    rotate([lx,ly,lz,JC_name], dir, angle, rot_org');
    
    frame = {lx, ly, lz, JC_name};

end

