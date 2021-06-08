%% RESULTS PLOTTING CSH

%% CLEARING FUNCTIONS
clear;
clc;
close all;

%% LINK Index LOCATIONS (remember it is flipped)
HGZ_L = 111 ;
GG_L = 547 ;
WB_L = 336 ;
US1_L = 28 ;
DS1_L = 52 ; %below walnut creek also
US2_L = 226 ;
UT_L = 652 ;
B_L = 895 ;
HWY_L = 1 ;

%% READ IN ALL MEASURED DATA 
% flow data from gages, temperature probes
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V6\');
Time_probes = datetime(xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','A4:A4724')+693960,'ConvertFrom','datenum');
HGZ_Temp = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','G4:G4724');
GG_Temp = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','K4:K4724');
WB_Temp = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','J4:J4724');
US1_Temp = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','D4:D4724');
DS1_Temp = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','F4:F4724');
US2_Temp = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','H4:H4724');

UT_flow = xlsread('Compiled_FlowInputs_Verified','Utley - LCRA', 'H3:H5858'); %CMS;
B_flow = xlsread('Compiled_FlowInputs_Verified','Bastrop - USGS','K3:K17270'); %CMS;
WB_flow = xlsread('Compiled_FlowInputs_Verified','Webberville - LCRA', 'H3:H5858'); %CMS;
HWY_flow = xlsread('Compiled_FlowInputs_Verified','HWY 183 - USGS', 'K3:K17557'); %CMS;

% UT_flow_t = ;
B_flow_t = datetime(xlsread('Compiled_FlowInputs_Verified','Bastrop - USGS','I3:I17270')+693960,'ConvertFrom','datenum'); %Julian Date
WB_flow_t = datetime(xlsread('Compiled_FlowInputs_Verified','Webberville - LCRA', 'F3:F5858')+693960,'ConvertFrom','datenum'); %Julian Date;
UT_flow_t = datetime(xlsread('Compiled_FlowInputs_Verified','Utley - LCRA', 'F3:F5858')+693960,'ConvertFrom','datenum'); %Julian Date;
HWY_flow_t = datetime(xlsread('Compiled_FlowInputs_Verified','HWY 183 - USGS', 'I3:I17557')+693960,'ConvertFrom','datenum'); %Julian Date
%%
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V6\CSH\UpstreamBC');
HWY_Temp = readtable('HWY183Temp.csv','PreserveVariableNames',1);
HWY_Temp_t = table2array(HWY_Temp(:,1));
HWY_Temp = table2array(HWY_Temp(:,2));
%% IMPORT RESULTS FROM MODEL RUN 
filename_csh = 'C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V6\CSH\LCR_csh.nc';
filename_rhe = 'C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V6\RHE\LCR_rhe.nc';
filename_hts = 'C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V6\HTS\LCR_hts.nc';

VarNames_CSH = {'temperature','flow','element_conv_heat_flux','element_evap_heat_flux'};
VarNames_RHE = {'channel_temperature','incoming_shortwave_solar_radiation','atmospheric_longwave_radiation','back_longwave_radiation'};
VarNames_HTS = {'channel_advection_heat_flux','channel_conduction_heat_flux','ground_conduction_heat_flux'};
time_CSH = datetime(ncread(filename_csh,'time'),'ConvertFrom','juliandate');
time_RHE = datetime(ncread(filename_rhe,'time'),'ConvertFrom','juliandate');
time_HTS = datetime(ncread(filename_hts,'time'),'ConvertFrom','juliandate');


%import CSH
for i = 1:length(VarNames_CSH)
    data_csh{i} = ncread(filename_csh,VarNames_CSH{i});
end

%import RHE
for i = 1:length(VarNames_RHE)
    data_rhe{i} = ncread(filename_rhe,VarNames_RHE{i});
end

%import HTS
for i = 1:length(VarNames_HTS)
    data_hts{i} = ncread(filename_hts,VarNames_HTS{i});
end

%link, timestamp
%% Color maps
Link = 1:1:size(data_csh{1},1);
ColorLink = fliplr(jet);
ColorTime = fliplr(parula);

n = size(data_csh{1},1);
n1 = size(data_csh{1},2);
cind = round(linspace(1,length(ColorLink),n));
cindlink = round(linspace(1,length(ColorTime),n1));

%% plotting
CSH_PlotNames = {['Temperature [' char(176) 'C]'],'Flow [CMS]','Convective Heat Flux [W/m^{2}]','Evaporative Heat Flux [W/m^{2}]'};
for i = 1:length(data_csh)
    data = data_csh{i};
    
    figure
    for j = 1:size(data,1)
        plot(time_CSH,data(j,:),'Color',ColorLink(cind(j),:))
        hold on
    end
    xlabel('DateTime')
    ylabel(CSH_PlotNames{i})
    
    figure
    for k = 1:size(data,2)
        plot(Link,data(:,k),'Color',ColorTime(cindlink(k),:))
        hold on
    end
    
    xlabel('Links')
    ylabel(CSH_PlotNames{i})
    
end

RHE_PlotNames = {['Temperature [' char(176) 'C]'],'Incoming Shortwave [W/m^{2}]','Atmospheric Longwave [W/m^{2}]','Back Longwave [W/m^{2}]'};
for i = 1:length(data_rhe)
    data = data_rhe{i};
    
    figure
    for j = 1:size(data,1)
        plot(time_RHE,data(j,:),'Color',ColorLink(cind(j),:))
        hold on
    end
    xlabel('DateTime')
    ylabel(RHE_PlotNames{i})
    
    figure
    for k = 1:size(data,2)
        plot(Link,data(:,k),'Color',ColorTime(cindlink(k),:))
        hold on
    end
    
    xlabel('Links')
    ylabel(RHE_PlotNames{i})
    
end


HTS_PlotNames = {'Channel Advection [W/m^{2}]','Bed Conduction [W/m^{2}]','Ground Conduction [W/m^{2}]'};
for i = 1:length(data_hts)
    data = data_hts{i};
    
    figure
    for j = 1:size(data,1)
        plot(time_HTS,data(j,:),'Color',ColorLink(cind(j),:))
        hold on
    end
    xlabel('DateTime')
    ylabel(HTS_PlotNames{i})
    
    figure
    for k = 1:size(data,2)
        plot(Link,data(:,k),'Color',ColorTime(cindlink(k),:))
        hold on
    end
    
    xlabel('Links')
    ylabel(HTS_PlotNames{i})
    
end
%% Plot Temperature


figure
plot(HWY_Temp_t, HWY_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(HWY_L,:), '--r')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('HWY')

figure
plot(Time_probes, US1_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(US1_L,:), '--r')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('US1')

figure
plot(Time_probes, DS1_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(DS1_L,:), '--r')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('DS1')

figure
plot(Time_probes, HGZ_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(HGZ_L,:), '--r')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('HGZ')

figure
plot(Time_probes, US2_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(US2_L,:), '--r')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('US2')

figure
plot(Time_probes, WB_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(WB_L,:), '--r')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('WB')

figure
plot(Time_probes, GG_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(GG_L,:), '--r')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('GG')

%% Plotting fluxes

%assigning fluxes
Jc = data_csh{3};
Je = data_csh{4};
Jsn = data_rhe{2};
Jan = data_rhe{3};
Jbr = data_rhe{4};
Jhts = data_hts{1};
Jsed = data_hts{2};
Jgr = data_hts{3};

%HWY
figure
LLL = HWY_L;
plot(time_CSH, Jc(LLL,:),'-r')
hold on
plot(time_CSH, Je(LLL,:),'-','Color',[235/255, 183/255, 52/255])
hold on
plot(time_RHE, Jsn(LLL,:),'-g')
hold on
plot(time_RHE, Jan(LLL,:),'-c')
hold on
plot(time_RHE, Jbr(LLL,:),'-b')
hold on
plot(time_HTS, -Jhts(LLL,:),'-m')
hold on
plot(time_HTS, -Jsed(LLL,:),'-k')
hold on
plot(time_HTS, Jgr(LLL,:),'-','Color',[156/255, 107/255, 136/255])

xlabel('DateTime')
ylabel('Heat Flux [W/m^{2}]')
legend('Convective','Evaporative','Solar Short Wave','Atm Long Wave','Back Radiation','HTS','Sediment Conduction','Ground Conduction')
title('HWY183')

%US1
figure
LLL = US1_L;
plot(time_CSH, Jc(LLL,:),'-r')
hold on
plot(time_CSH, Je(LLL,:),'-','Color',[235/255, 183/255, 52/255])
hold on
plot(time_RHE, Jsn(LLL,:),'-g')
hold on
plot(time_RHE, Jan(LLL,:),'-c')
hold on
plot(time_RHE, Jbr(LLL,:),'-b')
hold on
plot(time_HTS, -Jhts(LLL,:),'-m')
hold on
plot(time_HTS, -Jsed(LLL,:),'-k')
hold on
plot(time_HTS, Jgr(LLL,:),'-','Color',[156/255, 107/255, 136/255])

xlabel('DateTime')
ylabel('Heat Flux [W/m^{2}]')
legend('Convective','Evaporative','Solar Short Wave','Atm Long Wave','Back Radiation','HTS','Sediment Conduction','Ground Conduction')
title('US1')

%DS1
figure
LLL = DS1_L;
plot(time_CSH, Jc(LLL,:),'-r')
hold on
plot(time_CSH, Je(LLL,:),'-','Color',[235/255, 183/255, 52/255])
hold on
plot(time_RHE, Jsn(LLL,:),'-g')
hold on
plot(time_RHE, Jan(LLL,:),'-c')
hold on
plot(time_RHE, Jbr(LLL,:),'-b')
hold on
plot(time_HTS, -Jhts(LLL,:),'-m')
hold on
plot(time_HTS, -Jsed(LLL,:),'-k')
hold on
plot(time_HTS, Jgr(LLL,:),'-','Color',[156/255, 107/255, 136/255])

xlabel('DateTime')
ylabel('Heat Flux [W/m^{2}]')
legend('Convective','Evaporative','Solar Short Wave','Atm Long Wave','Back Radiation','HTS','Sediment Conduction','Ground Conduction')
title('DS1')

%HGZ
figure
LLL = HGZ_L;
plot(time_CSH, Jc(LLL,:),'-r')
hold on
plot(time_CSH, Je(LLL,:),'-','Color',[235/255, 183/255, 52/255])
hold on
plot(time_RHE, Jsn(LLL,:),'-g')
hold on
plot(time_RHE, Jan(LLL,:),'-c')
hold on
plot(time_RHE, Jbr(LLL,:),'-b')
hold on
plot(time_HTS, -Jhts(LLL,:),'-m')
hold on
plot(time_HTS, -Jsed(LLL,:),'-k')
hold on
plot(time_HTS, Jgr(LLL,:),'-','Color',[156/255, 107/255, 136/255])

xlabel('DateTime')
ylabel('Heat Flux [W/m^{2}]')
legend('Convective','Evaporative','Solar Short Wave','Atm Long Wave','Back Radiation','HTS','Sediment Conduction','Ground Conduction')
title('HGZ')

%US2
figure
LLL = US2_L;
plot(time_CSH, Jc(LLL,:),'-r')
hold on
plot(time_CSH, Je(LLL,:),'-','Color',[235/255, 183/255, 52/255])
hold on
plot(time_RHE, Jsn(LLL,:),'-g')
hold on
plot(time_RHE, Jan(LLL,:),'-c')
hold on
plot(time_RHE, Jbr(LLL,:),'-b')
hold on
plot(time_HTS, -Jhts(LLL,:),'-m')
hold on
plot(time_HTS, -Jsed(LLL,:),'-k')
hold on
plot(time_HTS, Jgr(LLL,:),'-','Color',[156/255, 107/255, 136/255])

xlabel('DateTime')
ylabel('Heat Flux [W/m^{2}]')
legend('Convective','Evaporative','Solar Short Wave','Atm Long Wave','Back Radiation','HTS','Sediment Conduction','Ground Conduction')
title('US2')

%WB
figure
LLL = WB_L;
plot(time_CSH, Jc(LLL,:),'-r')
hold on
plot(time_CSH, Je(LLL,:),'-','Color',[235/255, 183/255, 52/255])
hold on
plot(time_RHE, Jsn(LLL,:),'-g')
hold on
plot(time_RHE, Jan(LLL,:),'-c')
hold on
plot(time_RHE, Jbr(LLL,:),'-b')
hold on
plot(time_HTS, -Jhts(LLL,:),'-m')
hold on
plot(time_HTS, -Jsed(LLL,:),'-k')
hold on
plot(time_HTS, Jgr(LLL,:),'-','Color',[156/255, 107/255, 136/255])

xlabel('DateTime')
ylabel('Heat Flux [W/m^{2}]')
legend('Convective','Evaporative','Solar Short Wave','Atm Long Wave','Back Radiation','HTS','Sediment Conduction','Ground Conduction')
title('WB')

%GG
figure
LLL = GG_L;
plot(time_CSH, Jc(LLL,:),'-r')
hold on
plot(time_CSH, Je(LLL,:),'-','Color',[235/255, 183/255, 52/255])
hold on
plot(time_RHE, Jsn(LLL,:),'-g')
hold on
plot(time_RHE, Jan(LLL,:),'-c')
hold on
plot(time_RHE, Jbr(LLL,:),'-b')
hold on
plot(time_HTS, -Jhts(LLL,:),'-m')
hold on
plot(time_HTS, -Jsed(LLL,:),'-k')
hold on
plot(time_HTS, Jgr(LLL,:),'-','Color',[156/255, 107/255, 136/255])

xlabel('DateTime')
ylabel('Heat Flux [W/m^{2}]')
legend('Convective','Evaporative','Solar Short Wave','Atm Long Wave','Back Radiation','HTS','Sediment Conduction','Ground Conduction')
title('GG')


%% plotting flows
%HWY
figure
F = data_csh{2};
plot(time_CSH, F(HWY_L,:),'--r')
hold on
plot(HWY_flow_t,HWY_flow,'-k')
xlim([time_CSH(1) time_CSH(end)])
xlabel('DateTime')
ylabel('Flow [CMS]')
legend('Modeled','Measured')
title('HWY')


%WB
figure
F = data_csh{2};
plot(time_CSH, F(WB_L,:),'--r')
hold on
plot(WB_flow_t,WB_flow,'-k')
xlim([time_CSH(1) time_CSH(end)])
xlabel('DateTime')
ylabel('Flow [CMS]')
legend('Modeled','Measured')
title('WB')

%Utley
figure
plot(time_CSH, F(UT_L,:),'--r')
hold on
plot(UT_flow_t,UT_flow,'-k')
xlim([time_CSH(1) time_CSH(end)])
xlabel('DateTime')
ylabel('Flow [CMS]')
legend('Modeled','Measured')
title('UT')

%Bastrop
figure
plot(time_CSH, F(B_L,:),'--r')
hold on
plot(B_flow_t,B_flow,'-k')
xlim([time_CSH(1) time_CSH(end)])
xlabel('DateTime')
ylabel('Flow [CMS]')
legend('Modeled','Measured')
title('B')

%% avg hourly temp

index = 60; %60, 1 minute intervals
nn = index*24; %minutes
a = T(US1_L,:);
b = arrayfun(@(i) mean(a(i:i+nn-1)),1:nn:length(a)-nn+1)'; % the averaged vector
New_Time = arrayfun(@(i) time_CSH(i+nn-1),1:nn:length(a)-nn+1)';
N_T = [New_Time(1) - duration(0,nn,0); New_Time(1:length(New_Time)-1)];

indexa = 1; %1, 15 minute interval
c = Time_probes(44:end);
nna = indexa*4*24; %minutes
aa = US1_Temp(44:end);
ba = arrayfun(@(i) mean(aa(i:i+nna-1)),1:nna:length(aa)-nna+1)'; % the averaged vector
New_Timea = arrayfun(@(i) c(i+nna-1),1:nna:length(aa)-nna+1)';
N_Ta = [New_Timea(1) - duration(0,nna,0); New_Timea(1:length(New_Timea)-1)];

figure
plot(Time_probes, US1_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(US1_L,:), '--r')
hold on
stairs(N_T, b, '--b')
hold on
stairs(N_Ta, ba, '--c')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('US1')
legend('Measured','Modeled','Mean Daily Modeled','Mean Daily Measured')
xlim([time_CSH(1) N_T(end)])
ylim([24 34])

%%%%%%%%%%%%%%%%%%
index = 60; %60, 1 minute intervals
nn = index*24; %minutes
a = T(DS1_L,:);
b = arrayfun(@(i) mean(a(i:i+nn-1)),1:nn:length(a)-nn+1)'; % the averaged vector
New_Time = arrayfun(@(i) time_CSH(i+nn-1),1:nn:length(a)-nn+1)';
N_T = [New_Time(1) - duration(0,nn,0); New_Time(1:length(New_Time)-1)];

indexa = 1; %1, 15 minute interval
c = Time_probes(44:end);
nna = indexa*4*24; %minutes
aa = DS1_Temp(44:end);
ba = arrayfun(@(i) mean(aa(i:i+nna-1)),1:nna:length(aa)-nna+1)'; % the averaged vector
New_Timea = arrayfun(@(i) c(i+nna-1),1:nna:length(aa)-nna+1)';
N_Ta = [New_Timea(1) - duration(0,nna,0); New_Timea(1:length(New_Timea)-1)];

figure
plot(Time_probes, DS1_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(DS1_L,:), '--r')
hold on
stairs(N_T, b, '--b')
hold on
stairs(N_Ta, ba, '--c')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('DS1')
legend('Measured','Modeled','Mean Daily Modeled','Mean Daily Measured')
xlim([time_CSH(1) N_T(end)])
ylim([24 34])

%%%%%%%%%%%%%%%%%%
index = 60; %60, 1 minute intervals
nn = index*24; %minutes
a = T(HGZ_L,:);
b = arrayfun(@(i) mean(a(i:i+nn-1)),1:nn:length(a)-nn+1)'; % the averaged vector
New_Time = arrayfun(@(i) time_CSH(i+nn-1),1:nn:length(a)-nn+1)';
N_T = [New_Time(1) - duration(0,nn,0); New_Time(1:length(New_Time)-1)];

indexa = 1; %1, 15 minute interval
c = Time_probes(44:end);
nna = indexa*4*24; %minutes
aa = HGZ_Temp(44:end);
ba = arrayfun(@(i) mean(aa(i:i+nna-1)),1:nna:length(aa)-nna+1)'; % the averaged vector
New_Timea = arrayfun(@(i) c(i+nna-1),1:nna:length(aa)-nna+1)';
N_Ta = [New_Timea(1) - duration(0,nna,0); New_Timea(1:length(New_Timea)-1)];

figure
plot(Time_probes, HGZ_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(HGZ_L,:), '--r')
hold on
stairs(N_T, b, '--b')
hold on
stairs(N_Ta, ba, '--c')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('HGZ')
legend('Measured','Modeled','Mean Daily Modeled','Mean Daily Measured')
xlim([time_CSH(1) N_T(end)])
ylim([24 34])

%%%%%%%%%%%%%%%%%%
index = 60; %60, 1 minute intervals
nn = index*24; %minutes
a = T(US2_L,:);
b = arrayfun(@(i) mean(a(i:i+nn-1)),1:nn:length(a)-nn+1)'; % the averaged vector
New_Time = arrayfun(@(i) time_CSH(i+nn-1),1:nn:length(a)-nn+1)';
N_T = [New_Time(1) - duration(0,nn,0); New_Time(1:length(New_Time)-1)];

indexa = 1; %1, 15 minute interval
c = Time_probes(44:end);
nna = indexa*4*24; %minutes
aa = US2_Temp(44:end);
ba = arrayfun(@(i) mean(aa(i:i+nna-1)),1:nna:length(aa)-nna+1)'; % the averaged vector
New_Timea = arrayfun(@(i) c(i+nna-1),1:nna:length(aa)-nna+1)';
N_Ta = [New_Timea(1) - duration(0,nna,0); New_Timea(1:length(New_Timea)-1)];

figure
plot(Time_probes, US2_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(US2_L,:), '--r')
hold on
stairs(N_T, b, '--b')
hold on
stairs(N_Ta, ba, '--c')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('US2')
legend('Measured','Modeled','Mean Daily Modeled','Mean Daily Measured')
xlim([time_CSH(1) N_T(end)])
ylim([24 34])

%%%%%%%%%%%%%%%%%%
index = 60; %60, 1 minute intervals
nn = index*24; %minutes
a = T(WB_L,:);
b = arrayfun(@(i) mean(a(i:i+nn-1)),1:nn:length(a)-nn+1)'; % the averaged vector
New_Time = arrayfun(@(i) time_CSH(i+nn-1),1:nn:length(a)-nn+1)';
N_T = [New_Time(1) - duration(0,nn,0); New_Time(1:length(New_Time)-1)];

indexa = 1; %1, 15 minute interval
c = Time_probes(44:end);
nna = indexa*4*24; %minutes
aa = WB_Temp(44:end);
ba = arrayfun(@(i) mean(aa(i:i+nna-1)),1:nna:length(aa)-nna+1)'; % the averaged vector
New_Timea = arrayfun(@(i) c(i+nna-1),1:nna:length(aa)-nna+1)';
N_Ta = [New_Timea(1) - duration(0,nna,0); New_Timea(1:length(New_Timea)-1)];

figure
plot(Time_probes, WB_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(WB_L,:), '--r')
hold on
stairs(N_T, b, '--b')
hold on
stairs(N_Ta, ba, '--c')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('WB')
legend('Measured','Modeled','Mean Daily Modeled','Mean Daily Measured')
xlim([time_CSH(1) N_T(end)])
ylim([24 34])

%%%%%%%%%%%%%%%%%%
index = 60; %60, 1 minute intervals
nn = index*24; %minutes
a = T(GG_L,:);
b = arrayfun(@(i) mean(a(i:i+nn-1)),1:nn:length(a)-nn+1)'; % the averaged vector
New_Time = arrayfun(@(i) time_CSH(i+nn-1),1:nn:length(a)-nn+1)';
N_T = [New_Time(1) - duration(0,nn,0); New_Time(1:length(New_Time)-1)];

indexa = 1; %1, 15 minute interval
c = Time_probes(44:end);
nna = indexa*4*24; %minutes
aa = GG_Temp(44:end);
ba = arrayfun(@(i) mean(aa(i:i+nna-1)),1:nna:length(aa)-nna+1)'; % the averaged vector
New_Timea = arrayfun(@(i) c(i+nna-1),1:nna:length(aa)-nna+1)';
N_Ta = [New_Timea(1) - duration(0,nna,0); New_Timea(1:length(New_Timea)-1)];

figure
plot(Time_probes, GG_Temp, '-k')
hold on
T = data_csh{1};
plot(time_CSH, T(GG_L,:), '--r')
hold on
stairs(N_T, b, '--b')
hold on
stairs(N_Ta, ba, '--c')
xlabel('DateTime')
ylabel(['Temperature [' char(176) 'C]'])
title('GG')
legend('Measured','Modeled','Mean Daily Modeled','Mean Daily Measured')

xlim([time_CSH(1) N_T(end)])
ylim([24 34])
