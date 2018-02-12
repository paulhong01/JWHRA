%% parameter setting

%% Time slot number setting 
T=5 ;   %T:the number of time slot

%% Radius distance and small cell center setting
radius=500/sqrt(3);
num_pico=3;                         % number of small cell
atleast_dis=radius*1/3;
V=3;                                % UE velocity
pico_centerx=radius/2*cos(pi/6);    % SC center
pico_centery=radius/2*sin(pi/6);    % SC center

%% UE number 
UE_max=5; % UE max number per pico

%% Bandwidth setting
cc_freq=[881.5*1e6];
num_CC=length(cc_freq);
pene_loss = 10;
num_PCC=length(cc_freq)-1;
num_SCC=num_CC-num_PCC;
Wo=180*10^3;   
num_RBs=50; 

%% SC power, energy harvesting, and wireless charging parameter setting
P_max=0.13; % Small cell maximum transmission power 
Pc=1;   % small cell circuit power
E_HE_max=10^(37/10)/1000; % Maximum green energy
E_B=13; % Maximum battery storage
P_UE=0.1;   % UE circuit power
P_efficiency=6.25;    % Power amplifier inefficiency
H_efficiency=0.99;    % Wireless charging inefficnecy
P_Require=10^-4.5;    % Minumum wireless charging capacity
R_min=5*10^6;         % Minumum data rate requirement
Interference=10^-5.5;       % Worst case interference
N_proc=10^(-125/10)/1000;   % Wireless charging processing noise
