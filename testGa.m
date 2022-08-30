% ≤‚ ‘gaÀ„∑®
clear; clc;

A = []; b = [];
Aeq = []; beq = [];
lb = [0.1, 0.1, 0.1];
ub = [];


[x, fval] = ga(@myfunSum, 3, A, b, Aeq, beq, lb, ub, @nonmyfun);