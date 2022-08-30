%粒子群优化算法:
%主函数源程序
clc
clear all;
clc;
m = 20;      %初始化20个随机粒子
D = 3;   %维度，就是这里对三个参数进行寻优 
pgf(1) = 100;   %给定的最大的适应度值
Wmax = 0.9;
Wmin = 0.4;
cl = 2;
c2 = 2;
Nmax = 50 ;  %最大迭代次数

for i = 1:m
    for j = 1:D
        x(i,j) = rand * (4.0-0.1)+0.1;    % 首先随机生成20行3列的矩阵，也就是所谓的初始化种群
        v(i,j) = -2+4 * rand;  %初始化速度，为一个粒子有一个初始速度
    end
    px(i,:) = x(i,:);   %每个粒子最优位置
    pf(i) = fitness(x(i,1),x(i,2),x(i,3),D)   %每个粒子的最优位置的适应度
    if pgf(1) > pf(i)           
        pgx = x(i,: );          
        pgf(1) = pf(i);       
    end
end

for i = 1:m        
    a(:,i) = Aa(x(i,1),x(i,2) ,x(i,3));    %将初始化的粒子带入到Aa函数里面求出a的值
    jv(1,i) = 3 * a(1,i) * x(i,1)^2+ 2 * a(2,i) * x(i,1)+a(3,i);
    jv(2,i) = 5 * a(5,i) * x(i,2)^4 +4 * a(6,i) * x(i,2)^3+ 3 * a(7,i) * x(i,2)^2+2* a(8,i) * x(i,2)+ a(9,i);
    jv(3,i) = 3 * a(11,i)* x(i,3)^2+ 2 * a(12,i) * x(i,3)+ a(13,i);    %求出每个关节的速度
    if jv(1,i)<=( -20 * pi/180)|jv(1,i)>= (20 * pi/180)|jv(2,i)<=( -20 * pi/180)|jv(2,i)>=(20 * pi/180)|jv(3,i)<=( -20 * pi/180)|jv(3,i)>=(20 * pi/180)    %将每个关节的速度限制在-20到20之间
        f = 100;                         
    else
        f = fitness(x(i,1 ),x(i,2),x(i,3),D); %总时间
    end
    if pf(i) > f
        px(i,:) = x(i,:);
        pf(i) = f;
    end
    if pgf > pf(i)
        pgf = pf(i);
        pgx = x(i,: );
    end
end

for k = 2:50    %迭代的次数
    pgf(k) = pgf(k - 1);
    w = (Wmax - k * ( Wmax - Wmin)/ Nmax) ;
    for i = 1:m
        for j= 1 : D
            v(i,j)= w * v(i,j)+ cl * rand * (px(i,j)- x(i,j))+ c2 * rand * (pgx(j)-x(i,j));
            if v(i,j)<-2
                v(i,j)= -2;
            end
            if v(i,j)>2
                v(i,j)= 2;
            end
            x(i,j) = x(i,j)+v(i,j)
            if x(i,j)<0.1
                x(i,j)= 0.1;
            end
            if x(i,j)>4
                x(i,j) = 4;
            end
        end
        a( : ,i) = Aa(x(i,1),x(i,2),x(i,3));
        jv(1,i)= 3 * a(1,i) * x(i,1)^2+ 2* a(2,i) * x(i,1)+ a(3,i);
        jv(2,i) = 5 * a(5,i) * x(i,2)^4+ 4 * a(6,i) * x(i,2)^3+ 3 * a(7,i) * x(i,2)^2+2*a( 8,i) * x(i,2) + a(9 ,i);
        jv(3,i) = 3 * a(11,i) * x(i,3)^2+ 2* a(12,i) * x(i,3)+ a(13,i);
        if jv(1,i)<= ( -20 * pi/180)|jv(1,i)>= (20 * pi/180)|jv(2,i)<=( -20 * pi/180)|jv(2,i) >=(20 * pi/180)|jv(3,i)<=( -20 * pi/180)|jv(3,i) >=(20 * pi/180)
            f = 100;
        else
            f = fitness(x(i,1),x(i,2),x(i,3),D);
        end
        if pf>f
            px(i,:) = x(i,:);
            pf(i) = f;
        end
        if pgf(k) > pf(i)
            pgf(k) = pf(i);
            pgx = x(i,:);
        end
    end
end
