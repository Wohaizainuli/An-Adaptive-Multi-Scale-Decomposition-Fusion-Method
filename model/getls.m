function [le, sd]=getls(re, le, sd)
syms x y;
p00 =       1.923;
p10 =   -0.005692;
p01 =      -3.017;
p20 =   -0.002749;
p11 =     -0.1894;
p02 =       3.133;
p30 =   0.0001421;
p21 =     0.01981;
p12 =     0.07325;
p03 =      -1.571;
p31 =  -0.0007448;
p22 =   -0.004376;
p13 =    -0.01596;
p04 =      0.3796;
p32 =   0.0001299;
p23 =   0.0002381;
p14 =    0.001611;
p05 =    -0.03534;
equ = p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 + p30*x^3 + p21*x^2*y + ... 
          p12*x*y^2 + p03*y^3 + p31*x^3*y + p22*x^2*y^2 + p13*x*y^3 + ... 
          p04*y^4 + p32*x^3*y^2 + p23*x^2*y^3 + p14*x*y^4 + p05*y^5;
if isempty(re)
    error('The imput is wrong...');
end
if ~isempty(le) && ~isempty(sd)
    le = le;
    sd = sd;
    return;
end
if isempty(le) && ~isempty(sd)
    answ=solve(equ==re, y==sd);
    tmp=double(answ.x);
    sd=sd;
    rlo=length(tmp);
    for i=1:rlo
        tl=tmp(i);
        if isreal(tl) && 3<=tl && tl<=10
            le=[le,tl];
        end
    end
    return;
end
if isempty(sd) && ~isempty(le)
    answ=solve(equ==re, x==le);
    tmp=double(answ.y);
    le=le;
    rlo=length(tmp);
    for i=1:rlo
        tl=tmp(i);
        if isreal(tl) && 0.3<=tl && tl<=3.5
            sd=[sd,tl];
        end
    end
    return;
end
if isempty(le) && isempty(sd)
    for ll=10:-1:3
        answ=solve(equ==re,x==ll);
        tmp=double(answ.y);
        rlo=length(tmp);
        for i=1:rlo
            tl=tmp(i);
            if isreal(tl) && 0.3<=tl && tl<=3.5
                sd=[sd,tl];
                le=[le,ll];
            end
        end
    end
end
end