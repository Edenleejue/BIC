clc
clear

n=input('the number of unit cell:\n');
E=zeros(101,2*n);
states=zeros(101,2*n,2*n);





v_1 = -1;
% 画图
%x = 0:0.01:1;
%a_t = arrayfun(@newFunction0, x);
%u = arrayfun(@newFunction1, x);
%v = arrayfun(@newFunction2, x);
%w = arrayfun(@newFunction3, x);



%研究范围是0<t/T<3
for j=1:1:101
    a=(j-1)*0.01;
    u = sin(2 * pi * a);
    v = v_1+cos(2 * pi * a);
    w = 1;
    %构造哈密顿量
    H=zeros(2*n,2*n);
    H(1,2)=v;
    H(1,1)=u;
    H(2,2)=-u;
    H(2*n,2*n-1)=v;
    for i=1:1:n-1
        H(2*i,2*i-1)=v;
        H(2*i,2*i+1)=w;
        H(2*i+1,2*i)=w;
        H(2*i+1,2*i+2)=v;
        H(2*i+1,2*i+1)=u;
        H(2*(i+1),2*(i+1))=-u;
    end
    [states(j,:,:),V]=eigs(H,2*n);%求解本征值和本征矢，函数具体用法可以看文档
    E(j,:)=diag(V);
end

Eorder=sort(E,2);%额外排个序方便画图
%Eorder=E;
a=0:0.01:1;
figure

subplot(2,3,[1,4]);%画出本征值分布即能量随v/w的变化
hold on
for j=1:1:2*n
    plot(a,Eorder(:,j));
end
hold off
xlabel('t/T');
ylabel('energy E');
title(['The spectrum of finite SSH model(n=',num2str(n),')']);

%画出v/w=0.5时两个能量最接近0的本征态分布
subplot(2,3,2);
bar(states(92,:,2*n-1));
title(['E=',num2str(E(92,2*n-1)),',t/T=0.9']);

subplot(2,3,3);
bar(states(92,:,2*n));
title(['E=',num2str(E(92,2*n)),',t/T=0.9']);

%在v/w=0.5处另外随便挑两个本征态画出来
subplot(2,3,5);
bar(states(92,:,2*n-7));
title(['E=',num2str(E(92,2*n-7)),',t/T=0.9']);

subplot(2,3,6);
bar(states(92,:,2*n-6));
title(['E=',num2str(E(92,2*n-6)),',t/T=0.9']);