%% Weather Data reformat

%% clearing functions

clear
clc
close all

%% set directory and import the data

cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V1\CSH\WeatherData\')

%% import

AirTemp = readtable('Air_Temp_C.csv','PreserveVariableNames',1);
A_DT = datetime(table2array(AirTemp(:,1)),'Format','MM/dd/yyyy HH:mm:ss');
A_F = table2array(AirTemp(:,2));

RH = readtable('RH_Percent.csv','PreserveVariableNames',1);
RH_DT = datetime(table2array(RH(:,1)),'Format','MM/dd/yyyy HH:mm:ss');
RH_F = table2array(RH(:,2));

SW = readtable('SW_Wm2.csv','PreserveVariableNames',1);
SW_DT = datetime(table2array(SW(:,1)),'Format','MM/dd/yyyy HH:mm:ss');
SW_F = table2array(SW(:,2));

W = readtable('Wind_ms.csv','PreserveVariableNames',1);
W_DT = datetime(table2array(W(:,1)),'Format','MM/dd/yyyy HH:mm:ss');
W_F = table2array(W(:,2));


%% plotting
figure
plot(A_DT,A_F)
xlabel('DATETIME')
ylabel(['Air Temp (' char(176) 'C)'])

figure
plot(RH_DT,RH_F)
xlabel('DATETIME')
ylabel('Relative Humidity (%)')

figure
bar(W_DT,W_F)
xlabel('DATETIME')
ylabel('Wind (m/s)')

% %% writing out
% filename = 'AirTemp_C.csv';
% TABLE = table(A_DT,A_F,'VariableNames',{'DATETIME','VALUE'});
% writetable(TABLE,filename);
% 
% filename = 'RH_percent.csv';
% TABLE = table(RH_DT,RH_F,'VariableNames',{'DATETIME','VALUE'});
% writetable(TABLE,filename);
% 
% filename = 'sw_wm2.csv';
% TABLE = table(SW_DT,SW_F,'VariableNames',{'DATETIME','VALUE'});
% writetable(TABLE,filename);