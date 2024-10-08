clc
clear

%{
function y = piecewiseFunction(x)
    if  x <= 1/8 && x>= 0
        y = 8*x;       
    elseif x >= 1/8 && x < 3/8
        y = 1; 
    elseif x >= 3/8 && x < 1/2
        y = 1-8*(x-3/8); 
    elseif x>=1/2 && x<=1
        y = 0;      
    else
        y = NaN;
    end
end

% 新函数组合
function y_new0 = newFunction0(x)
    y_new0 = piecewiseFunction(mod(x,1));
end
% 新函数组合出u_t
function y_new1 = newFunction1(x)
    y_new1 = piecewiseFunction(mod(x,1))-piecewiseFunction(mod(x+1/2,1));
end
% 新函数组合出v_t
function y_new2 = newFunction2(x)
    y_new2 = piecewiseFunction(mod(x+1/4,1))*2;
end
% 新函数组合出w_t
function y_new3 = newFunction3(x)
    y_new3 = piecewiseFunction(mod(x-1/4,1));
end


% 画图
x = 0:0.01:1;
a_t = arrayfun(@newFunction0, x);
u = arrayfun(@newFunction1, x);
v = arrayfun(@newFunction2, x);
w = arrayfun(@newFunction3, x);

%}


x = 0:0.01:1;
v_1 = -1;
u = sin(2 * pi * x);
v = v_1+cos(2 * pi * x);
w = 1+x*0;

% 绘制新函数图像
figure;
plot(x, v, 'k');
hold on
plot(x, w, 'g');
hold on
plot(x, u, 'r');
hold on

axis([0 1 -2.5 2.5]);    % 设置横纵坐标范围为 [0, 3]
xlabel('time t/T');
ylabel('amplitudes');
title('New Function combining two piecewise functions');