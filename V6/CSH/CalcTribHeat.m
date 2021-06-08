%% Make .dat files for temperature from U24s and HOBOs for the PreStorm Period

%% clearing functinos
clear
clc
close all
%% Constant
L = 100; %Length of a model cell, [m]
ro = 1000; %density of water, [kg/m3]
Cp = 4184; %specific heat capcity, [J/kg degC]

%% Set Directory for temperature import
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\Organizing\')
%% Import temperature data

Date_T = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','A4:A4710');
Date_T = datetime(Date_T + 693960,'ConvertFrom','datenum');
HWY183_T = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','C4:C4710'); 
WWTP1_T = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','E4:E4710'); 
WWTP2_T = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','I4:I4710'); 
Onion_T = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','M4:M4710'); 

%% set directory for 'tributary' data
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\Organizing\Heat_N\')
%% Import 'tributary' data

HWY = readtable('HWY_N.dat','PreserveVariableNames',1); %HWY
HWY_DT = datetime(table2array(HWY(:,1)) + table2array(HWY(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
HWY_F = table2array(HWY(:,3));

Onion = readtable('Onion_N.dat','PreserveVariableNames',1); %Onion
Onion_DT = datetime(table2array(Onion(:,1)) + table2array(Onion(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Onion_F = table2array(Onion(:,3));

WWTP2 = readtable('WWTP2_N.dat','PreserveVariableNames',1); %WWTP2
WWTP2_DT = datetime(table2array(WWTP2(:,1)) + table2array(WWTP2(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
WWTP2_F = table2array(WWTP2(:,3));

Walnut = readtable('Walnut_N.dat','PreserveVariableNames',1); %Walnut
Walnut_DT = datetime(table2array(Walnut(:,1)) + table2array(Walnut(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Walnut_F = table2array(Walnut(:,3));

WWTP1 = readtable('WWTP1_N.dat','PreserveVariableNames',1); %WWTP1
WWTP1_DT = datetime(table2array(WWTP1(:,1)) + table2array(WWTP1(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
WWTP1_F = table2array(WWTP1(:,3));

Boggy = readtable('Boggy_N.dat','PreserveVariableNames',1); %Boggy
Boggy_DT = datetime(table2array(Boggy(:,1)) + table2array(Boggy(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Boggy_F = table2array(Boggy(:,3));

Gille = readtable('Gilleland_N.dat','PreserveVariableNames',1); %Gilleland
Gille_DT = datetime(table2array(Gille(:,1)) + table2array(Gille(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Gille_F = table2array(Gille(:,3));
%%

Cole = readtable('Cole_N.dat','PreserveVariableNames',1); %Coleman
Cole_DT = datetime(table2array(Cole(:,1)) + table2array(Cole(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Cole_F = table2array(Cole(:,3));

Dry = readtable('Dry_N.dat','PreserveVariableNames',1); %Dry
Dry_DT = datetime(table2array(Dry(:,1)) + table2array(Dry(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Dry_F = table2array(Dry(:,3));

%%

BS = readtable('BS_N.dat','PreserveVariableNames',1); %BigSandy
BS_DT = datetime(table2array(BS(:,1)) + table2array(BS(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
BS_F = table2array(BS(:,3));

Wil = readtable('Wil_N.dat','PreserveVariableNames',1); %Wilabarger
Wil_DT = datetime(table2array(Wil(:,1)) + table2array(Wil(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Wil_F = table2array(Wil(:,3));

Piney = readtable('Piney_N.dat','PreserveVariableNames',1); %Piney
Piney_DT = datetime(table2array(Piney(:,1)) + table2array(Piney(:,2)),'Format','MM/dd/yyyy HH:mm:ss'); %datetimeHWY
Piney_F = table2array(Piney(:,3));
%% Assignment of temperature

BS_T = Onion_T; %Big Sandy = Onion
Wil_T = Onion_T; %Wil = Onion
Piney_T = Onion_T; %Piney = Onion
Cole_T = Onion_T; %Cole = Onion
Dry_T = Onion_T; %Dry = Onion
Gille_T = Onion_T; %Gilleland = Onion
Onion_T = Onion_T; %Onion = Actual Data
WWTP2_T = WWTP2_T; %WWTP2 = Actual Data
Walnut_T = Onion_T; %Big Sandy = Onion
WWTP1_T = WWTP1_T; %WWTP1 = Actual Data
Boggy_T = Onion_T; %Boggy = Onion

%% Plot all data
figure
hold on
plot(Date_T,HWY183_T,'-g')
hold on
plot(Date_T,WWTP1_T,'-c')
hold on
plot(Date_T,WWTP2_T,'-b')
hold on
plot(Date_T, Onion_T,'-m')
xlabel('Date')
ylabel(['Stream Temperature [' char(176) 'C]'])
legend('HWY 183','Onion','WWTP1','WWTP2')
title('Hobos')

figure
plot(HWY_DT,HWY_F,'-k')
xlim([HWY_DT(1,1) HWY_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(Date_T,HWY183_T,'-r')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('HWY 183')

%% Interp all flow at the timestep of the temperature data
ST = HWY_DT(1,1);
ED = HWY_DT(end,1);
Interval = HWY_DT(2,1) - HWY_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,HWY183_T,InterpTime,'linear');
FLOWS = {HWY_F};
TEMPS = {InterpTemp};

figure
subplot(3,4,1)
plot(HWY_DT,HWY_F,'.k')
xlim([HWY_DT(1,1) HWY_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,HWY183_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('HWY 183')

%%%%%%%%%%%%% BIG SANDY %%%%%%%%%%%%%%%%%
ST = BS_DT(1,1);
ED = BS_DT(end,1);
Interval = BS_DT(2,1) - BS_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{BS_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,2)
plot(BS_DT,BS_F,'.k')
xlim([BS_DT(1,1) BS_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('BigSandy w/ Onion Temps')

%%%%%%%%%%%%% Wil %%%%%%%%%%%%%%%%%
ST = Wil_DT(1,1);
ED = Wil_DT(end,1);
Interval = Wil_DT(2,1) - Wil_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Wil_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,3)
plot(Wil_DT,Wil_F,'.k')
xlim([Wil_DT(1,1) Wil_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Wilbarger w/ Onion Temps')


%%%%%%%%%%%%% Piney %%%%%%%%%%%%%%%%%
ST = Piney_DT(1,1);
ED = Piney_DT(end,1);
Interval = Piney_DT(2,1) - Piney_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Piney_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,4)
plot(Piney_DT,Piney_F,'.k')
xlim([Piney_DT(1,1) Piney_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Piney w/ Onion Temps')

%%%%%%%%%%%%% Cole %%%%%%%%%%%%%%%%%
ST = Cole_DT(1,1);
ED = Cole_DT(end,1);
Interval = Cole_DT(2,1) - Cole_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Cole_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,5)
plot(Cole_DT,Cole_F,'.k')
xlim([Cole_DT(1,1) Cole_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Coleman w/ Onion Temps')

%%%%%%%%%%%%% Dry %%%%%%%%%%%%%%%%%
ST = Dry_DT(1,1);
ED = Dry_DT(end,1);
Interval = Dry_DT(2,1) - Dry_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Dry_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,6)
plot(Dry_DT,Dry_F,'.k')
xlim([Dry_DT(1,1) Dry_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Dry w/ Onion Temps')

%%%%%%%%%%%%% Gille %%%%%%%%%%%%%%%%%
ST = Gille_DT(1,1);
ED = Gille_DT(end,1);
Interval = Gille_DT(2,1) - Gille_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Gille_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,7)
plot(Gille_DT,Gille_F,'.k')
xlim([Gille_DT(1,1) Gille_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Gille w/ Onion Temps')

%%%%%%%%%%%%% Onion %%%%%%%%%%%%%%%%%
ST = Onion_DT(1,1);
ED = Onion_DT(end,1);
Interval = Onion_DT(2,1) - Onion_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Onion_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,8)
plot(Onion_DT,Onion_F,'.k')
xlim([Onion_DT(1,1) Onion_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Onion')

%%%%%%%%%%%%% WWTP2 %%%%%%%%%%%%%%%%%
ST = WWTP2_DT(1,1);
ED = WWTP2_DT(end,1);
Interval = WWTP2_DT(2,1) - WWTP2_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,WWTP2_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{WWTP2_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,9)
plot(WWTP2_DT,WWTP2_F,'.k')
xlim([WWTP2_DT(1,1) WWTP2_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,WWTP2_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('WWTP2')

%%%%%%%%%%%%% Walnut %%%%%%%%%%%%%%%%%
ST = Walnut_DT(1,1);
ED = Walnut_DT(end,1);
Interval = Walnut_DT(2,1) - Walnut_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Walnut_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,10)
plot(Walnut_DT,Walnut_F,'.k')
xlim([Walnut_DT(1,1) Walnut_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Walnut w/ Onion Temps')

%%%%%%%%%%%%% WWTP1 %%%%%%%%%%%%%%%%%
ST = WWTP1_DT(1,1);
ED = WWTP1_DT(end,1);
Interval = WWTP1_DT(2,1) - WWTP1_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,WWTP1_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{WWTP1_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,11)
plot(WWTP1_DT,WWTP1_F,'.k')
xlim([WWTP1_DT(1,1) WWTP1_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,WWTP1_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('WWTP1')

%%%%%%%%%%%%% Boggy %%%%%%%%%%%%%%%%%
ST = Boggy_DT(1,1);
ED = Boggy_DT(end,1);
Interval = Boggy_DT(2,1) - Boggy_DT(1,1);
InterpTime = ST:Interval:ED;

InterpTemp = interp1(Date_T,Onion_T,InterpTime,'linear');
FLOWS = horzcat(FLOWS,{Boggy_F});
TEMPS = horzcat(TEMPS,{InterpTemp});

subplot(3,4,12)
plot(Boggy_DT,Boggy_F,'.k')
xlim([Boggy_DT(1,1) Boggy_DT(end,1)])
ylabel('Flow [CMS]')
hold on
yyaxis right
plot(InterpTime,InterpTemp,'^r')
hold on
plot(Date_T,Onion_T,'sm')
set(gca,'YColor','r')
ylabel(['Instream Temperature [' char(176) 'C]'])
xlabel('Date')
title('Boggy w/ Onion Temps')

%% Calculate heat for tributaries 
% calculated heat as roCpQT/L and watch out for your units

for i = 1:length(FLOWS)
    
    Q = FLOWS{i};
    T = TEMPS{i};
    heat = Q.*T'*ro*Cp/L; %[m3/s]*[degC]*[kg/m3]*J/kg degC]/m
    HEAT{i} = heat; %Watts/m
    
end

%% plot flows

figure
plot(HWY_DT, FLOWS{1},'-', 'Color', [1 0.5 0.7])
ylabel('Upstream Flow [m^3/s]')
yyaxis left
set(gca,'YColor',[1 0.5 0.7])
hold on

yyaxis right
set(gca,'YColor','k')
plot(BS_DT, FLOWS{2},'-','Color',[1 0 0])
hold on
plot(Wil_DT, FLOWS{3},'-','Color',[1 .6 .1])
hold on
plot(Piney_DT, FLOWS{4},'-','Color',[1 .9 .1])
hold on
plot(Cole_DT, FLOWS{5},'-','Color',[.7 .9 .1])
hold on
plot(Dry_DT, FLOWS{6},'-','Color',[0.5 0.7 1])
hold on
plot(Gille_DT, FLOWS{7},'-','Color',[0.5 0.1 0.6])
hold on
plot(Onion_DT, FLOWS{8},'-','Color',[0.8 0.3 0.6])
hold on
plot(WWTP2_DT, FLOWS{9},'-','Color',[0.7 0.4 0.2])
hold on
plot(Walnut_DT, FLOWS{10},'-','Color',[0.7 0.6 0.5])
hold on
plot(WWTP1_DT, FLOWS{11},'-','Color',[0.4 0.5 0.5])
hold on
plot(Boggy_DT, FLOWS{12},'-k')
legend('Upstream (HWY183)','BS','Wil','Piney','Cole','Dry','Gille','Onion','WWTP2','Wal','WWTP1','Boggy')
ylabel('Tributary Flows [m^3/s]')

%% plot heat to check 

figure
plot(HWY_DT, HEAT{1},'-', 'Color', [1 0.5 0.7])
ylabel('Upstream Heat [Watts/m]')
yyaxis left
set(gca,'YColor',[1 0.5 0.7])
hold on

yyaxis right
set(gca,'YColor','k')
plot(BS_DT, HEAT{2},'-','Color',[1 0 0])
hold on
plot(Wil_DT, HEAT{3},'-','Color',[1 .6 .1])
hold on
plot(Piney_DT, HEAT{4},'-','Color',[1 .9 .1])
hold on
plot(Cole_DT, HEAT{5},'-','Color',[.7 .9 .1])
hold on
plot(Dry_DT, HEAT{6},'-','Color',[0.5 0.7 1])
hold on
plot(Gille_DT, HEAT{7},'-','Color',[0.5 0.1 0.6])
hold on
plot(Onion_DT, HEAT{8},'-','Color',[0.8 0.3 0.6])
hold on
plot(WWTP2_DT, HEAT{9},'-','Color',[0.7 0.4 0.2])
hold on
plot(Walnut_DT, HEAT{10},'-','Color',[0.7 0.6 0.5])
hold on
plot(WWTP1_DT, HEAT{11},'-','Color',[0.4 0.5 0.5])
hold on
plot(Boggy_DT, HEAT{12},'-k')
legend('Upstream (HWY183)','BS','Wil','Piney','Cole','Dry','Gille','Onion','WWTP2','Wal','WWTP1','Boggy')
ylabel('Tributary Heat [Watts/m]')
% %% set export directory
% cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\Organizing\TribHeat\')
% %% export as csv
% 
% filename = 'HWY_Heat_watts_per_meter_PRE.csv';
% VNs = {';DateTime','Heat [Watts/m]'};
% T = table(HWY_DT, HEAT{1}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'BS_Heat_watts_per_meter_PRE.csv';
% T = table(BS_DT, HEAT{2}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Wil_Heat_watts_per_meter_PRE.csv';
% T = table(Wil_DT, HEAT{3}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Piney_Heat_watts_per_meter_PRE.csv';
% T = table(Piney_DT, HEAT{4}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Cole_Heat_watts_per_meter_PRE.csv';
% T = table(Cole_DT, HEAT{5}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Dry_Heat_watts_per_meter_PRE.csv';
% T = table(Dry_DT, HEAT{6}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Gille_Heat_watts_per_meter_PRE.csv';
% T = table(Gille_DT, HEAT{7}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Onion_Heat_watts_per_meter_PRE.csv';
% T = table(Onion_DT, HEAT{8}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'WWTP2_Heat_watts_per_meter_PRE.csv';
% T = table(WWTP2_DT, HEAT{9}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Walnut_Heat_watts_per_meter_PRE.csv';
% T = table(Walnut_DT, HEAT{10}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'WWTP1_Heat_watts_per_meter_PRE.csv';
% T = table(WWTP1_DT, HEAT{11}, 'VariableNames',VNs);
% writetable(T,filename)
% 
% filename = 'Boggy_Heat_watts_per_meter_PRE.csv';
% T = table(Boggy_DT, HEAT{12}, 'VariableNames',VNs);
% writetable(T,filename)
