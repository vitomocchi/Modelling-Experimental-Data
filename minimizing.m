clearvars, close all

a=0.2586;
b=0.0203;
c=0.0574;
d=0.0098;
C0=0.04184;
K0=0.6315;

t_esp=[0 1.5000 9.0000 10.0000 18.0000 23.0000 25.5000 27.0000 38.0000 42.0000 45.5000 47.0000];

VolC=[0.3750 0.9200 3.0800 3.9900 5.2350 6.1500 9.9100 9.4700 10.5700 7.2700 9.8800 8.3000];

VolK=[0.2900 0.3700 0.6300 0.9800 1.3450 1.4600 1.1100 1.2250 1.1000 1.7100 0.9600 1.8400];

 
syms t 
k11=0.05:0.0001:0.06;
k22=0.004:0.00001:0.005;

minval=Inf;

index=[0 0];

for i=1:numel(k11)
    for j=1:numel(k22)
        
        k1=k11(i);
        k2=k22(j);
        
        f = @(t,x) [a*x(1)-b*x(1)^2-k1*x(1)*x(2); c*x(2)-d*x(2)^2-k2*x(1)*x(2)];
        [t,x] = ode45(@(t,x) f(t,x),t_esp,[C0 K0]);
        
        currval=0;
        for k=1:numel(t)
            currval=currval+((VolC(k)-x(k,1))^2+(VolK(k)-x(k,2))^2);
        end
            
        if  currval<minval
            minval=currval;
            index=[i j];
        end
    end
end

k1=k11(index(1));
k2=k22(index(2));
[t,x] = ode45(@(t,x) f(t,x),t_esp,[C0 K0]);

fprintf('\nMinimizing value: (k1,k2)=(%4.2f,%4.3f)\n',k1,k2);
fprintf('\nWe obtain the following values of C(t) and K(t):\n');

for i=1:numel(t)
    fprintf('\nt=%4.2f -> C(t)=%6.4f, K(t)=%6.4f\n',t(i),x(i,1),x(i,2));
end

fprintf('\nThe squared deviation between simulated and experimental values is: %7.4f\n',minval);

str=sprintf(' (k1,k2)*=(%4.2f,%4.3f)',k1,k2);

figure()
hold on
plot(t,x(:,1),'r-')
plot(t_esp,VolC,'k*')
hold off
xlabel('t'), ylabel('C(t)'), title(strcat('C(t),',str))
legend('C(t)','VolC')

figure()
hold on
plot(t,x(:,2),'b-')
plot(t_esp,VolK,'k*')
hold off
xlabel('t'), ylabel('K(t)'), title(strcat('K(t),',str))
legend('K(t)','VolK')