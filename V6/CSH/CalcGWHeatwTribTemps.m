%% Calculate heat for GW files 
%%% separation into a heat inflow file and a water outflow file

%% Clearing functions
clear
clc
close all
%% Import GW Temperature Data

%% Set Directory for temperature import
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\Organizing\')
% %% Import temperature data

Date_T = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','A4:A4710');
Date_T = datetime(Date_T + 693960,'ConvertFrom','datenum');
Onion_T = xlsread('LCR16_Compiled_Longitudinal_Data','Longitudinal Temperature','M4:M4710'); 
% %set directory
% cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V3\CSH\Well Data\')
% GG = readtable('GG_GW_Daily_Mean_Temp_degC.csv');
% Well_DT_GG = datetime(table2array(GG(:,1)),'Format','MM/dd/yyyy HH:mm:ss');
% Well_T_GG = table2array(GG(:,3)); %well nearest the river, P00
% HG = readtable('HG_GW_Daily_Mean_Temp_degC.csv');
% Well_DT_HG = datetime(table2array(HG(:,1)),'Format','MM/dd/yyyy HH:mm:ss');
% Well_T_HG = table2array(HG(:,3)); %well nearest the river, P00
% WB = readtable('WB_GW_Daily_Mean_Temp_degC.csv');
% Well_DT_WB = datetime(table2array(GG(:,1)),'Format','MM/dd/yyyy HH:mm:ss');
% Well_T_WB = table2array(WB(:,3)); %well nearest the river, P00

%% set section divisions

sectA = {'New_GW1.dat','New_GW2.dat','New_GW3.dat','New_GW4.dat','New_GW5.dat','New_GW6.dat','New_GW7.dat','New_GW8.dat','New_GW9.dat',...
         'New_GW10.dat','New_GW11.dat','New_GW12.dat','New_GW13.dat','New_GW14.dat','New_GW15.dat'}; %name of all files that are in this section
     
sectB = {'New_GW16.dat','New_GW16.dat','New_GW17.dat','New_GW18.dat','New_GW19.dat','New_GW20.dat','New_GW21.dat','New_GW22.dat',...
         'New_GW23.dat','GW_Sect2_1.dat','GW_Sect2_2.dat','GW_Sect2_3.dat','GW_Sect2_4.dat','GW_Sect2_5.dat','GW_Sect2_6.dat',...
         'GW_Sect2_7.dat'};%name of all files that are in this section
     
sectC = {'GW_Sect2_8.dat','GW_Sect2_9.dat','GW_Sect2_10.dat','GW_Sect2_11.dat','GW_Sect2_12.dat','GW_Sect2_13.dat','GW_Sect2_14.dat',...
         'GW_Sect2_15.dat','GW_Sect2_16.dat','GW_Sect2_17.dat','GW_Sect2_18.dat','GW_Sect2_19.dat','GW_Sect2_20.dat','GW_Sect2_21.dat'...
         'GW_Sect3_1.dat','GW_Sect3_2.dat','GW_Sect3_3.dat','GW_Sect3_4.dat','GW_Sect3_5.dat','GW_Sect3_6.dat','GW_Sect3_7.dat',...
         'GW_Sect3_8.dat','GW_Sect3_9.dat','GW_Sect3_10.dat','GW_Sect3_11.dat','GW_Sect3_12.dat','GW_Sect3_13.dat','GW_Sect3_14.dat',...
         'GW_Sect3_15.dat','GW_Sect3_16.dat','GW_Sect3_17.dat'};%name of all files that are in this section
     
%% set working directory
cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\SWMM\SWMM6 - PreStorm\Full Model\SWMM Files\')

%% set constants
L = 100; %Length of a model cell, [m]
ro = 1000; %density of water, [kg/m3]
Cp = 4184; %specific heat capcity, [J/kg degC]
%T_gw = 30;% deg C
%%
k = dir('*GW*.dat'); %% look for any groundwater files

for i = 1:length(k)
    filename = fullfile(k(i).folder,k(i).name); %define the filename
    fid = fopen(filename,'r'); %open the file
    data = textscan(fid,'%s%s%f%[^\n\r]','HeaderLines',1,'Delimiter','\t');
    dt = datetime(strcat(char(data{1}),{' '},char(data{2})));
    dt = datetime(dt, 'Format','MM/dd/yyyy HH:mm:ss');
    dv = data{3}; %CMS/length
    heat_gw = []; %reset as empty variable each time
    new_gw = []; %reset as empty variable each time
    
    % file indexing for organization
    d = ismember(k(i).name,sectA);
    e = ismember(k(i).name,sectB);
    f = ismember(k(i).name,sectC);

    %% HERGOTZ
    if d == 1
        for j = 1:length(dv)

            %heat inflow
            if dv(j) > 0 %if flow is positive, calculate heat inflow
                
                %interpolate trib at timestep of groundwater, 
                ST = dt(1);
                ED = dt(end);
                interval = dt(2) - dt(1);
                interptime = ST:interval:ED;
                
                InterpTemp = interp1(Date_T,Onion_T,interptime,'linear');
                T_gw = InterpTemp(find(datenum(interptime) == datenum(dt(j))));
                
%                 %find temperature that corresponds to the same date
%                 T_gw = Well_T_HG(find(floor(datenum(Well_DT_HG)) == floor(datenum(dt(j)))));
                %calculate heat
                heat_gw(j,1) = dv(j).*ro.*Cp.*T_gw; %CMS/L * kg/m3 * [J/kg degC] = Watt/m
            elseif dv(j) <= 0 %else, set heat to 0
                heat_gw(j,1) = 0; 
            end

            %GW outflow
            if dv(j) > 0 %if flow is positive, set to 0
                new_gw(j,1) = 0;
            elseif dv(j) <= 0 %if flow is zero or negative, keep value
                new_gw(j,1) = dv(j);
            end
        end

        %formatting tables
        VNs = {';DateTime','Heat (WATT/m)'};
        VNs1 = {';DateTime','Flow CMS/m'};
        Table_Heat = table(dt, heat_gw, 'VariableNames',VNs);
        Table_Outflow = table(dt, new_gw, 'VariableNames',VNs1);

%         %% set export directory
%         cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V4\CSH\GWHeat\GW_heat_watts_per_meter_in');
%         %% writing tables
%         filename1 = [erase(k(i).name,".dat"),'_heat_in_watts_per_meter.csv'];
%         writetable(Table_Heat,filename1,'Delimiter',',')
% 
%         %% set export directory
%         cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V4\CSH\GWHeat\GW_outflows_CMS_per_meter');
%         %% writing tables
%         filename2 = [erase(k(i).name,".dat"),'_outflow_CMS_per_meter.csv'];
%         writetable(Table_Outflow,filename2,'Delimiter',',')
    
%% WEBBERVILLE
    elseif e == 1
        for j = 1:length(dv)

            %heat inflow
            if dv(j) > 0 %if flow is positive, calculate heat inflow
                %interpolate trib at timestep of groundwater, 
                ST = dt(1);
                ED = dt(end);
                interval = dt(2) - dt(1);
                interptime = ST:interval:ED;
                
                InterpTemp = interp1(Date_T,Onion_T,interptime,'linear');
                T_gw = InterpTemp(find(datenum(interptime) == datenum(dt(j))));
                
%                 %find temperature that corresponds to the same date
%                 T_gw = Well_T_WB(find(floor(datenum(Well_DT_WB)) == floor(datenum(dt(j)))));
                %calculate heat
                heat_gw(j,1) = dv(j).*ro.*Cp.*T_gw; %CMS/L * kg/m3 * [J/kg degC] = Watt/m
            elseif dv(j) <= 0 %else, set heat to 0
                heat_gw(j,1) = 0; 
            end

            %GW outflow
            if dv(j) > 0 %if flow is positive, set to 0
                new_gw(j,1) = 0;
            elseif dv(j) <= 0 %if flow is zero or negative, keep value
                new_gw(j,1) = dv(j);
            end
        end

        %formatting tables
        VNs = {';DateTime','Heat (WATT/m)'};
        VNs1 = {';DateTime','Flow CMS/m'};
        Table_Heat = table(dt, heat_gw, 'VariableNames',VNs);
        Table_Outflow = table(dt, new_gw, 'VariableNames',VNs1);

%         %% set export directory
%         cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V4\CSH\GWHeat\GW_heat_watts_per_meter_in');
%         %% writing tables
%         filename1 = [erase(k(i).name,".dat"),'_heat_in_watts_per_meter.csv'];
%         writetable(Table_Heat,filename1,'Delimiter',',')
% 
%         %% set export directory
%         cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V4\CSH\GWHeat\GW_outflows_CMS_per_meter');
%         %% writing tables
%         filename2 = [erase(k(i).name,".dat"),'_outflow_CMS_per_meter.csv'];
%         writetable(Table_Outflow,filename2,'Delimiter',',')

%% GREENGATE
    elseif f == 1
        for j = 1:length(dv)

            %heat inflow
            if dv(j) > 0 %if flow is positive, calculate heat inflow
                %interpolate trib at timestep of groundwater, 
                ST = dt(1);
                ED = dt(end);
                interval = dt(2) - dt(1);
                interptime = ST:interval:ED;
                
                InterpTemp = interp1(Date_T,Onion_T,interptime,'linear');
                T_gw = InterpTemp(find(datenum(interptime) == datenum(dt(j))));
                
%                 %find temperature that corresponds to the same date
%                 T_gw = Well_T_GG(find(floor(datenum(Well_DT_GG)) == floor(datenum(dt(j)))));
                %calculate heat
                heat_gw(j,1) = dv(j).*ro.*Cp.*T_gw; %CMS/L * kg/m3 * [J/kg degC] = Watt/m
            elseif dv(j) <= 0 %else, set heat to 0
                heat_gw(j,1) = 0; 
            end

            %GW outflow
            if dv(j) > 0 %if flow is positive, set to 0
                new_gw(j,1) = 0;
            elseif dv(j) <= 0 %if flow is zero or negative, keep value
                new_gw(j,1) = dv(j);
            end
        end

        %formatting tables
        VNs = {';DateTime','Heat (WATT/m)'};
        VNs1 = {';DateTime','Flow CMS/m'};
        Table_Heat = table(dt, heat_gw, 'VariableNames',VNs);
        Table_Outflow = table(dt, new_gw, 'VariableNames',VNs1);

%         %% set export directory
%         cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V4\CSH\GWHeat\GW_heat_watts_per_meter_in');
%         %% writing tables
%         filename1 = [erase(k(i).name,".dat"),'_heat_in_watts_per_meter.csv'];
%         writetable(Table_Heat,filename1,'Delimiter',',')
% 
%         %% set export directory
%         cd('C:\Users\Eileen\Neilson Research Dropbox\Eileen Lukens\LCR\Temperature Model\LCR_Model\SWMM6 - PreStorm\V4\CSH\GWHeat\GW_outflows_CMS_per_meter');
%         %% writing tables
%         filename2 = [erase(k(i).name,".dat"),'_outflow_CMS_per_meter.csv'];
%         writetable(Table_Outflow,filename2,'Delimiter',',')
    else
    end
    
    
    plot(dt,heat_gw,'-b')
    xlabel('DATETIME')
    ylabel('Watts/m')
    hold on
end

