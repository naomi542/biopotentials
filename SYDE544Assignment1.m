clear all
close all
clc

%% Calculate resting membrane potential
Pk = 40; % permeability of K compared to Na
Pna = 1; % permeability of Na
Ck_o = 5; % [K outside]
Ck_i = 100; % [K inside]
Cna_o = 150; % [Na outside]
Cna_i = 15; % [Na inside]

V= 61.54*log10((Pk*Ck_o + Pna*Cna_o)/(Pk*Ck_i + Pna*Cna_i)); % Initial Membrane voltage

%% ODE45 Solution (No edits required)
t = 10; %Time to simulate (ms)
m= am(V)/(am(V)+bm_(V)); % Initial m-value
n= an(V)/(an(V)+bn(V)); % Initial n-value
h= ah(V)/(ah(V)+bh(V)); % Initial h-value
y0=[V;n;m;h];
tspan = [0,t];
[time,V] = ode45(@HH,tspan,y0);
OD=V(:,1);
ODn=V(:,2);
ODm=V(:,3);
ODh=V(:,4);

%% Plot1 (V(m) with title and axis labels)
figure
plot(time,OD);
title("V(m) for the Hodgkin-Huxley Model");
xlabel("Time (ms)");
ylabel("Voltage (mV)");

%% Plot2 (gating variables with title, axis labels, and legend)
figure
hold on
plot(time, ODn);
plot(time, ODm);
plot(time, ODh);
hold off
title("Gating Variables for the Hodgkin-Huxley Model");
xlabel("Time (ms)");
ylabel("Gating Variables");
legend({'n','m','h'})

%% Plot3 (conductance of sodium and potassium with title, axis labels, and legend)
gNa=1.2; % Na conductance constant
gK=0.36; % K conductance constant
GNa= gNa.*(ODm.^3).*ODh; % Na conductance
GK= gK.*(ODn.^4); % K conductance

figure 
hold on
plot(time, GK);
plot(time, GNa);
hold off
title("Ionic Conductance for the Hodgkin-Huxley Model");
xlabel("Time (ms)");
ylabel("Conductance");
legend({'K','Na'})