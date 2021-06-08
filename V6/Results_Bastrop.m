%% View Results

%% Clearing 
clear
clc
close all

%% Set Directory
%Downstream
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\')

%import measured flow at WB (15min)
measured_GageDs = xlsread('Compiled_FlowInputs_Verified','Bastrop - USGS','K3:K17270'); %CMS
measured_GageDs_t = xlsread('Compiled_FlowInputs_Verified','Bastrop - USGS','I3:I17270'); %Julian Date

cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\Results\')

link_g = 2950;
%% Import Data

depth = readtable('LCR_PreStorm_link_depth.csv');
Depth = table2array(depth(:,2:end));
flow = readtable('LCR_PreStorm_link_flow_rate.csv');
Flow = table2array(flow(:,2:end));
velocity = readtable('LCR_PreStorm_link_velocity.csv');
Velocity = table2array(velocity(:,2:end));
DateTime = table2array(depth(:,1));

%%
LINKS = erase(convertCharsToStrings(depth.Properties.VariableNames),"L_");
LINKS = LINKS(2:end); %removes DateTimeColumn
for i = 1:size(LINKS,2)
    Links(i) = str2num(LINKS(i));
end

%% Gage Location
indGage = find(Links == link_g);
DSGAGE = indGage; %index location of the downstream gage

%% Color maps

ColorLink = fliplr(jet);
ColorTime = fliplr(parula);

n = size(Flow,2);
n1 = size(Flow,1);
cind = round(linspace(1,length(ColorLink),n));
cindlink = round(linspace(1,length(ColorTime),n1));

%% Plotting Depth
figure
for i = 2:size(Depth,2)
    plot(DateTime,Depth(:,i),'Color',ColorLink(cind(i),:))
    hold on
end
xlabel('Date')
ylabel('Depth (m)')

figure
for i = 1:size(Depth,1)
    plot(Links,Depth(i,:)','Color',ColorTime(cindlink(i),:))
    hold on
end
xlabel('Link')
ylabel('Depth (m)')
set(gca, 'XDir','reverse')

%% Plotting Velocity
figure
for i = 2:size(Velocity,2)
    plot(DateTime,Velocity(:,i),'Color',ColorLink(cind(i),:))
    
    hold on
end
xlabel('Date')
ylabel('Velocity (m/s)')

figure
for i = 1:size(Velocity,1)
    plot(Links,Velocity(i,:)','Color',ColorTime(cindlink(i),:))
    hold on
end
xlabel('Link')
ylabel('Velocity (m/s)')
set(gca, 'XDir','reverse')
%% Plotting Flow
figure
for i = 2:size(Flow,2)
    plot(DateTime,Flow(:,i),'Color',ColorLink(cind(i),:))
    hold on
end
xlabel('Date')
ylabel('Flow (CMS)')

figure
for i = 1:size(Flow,1)
    plot(Links,Flow(i,:)','Color',ColorTime(cindlink(i),:))
    hold on
end
xlabel('Link')
ylabel('Flow (CMS)')
set(gca, 'XDir','reverse')
%%
%% Importing measured data for statistical analysis
%%
%% Importing Data

%import SWMM at WB no GW
modeled_GageDs  = Flow(:,DSGAGE);
modeled_GageDs_t  = datenum(DateTime);

%% specifying the date range of interest

%startdate = input('What is the start date for the time period of interest? Format as dd-mmm-yyyy: ' ,'s');
startdate = '07-aug-2016';
DateString = startdate;
formatIn = 'dd-mmm-yyyy';
start = datenum(DateString, formatIn);

%enddate = input('What is the end date for the time period of interest? Format as dd-mmm-yyyy: ' ,'s');
enddate = '11-aug-2016';
DateString1 = enddate;
End = datenum(DateString1, formatIn);

%% cropping flow data
timeQ = measured_GageDs_t+693960;
[row,col] = find(timeQ > start & timeQ < End); %finds index of data between start and end dates
measured_GageDs_t = timeQ(row);
measured_GageDs = measured_GageDs(row);

timeQ2 = modeled_GageDs_t;
[row,col] = find(timeQ2 > start & timeQ2 < End); %finds index of data between start and end dates
modeled_GageDs_t = timeQ2(row);
modeled_GageDs = modeled_GageDs(row);

%% aligning dates
st = modeled_GageDs_t(1);
En = modeled_GageDs_t(end);
StepSize = modeled_GageDs_t(2)-modeled_GageDs_t(1);
InterpAt = st:StepSize:En;

%%%%%%%%%%%%%% Interpolating %%%%%%%%%%%%%%%%%%%%%

%Walnut
Interp_CMS_model = interp1(modeled_GageDs_t,modeled_GageDs,InterpAt);
Interp_CMS_measure = interp1(measured_GageDs_t,measured_GageDs,InterpAt);

measured_GageDs_t = InterpAt';
modeled_GageDs_t = InterpAt';

measured_GageDs = Interp_CMS_measure';
modeled_GageDs = Interp_CMS_model';
%% timeseries plots

%measured
date = datetime(measured_GageDs_t,'ConvertFrom','datenum');
date1 = datetime(modeled_GageDs_t,'ConvertFrom','datenum');
figure
plot(date,measured_GageDs,'-k')
hold on
%modeled
plot(date1,modeled_GageDs,'--r')
xlabel('Date')
ylabel('Flow (CMS)')
%datetick('x','mm/dd')
legend('Measured','Modeled')
title('WB gaging station - 15min GW addition')

%% check that dates are aligned

for i = 1:length(measured_GageDs_t)
    if measured_GageDs_t(i) == modeled_GageDs_t(i);
    else
       disp('check dates')
    end
end

%% calc RMSE and Nash Sutcliffe and residuals
%sqrt[(1/n)(sum((predicted - actual)^2))]

for i = 1:length(modeled_GageDs)
    %RMSE
    raw_residual(i) = modeled_GageDs(i) - measured_GageDs(i);
    diff_sqr(i) = raw_residual(i)^2;
    
    %Nash sutcliffe
    raw_residual_NS(i) = measured_GageDs(i) - mean(measured_GageDs(:,1));
    diff_sqr_NS(i) = raw_residual_NS(i)^2;
end

RMSE = sqrt((1/length(modeled_GageDs))*(sum(diff_sqr)))

%nash sutcliffe
Ef = 1 - sum(diff_sqr)/sum(diff_sqr_NS)

%plotting residuals
figure
scatter(date,raw_residual,10,'ok','filled')
xlabel('Date')
%xlim([measured_GageDs_t(1),measured_GageDs_t(end)])
%datetick('x','mm/yyyy')
ylabel('Residuals')
title('Raw Flow Residuals')

figure
qqplot(raw_residual)