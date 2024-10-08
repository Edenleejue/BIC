clc
clear

n=input('the number of unit cell:\n');%选择元胞数量
w=1;
E=zeros(301,2*n);
states=zeros(301,2*n,2*n);

%研究范围是0<v/w<3
for j=1:1:301
    v=(j-1)*0.01;
    %构造哈密顿量
    H=zeros(2*n,2*n);
    H(1,2)=v;
    H(2*n,2*n-1)=v;
    for i=1:1:n-1
        H(2*i,2*i-1)=v;
        H(2*i,2*i+1)=w;
        H(2*i+1,2*i)=w;
        H(2*i+1,2*i+2)=v;
    end
    [states(j,:,:),V]=eigs(H,2*n);%求解本征值和本征矢，函数具体用法可以看文档
    E(j,:)=diag(V);
end

Eorder=sort(E,2);%额外排个序方便画图
%Eorder=E;
v=0:0.01:3;
figure

subplot(2,3,[1,4]);%画出本征值分布即能量随v/w的变化
hold on
for j=1:1:2*n
    plot(v,Eorder(:,j));
end
hold off
xlabel('v/w');
ylabel('energy E');
title(['The spectrum of finite SSH model(n=',num2str(n),')']);

%画出v/w=0.5时两个能量最接近0的本征态分布
subplot(2,3,2);
bar(states(51,:,2*n-1));
title(['E=',num2str(E(51,2*n-1)),',v/w=0.5']);

subplot(2,3,3);
bar(states(51,:,2*n));
title(['E=',num2str(E(51,2*n)),',v/w=0.5']);

%在v/w=0.5处另外随便挑两个本征态画出来
subplot(2,3,5);
bar(states(51,:,2*n-7));
title(['E=',num2str(E(51,2*n-7)),',v/w=0.5']);

subplot(2,3,6);
bar(states(51,:,2*n-6));
title(['E=',num2str(E(51,2*n-6)),',v/w=0.5']);