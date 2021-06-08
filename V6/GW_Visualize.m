%% plotting groundwater inflows

%% clearing functions
clear
clc
close all

%% Set directory

cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\SWMM Files\')
%% Import Data for Section 1

Total_CMS = 0;
k = dir('New_GW*.dat');
t = 16;
figure;
for i = 1:length(k)
    
    %%import
    filepath = fullfile(k(i).folder,k(i).name);
    data = readtable(filepath,'PreserveVariableNames',1);
    
    %Create the extra column
    Date = datenum(table2array(data(:,1)));
    Time = datenum(table2array(data(:,2)));
    CMS_length(:,i) = datenum(table2array(data(:,3)));
    DateTimeNumber = Date+Time;
    DateTime(:,i) = datetime(DateTimeNumber,'ConvertFrom','datenum');
    
    %% plotting
    plot(DateTime(:,i), CMS_length(:,i),'-b')
    hold on
    xlabel('CMS/m')
    ylabel('Date')
    
    if i == t
        Total_CMS = CMS_length(:,i)*1100 + Total_CMS;
    else
        Total_CMS = CMS_length(:,i)*1500 + Total_CMS;
    end
    
end
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\');

%import measured flow at WB (15min)
measured_GageDs = xlsread('Compiled_FlowInputs_Verified','Webberville - LCRA', 'H3:H5858'); %CMS
measured_GageDs_t = xlsread('Compiled_FlowInputs_Verified','Webberville - LCRA', 'F3:F5858'); %Julian Date

date = datetime(measured_GageDs_t+693960,'ConvertFrom','datenum');
figure;
plot(date,measured_GageDs,'-k')
xlabel('Date')
hold on
yyaxis right
%plot(datem,New_Flows,'-b')
plot(DateTime(:,t),Total_CMS,'-b')
set(gca,'YColor','b')
ylabel('Flow (CMS)')
xlim([DateTime(1,t) DateTime(end,t)]);
legend ('Measured','GW')

check = 0;
for i = 1:length(Total_CMS)
    if Total_CMS (i) <= 0
        check = check + 1;
    else
    end
end
p_time = (check/length(Total_CMS))*100;

disp(p_time)
%%
%% Import Data for Section 2
clear;
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\SWMM Files\')
Total_CMS = 0;
m = dir('GW_Sect2_*.dat');
t = 14;
figure;
for i = 1:length(m)
    
    %%import
    filepath = fullfile(m(i).folder,m(i).name);
    data = readtable(filepath,'PreserveVariableNames',1);
    
    %Create the extra column
    Date = datenum(table2array(data(:,1)));
    Time = datenum(table2array(data(:,2)));
    CMS_length(:,i) = datenum(table2array(data(:,3)));
    DateTimeNumber = Date+Time;
    DateTime(:,i) = datetime(DateTimeNumber,'ConvertFrom','datenum');
    
    %% plotting
    plot(DateTime(:,i), CMS_length(:,i),'-b')
    hold on
    xlabel('CMS/m')
    ylabel('Date')
    
    if i == t
        Total_CMS = CMS_length(:,i)*1000 + Total_CMS;
    else
        Total_CMS = CMS_length(:,i)*1500 + Total_CMS;
    end
    
end
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\');

%import measured flow at WB (15min)
measured_GageDs = xlsread('Compiled_FlowInputs_Verified','Utley - LCRA', 'H3:H5858'); %CMS
measured_GageDs_t = xlsread('Compiled_FlowInputs_Verified','Utley - LCRA', 'F3:F5858'); %Julian Date

date = datetime(measured_GageDs_t+693960,'ConvertFrom','datenum');
figure;
plot(date,measured_GageDs,'-k')
xlabel('Date')
hold on
yyaxis right
%plot(datem,New_Flows,'-b')
plot(DateTime(:,t),Total_CMS,'-b')
set(gca,'YColor','b')
ylabel('Flow (CMS)')
xlim([DateTime(1,t) DateTime(end,t)]);
legend ('Measured','GW')

check1 = 0;
for i = 1:length(Total_CMS)
    if Total_CMS (i) <= 0
        check1 = check1 + 1;
    else
    end
end
p_time1 = (check1/length(Total_CMS))*100;
disp(p_time1)
%%
%% Import Data for Scetion 3
clear;
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\SWMM Files\')
Total_CMS = 0;
n = dir('GW_Sect3_*.dat');
t = 9;
figure;
for i = 1:length(n)
    
    %%import
    filepath = fullfile(n(i).folder,n(i).name);
    data = readtable(filepath,'PreserveVariableNames',1);
    
    %Create the extra column
    Date = datenum(table2array(data(:,1)));
    Time = datenum(table2array(data(:,2)));
    CMS_length(:,i) = datenum(table2array(data(:,3)));
    DateTimeNumber = Date+Time;
    DateTime(:,i) = datetime(DateTimeNumber,'ConvertFrom','datenum');
    
    %% plotting
    plot(DateTime(:,i), CMS_length(:,i),'-b')
    hold on
    xlabel('CMS/m')
    ylabel('Date')
    
    if i == t
        Total_CMS = CMS_length(:,i)*300 + Total_CMS;
    else
        Total_CMS = CMS_length(:,i)*1500 + Total_CMS;
    end
    
end
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\');

%import measured flow at WB (15min)
measured_GageDs = xlsread('Compiled_FlowInputs_Verified','Bastrop - USGS','K3:K17270'); %CMS
measured_GageDs_t = xlsread('Compiled_FlowInputs_Verified','Bastrop - USGS','I3:I17270'); %Julian Date

date = datetime(measured_GageDs_t+693960,'ConvertFrom','datenum');
figure;
plot(date,measured_GageDs,'-k')
xlabel('Date')
hold on
yyaxis right
%plot(datem,New_Flows,'-b')
plot(DateTime(:,t),Total_CMS,'-b')
set(gca,'YColor','b')
ylabel('Flow (CMS)')
xlim([DateTime(1,t) DateTime(end,t)]);
legend ('Measured','GW')

check2 = 0;
for i = 1:length(Total_CMS)
    if Total_CMS (i) <= 0
        check2 = check2 + 1;
    else
    end
end

p_time2 = (check2/length(Total_CMS))*100;
disp(p_time2)