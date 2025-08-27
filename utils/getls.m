function [le, sd]=getls(re, le, sd)
syms x y;
equ=1.381-0.03642*x-0.8457*y+0.009868*x^2-0.3275*x*y...
    +0.7289*y^2-0.001403*x^3+0.046*x^2*y+0.06677*x*y^2-0.2304*y^3-...
    0.001823*x^3*y-0.005447*x^2*y^2-0.003789*x*y^3+0.02492*y^4;
if isempty(re)
    error('The imput is wrong...');
end
if ~isempty(le) && ~isempty(sd)
    le=le;
    sd=sd;
end
if isempty(le) && ~isempty(sd)
    answ=solve(equ==re,y==sd);
    tmp=double(answ.x);
    sd=sd;
    rlo=length(tmp);
    for i=1:rlo
        tl=tmp(i);
        if isreal(tl) && 1<=tl && tl<=6
            le=[le,tl];
        end
    end
end
if isempty(sd) && ~isempty(le)
    answ=solve(equ==re,x==le);
    tmp=double(answ.y);
    le=le;
    rlo=length(tmp);
    for i=1:rlo
        tl=tmp(i);
        if isreal(tl) && 0.1<=tl && tl<=3.5
            sd=[sd,tl];
        end
    end
end
if isempty(le) && isempty(sd)
    for ll=6:-1:1
        answ=solve(equ==re,x==ll);
        tmp=double(answ.y);
        rlo=length(tmp);
        for i=1:rlo
            tl=tmp(i);
            if isreal(tl) && 0.1<=tl && tl<=3.5
                sd=[sd,tl];
                le=[le,ll];
            end
        end
    end
end
end