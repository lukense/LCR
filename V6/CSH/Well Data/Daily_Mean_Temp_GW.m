%% Calc daily mean gw temps
%% clearing functions
clear 
clc
close all

%% set directory
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V3\CSH\Well Data\');
%% import groundwater data

%Greengate
GG_DT = datetime(xlsread('LCR16_GW_Greengate_Summer_2016','CompiledData','C11:C4506')+693960,'ConvertFrom','datenum');
GG_R = xlsread('LCR16_GW_Greengate_Summer_2016','CompiledData','J11:J4506');
GG_P00 = xlsread('LCR16_GW_Greengate_Summer_2016','CompiledData','K11:K4506');
GG_P01 = xlsread('LCR16_GW_Greengate_Summer_2016','CompiledData','L11:L4506');
GG_P02 = xlsread('LCR16_GW_Greengate_Summer_2016','CompiledData','M11:M4506');
GG_P03 = xlsread('LCR16_GW_Greengate_Summer_2016','CompiledData','N11:N4506');

%Hergotz
HG_DT = datetime(xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','C11:C4714')+693960,'ConvertFrom','datenum');
HG_R = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','L11:L4714');
HG_P00 = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','M11:M4714');
HG_P01 = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','N11:N4714');
HG_P02 = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','O11:O4714');
HG_P03 = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','P11:P4714');
HG_P04 = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','Q11:Q4714');
HG_P05 = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','R11:R4714');
HG_P06 = xlsread('LCR16_GW_Hergotz_Summer_2016','CompiledDATA','S11:S4714');
 
%Webberville
WB_DT = datetime(xlsread('LCR16_GW_Webberville_Summer_2016','CompiledDATA','B2508:B6717')+693960,'ConvertFrom','datenum'); %DateTime
WB_R = xlsread('LCR16_GW_Webberville_Summer_2016','CompiledDATA','H2508:H6717'); %degC
WB_P00 = xlsread('LCR16_GW_Webberville_Summer_2016','CompiledDATA','I2508:I6717'); %degC
WB_P01 = xlsread('LCR16_GW_Webberville_Summer_2016','CompiledDATA','J2508:J6717'); %degC
WB_P02 = xlsread('LCR16_GW_Webberville_Summer_2016','CompiledDATA','K2508:K6717'); %degC
WB_P03 = xlsread('LCR16_GW_Webberville_Summer_2016','CompiledDATA','L2508:L6717'); %degC

%% setting time period
Start_dt = '08/03/2016 16:00:00';
End_dt = '09/13/2016 16:00:00';

%% cropping
%Greengate
index_S = find(GG_DT == Start_dt);
index_E = find(GG_DT == End_dt);
GG_DT_c = GG_DT(index_S:index_E);
GG_R_c = GG_R(index_S:index_E);
GG_P00_c = GG_P00(index_S:index_E);
GG_P01_c = GG_P01(index_S:index_E);
GG_P02_c = GG_P02(index_S:index_E);
GG_P03_c = GG_P03(index_S:index_E);

%hergotz
index_S = find(HG_DT == Start_dt);
index_E = find(HG_DT == End_dt);
HG_DT_c = HG_DT(index_S:index_E);
HG_R_c = HG_R(index_S:index_E);
HG_P00_c = HG_P00(index_S:index_E);
HG_P01_c = HG_P01(index_S:index_E);
HG_P02_c = HG_P02(index_S:index_E);
HG_P03_c = HG_P03(index_S:index_E);
HG_P04_c = HG_P04(index_S:index_E);
HG_P05_c = HG_P05(index_S:index_E);
HG_P06_c = HG_P06(index_S:index_E);

%Webberville
index_S = find(WB_DT == Start_dt);
index_E = find(WB_DT == End_dt);
WB_DT_c = WB_DT(index_S:index_E);
WB_R_c = WB_R(index_S:index_E);
WB_P00_c = WB_P00(index_S:index_E);
WB_P01_c = WB_P01(index_S:index_E);
WB_P02_c = WB_P02(index_S:index_E);
WB_P03_c = WB_P03(index_S:index_E);

%% plotting
%GreenGate
figure
plot(GG_DT_c,GG_R_c,'-k')
hold on
plot(GG_DT_c,GG_P00_c,'-r')
hold on
plot(GG_DT_c,GG_P01_c,'-g')
hold on
plot(GG_DT_c,GG_P02_c,'-c')
hold on
plot(GG_DT_c,GG_P03_c,'-b')
legend('River','P00','P01','P02','P03')
xlabel('DateTime')
ylabel(['Temperature [',char(176),'C]'])
title('GreenGate')

%Hergotz
figure
plot(HG_DT_c,HG_R_c,'-k')
hold on
plot(HG_DT_c,HG_P00_c,'-r')
hold on
plot(HG_DT_c,HG_P01_c,'-y')
hold on
plot(HG_DT_c,HG_P02_c,'-g')
hold on
plot(HG_DT_c,HG_P03_c,'-c')
hold on
plot(HG_DT_c,HG_P04_c,'-b')
hold on
plot(HG_DT_c,HG_P05_c,'-m')
hold on
plot(HG_DT_c,HG_P06_c,'-','Color',[0.4940 0.1840 0.5560])
hold on
legend('River','P00','P01','P02','P03','P04','P05','P06')
xlabel('DateTime')
ylabel(['Temperature [',char(176),'C]'])
title('Hergotz')

%Webberville
figure
plot(WB_DT_c,WB_R_c,'-k')
hold on
plot(WB_DT_c,WB_P00_c,'-r')
hold on
plot(WB_DT_c,WB_P01_c,'-g')
hold on
plot(WB_DT_c,WB_P02_c,'-c')
hold on
plot(WB_DT_c,WB_P03_c,'-b')
hold on

legend('River','P00','P01','P02','P03')
xlabel('DateTime')
ylabel(['Temperature [',char(176),'C]'])
title('Webberville')

%% mean daily temperature
%%%%%%%%%%%%%%%%%%
step = days(1); %1 day
time = Start_dt;

daily = datetime(Start_dt):step:datetime(End_dt);

%Greengate
for i = 1:length(daily)-1
    index2 = find(GG_DT_c == daily(i+1));
    index1 = find(GG_DT_c == daily(i));
    
    dm_GGR(i) = mean(GG_R_c(index1:index2));
    dm_GG00(i) = mean(GG_P00_c(index1:index2));
    dm_GG01(i) = mean(GG_P01_c(index1:index2));
    dm_GG02(i) = mean(GG_P02_c(index1:index2));
    dm_GG03(i) = mean(GG_P03_c(index1:index2));
end

figure
plot(daily(1:end-1),dm_GGR,'o--k','MarkerFaceColor','k')
hold on
plot(daily(1:end-1),dm_GG00,'o--r','MarkerFaceColor','r')
hold on
plot(daily(1:end-1),dm_GG01,'o--g','MarkerFaceColor','g')
hold on
plot(daily(1:end-1),dm_GG02,'o--c','MarkerFaceColor','c')
hold on
plot(daily(1:end-1),dm_GG03,'o--b','MarkerFaceColor','b')
legend('River','P00','P01','P02','P03')
xlabel('DateTime')
ylabel(['Temperature [',char(176),'C]'])
title('GW - Daily Mean, GG')

n_GG = {'DateTime','River','P00','P01','P02','P03'};
GG_Table = table(daily(1:end-1)',dm_GGR' ,dm_GG00',dm_GG01',dm_GG02',dm_GG03','VariableNames',n_GG);

%Hergotz
for i = 1:length(daily)-1
    index2 = find(HG_DT_c == daily(i+1));
    index1 = find(HG_DT_c == daily(i));
    
    dm_HGR(i) = mean(HG_R_c(index1:index2));
    dm_HG00(i) = mean(HG_P00_c(index1:index2));
    dm_HG01(i) = mean(HG_P01_c(index1:index2));
    dm_HG02(i) = mean(HG_P02_c(index1:index2));
    dm_HG03(i) = mean(HG_P03_c(index1:index2));
    dm_HG04(i) = mean(HG_P04_c(index1:index2));
    dm_HG05(i) = mean(HG_P05_c(index1:index2));
    dm_HG06(i) = mean(HG_P06_c(index1:index2));
end

figure
plot(daily(1:end-1),dm_HGR,'o--k','MarkerFaceColor','k')
hold on
plot(daily(1:end-1),dm_HG00,'o--r','MarkerFaceColor','r')
hold on
plot(daily(1:end-1),dm_HG01,'o--y','MarkerFaceColor','y')
hold on
plot(daily(1:end-1),dm_HG02,'o--g','MarkerFaceColor','g')
hold on
plot(daily(1:end-1),dm_HG03,'o--c','MarkerFaceColor','c')
hold on
plot(daily(1:end-1),dm_HG04,'o--b','MarkerFaceColor','b')
hold on
plot(daily(1:end-1),dm_HG05,'o--m','MarkerFaceColor','m')
hold on
plot(daily(1:end-1),dm_HG06,'o--','Color',[0.4940 0.1840 0.5560],'MarkerFaceColor',[0.4940 0.1840 0.5560])
hold on
legend('River','P00','P01','P02','P03','P04','P05','P06')
xlabel('DateTime')
ylabel(['Temperature [',char(176),'C]'])
title('GW - Daily Mean, Hergotz')

n_HG = {'DateTime','River','P00','P01','P02','P03','P04','P05','P06'};
HG_Table = table(daily(1:end-1)',dm_HGR' ,dm_HG00',dm_HG01',dm_HG02',dm_HG03',dm_HG04',dm_HG05',dm_HG06','VariableNames',n_HG);

%Webberville
for i = 1:length(daily)-1
    index2 = find(WB_DT_c == daily(i+1));
    index1 = find(WB_DT_c == daily(i));
    
    dm_WBR(i) = mean(WB_R_c(index1:index2));
    dm_WB00(i) = mean(WB_P00_c(index1:index2));
    dm_WB01(i) = mean(WB_P01_c(index1:index2));
    dm_WB02(i) = mean(WB_P02_c(index1:index2));
    dm_WB03(i) = mean(WB_P03_c(index1:index2));
end

figure
plot(daily(1:end-1),dm_WBR,'o--k','MarkerFaceColor','k')
hold on
plot(daily(1:end-1),dm_WB00,'o--r','MarkerFaceColor','r')
hold on
plot(daily(1:end-1),dm_WB01,'o--g','MarkerFaceColor','g')
hold on
plot(daily(1:end-1),dm_WB02,'o--c','MarkerFaceColor','c')
hold on
plot(daily(1:end-1),dm_WB03,'o--b','MarkerFaceColor','b')
legend('River','P00','P01','P02','P03')
xlabel('DateTime')
ylabel(['Temperature [',char(176),'C]'])
title('GW - Daily Mean, WB')

n_WB = {'DateTime','River','P00','P01','P02','P03'};
WB_Table = table(daily(1:end-1)',dm_WBR' ,dm_WB00',dm_WB01',dm_WB02',dm_WB03','VariableNames',n_WB);


%% exporting 

%% set export directory
% cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V3\CSH\Well Data\')
% writetable(WB_Table,'WB_GW_Daily_Mean_Temp_degC.csv')
% writetable(HG_Table,'HG_GW_Daily_Mean_Temp_degC.csv')
% writetable(GG_Table,'GG_GW_Daily_Mean_Temp_degC.csv')


