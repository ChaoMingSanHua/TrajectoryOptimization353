function [c, ceq] = nonmyfun(x)
t1 = x(1); t2 = x(2); t3 = x(3); D = 0;
x0 = 0; x1 = 113.0098 * pi/180; x2 = 110.4723 * pi/180; x3 = 102.1321 * pi/180;

vmax = 1;

H = Aa(t1, t2, t3, x0, x1, x2, x3, D);
a1 = H(1:4);
a2 = H(5:10);
a3 = H(11:14);
deltaT = 0.01;
tt = 0:deltaT:t1 + t2 + t3;
pp = [];
vv = [];
aa = [];
jj = [];
f = 0;
for i = 1:length(tt)
    t = tt(i);
    if t < t1
        p = a1(1) * t^3 + a1(2) * t^2 + a1(3) * t + a1(4);
        v = 3 * a1(1) * t^2 + 2 * a1(2) * t + a1(3);
        a = 6 * a1(1) * t + 2 * a1(2);
        j = 6 * a1(1);
        f = f + j^2 * deltaT;
    elseif t < t1 + t2
        p = a2(1) * (t - t1)^5 + a2(2) * (t - t1)^4 + a2(3) * (t - t1)^3 + a2(4) * (t - t1)^2 + a2(5) * (t - t1) + a2(6);
        v = 5 * a2(1) * (t - t1)^4 + 4 * a2(2) * (t - t1)^3 + 3 * a2(3) * (t - t1)^2 + 2 * a2(4) * (t - t1) + a2(5);
        a = 20 * a2(1) * (t - t1)^3 + 12 * a2(2) * (t - t1)^2 + 6 * a2(3) * (t - t1) + 2 * a2(4);
        j = 60 * a2(1) * (t - t1)^2 + 24 * a2(2) * (t - t1) + 6 * a2(3);
        f = f + j^2 * deltaT;
    elseif t < t1 + t2 + t3
        p = a3(1) * (t - t1 - t2)^3 + a3(2) * (t - t1 - t2)^2 + a3(3) * (t - t1 - t2) + a3(4);
        v = 3 * a3(1) * (t - t1 - t2)^2 + 2 * a3(2) * (t - t1 - t2) + a3(3);
        a = 6 * a3(1) * (t - t1 - t2) + 2 * a3(2);
        j = 6 * a3(1);
        f = f + j^2 * deltaT;
    else
        p = x3;
        v = 0;
        a = 0;
        j = 0;
        f = f + j^2 * deltaT;
    end
    
    pp = [pp; p];
    vv = [vv; v];
    aa = [aa; a];
    jj = [jj; j];
end

c = max(abs(vv)) - vmax;
ceq = [];