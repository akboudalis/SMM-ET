% Carry out plots of magnetic properties of SMMs:
% χ'(T),χ''(T) at a single frequency, field
% χ'(f),χ''(f) at single tenperature, field
% M(H) at a single temnperature, scan rate
% The program will also output:
% τ(T) and τ(H) 1D plots
% τ(T,H) 2D plots
% χ(Τ) DC plots
% This is the final version before SMM-ET v1.0
clear all; close all; format long;
cm = 100*clight/1e6; % Conversion constant from cm-1 to MHz

%% Input parameters
% The text-file input allows the use of the same code for running different
% simulations, with one text file for each.
fname = 'SMM_params_v2_1.dat';
line = 0;
fid = fopen(fname); % Load parameter file
Ueff =       textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); Ueff = cell2mat(Ueff);
fclose(fid); fid = fopen(fname); line = line + 1;
Ueff_s =     textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); Ueff_s = cell2mat(Ueff_s);
fclose(fid); fid = fopen(fname); line = line + 1;
Ueff_model = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); Ueff_model = cell2mat(Ueff_model);
fclose(fid); fid = fopen(fname); line = line + 1;
b_Orb =      textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); b_Orb = cell2mat(b_Orb);
fclose(fid); fid = fopen(fname); line = line + 1;
n_Raman =    textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); n_Raman = cell2mat(n_Raman);
fclose(fid); fid = fopen(fname); line = line + 1;
b_Raman =    textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); b_Raman = cell2mat(b_Raman);
fclose(fid); fid = fopen(fname); line = line + 1;
b_Direct =   textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); b_Direct = cell2mat(b_Direct);
fclose(fid); fid = fopen(fname); line = line + 1;
m_Direct =   textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); m_Direct = cell2mat(m_Direct);
fclose(fid); fid = fopen(fname); line = line + 1;
b_QTM1 =     textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); b_QTM1 = cell2mat(b_QTM1);
fclose(fid); fid = fopen(fname); line = line + 1;
b_QTM2 =     textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); b_QTM2 = cell2mat(b_QTM2);
fclose(fid); fid = fopen(fname); line = line + 1;
Kramers = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); Kramers = cell2mat(Kramers);
fclose(fid); fid = fopen(fname); line = line + 1;
% ---
chiS_over_chiT = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); chiS_over_chiT = cell2mat(chiS_over_chiT);
fclose(fid); fid = fopen(fname); line = line + 1;
alpha = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); alpha = cell2mat(alpha);
fclose(fid); fid = fopen(fname); line = line + 1;
T_vs_T = textscan(fid, '%f',3, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); T_vs_T = cell2mat(T_vs_T); T_vs_T = T_vs_T';
fclose(fid); fid = fopen(fname); line = line + 1;
n_Freqs = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); n_Freqs = cell2mat(n_Freqs); n_Freqs = n_Freqs';
fclose(fid); fid = fopen(fname); line = line + 1;
freq_vs_T = textscan(fid, '%f',n_Freqs, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); freq_vs_T = cell2mat(freq_vs_T); freq_vs_T = freq_vs_T';
fclose(fid); fid = fopen(fname); line = line + 1;
H_vs_T = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); H_vs_T = cell2mat(H_vs_T); H_vs_T = H_vs_T';
fclose(fid); fid = fopen(fname); line = line + 1;
H_vs_H = textscan(fid, '%f',3, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); H_vs_H = cell2mat(H_vs_H); H_vs_H = H_vs_H';
fclose(fid); fid = fopen(fname); line = line + 1;
T_vs_H = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); T_vs_H = cell2mat(T_vs_H); T_vs_H = T_vs_H';
fclose(fid); fid = fopen(fname); line = line + 1;
freq_vs_freq = textscan(fid, '%f',3, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); freq_vs_freq = cell2mat(freq_vs_freq); freq_vs_freq = freq_vs_freq';
fclose(fid); fid = fopen(fname); line = line + 1;
n_Temps = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); n_Temps = cell2mat(n_Temps); n_Temps = n_Temps';
fclose(fid); fid = fopen(fname); line = line + 1;
T_vs_freq = textscan(fid, '%f',n_Temps, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); T_vs_freq = cell2mat(T_vs_freq); T_vs_freq = T_vs_freq';
fclose(fid); fid = fopen(fname); line = line + 1;
% ---
T_hyster =       textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); T_hyster = cell2mat(T_hyster);
fclose(fid); fid = fopen(fname); line = line + 1;
rate = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); rate = cell2mat(rate);
fclose(fid); fid = fopen(fname); line = line + 1;
n_QTM = textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); n_QTM = cell2mat(n_QTM);
fclose(fid); fid = fopen(fname); line = line + 1;
H_QTM = textscan(fid, '%f',n_QTM, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); H_QTM = cell2mat(H_QTM); H_QTM = H_QTM';
fclose(fid); fid = fopen(fname); line = line + 1;
H_max =       textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); H_max = cell2mat(H_max);
fclose(fid); fid = fopen(fname); line = line + 1;
n_sweep_points =       textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); n_sweep_points = cell2mat(n_sweep_points );
fclose(fid); fid = fopen(fname); line = line + 1;
delay =       textscan(fid, '%f',1, 'Delimiter', ',', 'Headerlines', line,'CommentStyle','%'); delay = cell2mat(delay);
fclose(fid);

if Kramers  == 1
    Sys.S = 1/2;
elseif Kramers ==0
    Sys.S = 1;
end

%% Create legends for figures
fraction = 1 - chiS_over_chiT;
H_QTM = [-fliplr(H_QTM) H_QTM];
legendchiS = strcat("{\it\chi_{S}}/{\it\chi_{T}} = ",num2str(chiS_over_chiT));
legendalpha = strcat("{\it\alpha} = ",num2str(alpha));
% legendalpha_only = strcat("{\it\alpha} = ",num2str(alpha_only));
legend_sUeff = strcat("{\it\sigmaU_{eff}} = ",num2str(Ueff_s)," K");
% legend_sUeff_only = strcat("{\it\sigmaU_{eff}} = ",num2str(Ueff_s_only)," K");

%% Define domains for the experiments
% Hysteresis experiments
H_sweep_up = linspace(-H_max,H_max,n_sweep_points); % In T
H_sweep_down = fliplr(H_sweep_up);
H_sweep_QTM = zeros(1,length(H_sweep_up));

% Variable-T experiments
T_vs_T = linspace(T_vs_T(1),T_vs_T(2),T_vs_T(3)); % In K
w_vs_T = 2*pi*freq_vs_T;
tau_inv_vs_T = zeros(length(T_vs_T),length(H_vs_T));

% Variable-H experiments at discrete fields (not hysteresis)
H_vs_H = linspace(H_vs_H(1), H_vs_H(2),H_vs_H(3)); % In T
tau_inv_vs_H = zeros(length(H_vs_H),length(T_vs_H));

% Variable-frequency experiments
freq_vs_freq = logspace(freq_vs_freq(1), freq_vs_freq(2),freq_vs_freq(3));
w_vs_freq = 2*pi*freq_vs_freq;
H_vs_freq = H_vs_T; % In T0.8
jj = 1; % Which field in H_vs_freq vector (and H_vs_T vector) to calculate

%% Calculate or input magnetic susceptibility curve
% Define a spin system...
if exist('SMM_Sys.mat')
    load SMM_Sys.mat
end

%... or input an experimental curve

% Check for chi vs T data: overrides pepper calculation
if exist('chi_vs_T_dc.dat')
    [Texp_dc,chi_dc] = textread('chi_vs_T_dc.dat','%f %f');
    chi_vs_T = spline(Texp_dc,chi_dc,T_vs_T);
end

% Text file with field-sweep DOMAIN for the hysteresis experiments
% (overrides H_sweep_up defined in input text file)
if exist('M_vs_H_sweep.dat')
    [H_sweep_up] = textread('M_vs_H_sweep.dat','%f'); % This overrides the domain defined above
    H_sweep_up = H_sweep_up';
    H_sweep_down = fliplr(H_sweep_up);
end

% M vs H dc data corresponding to the equilibrium magnetizations Meq
% Overrides H_sweep_up AND pepper calculations
if exist('M_vs_H_dc.dat')
    [Hexp_dc,M_dc] = textread('M_vs_H_dc.dat','%f %f');
    M_dc = M_dc';
    Hexp_dc = Hexp_dc';
    M_dc_extend = [-fliplr(M_dc) M_dc(2:end)]; % Create the field-sweep curve
    H_dc_extend = [-fliplr(Hexp_dc) Hexp_dc(2:end)]; % Create the field-sweep domain
    M_vs_H_sweep = spline(H_dc_extend,M_dc_extend,H_sweep_up); % Create the field-swept equilibrium magnetization
end

%% Define Ueff distributions
Ueff_domain = Ueff + linspace(-1.2,1.2,40)*Ueff_s; % spread of deltaJ values to include in simulation
if Ueff_model == 1
    Ueff_weights =  gaussian(Ueff_domain,Ueff,Ueff_s); % Gaussian distribution
elseif Ueff_model == 2
    Ueff_weights =  lorentzian(Ueff_domain,Ueff,Ueff_s); % Lorentzian distribution
elseif Ueff_model == 3
    Ueff_weights =  voigtian(Ueff_domain,Ueff,[Ueff_s Ueff_s]); % Voigtian distribution
end
Ueff_weights = Ueff_weights./sum(Ueff_weights); % Normalize so that the total weight is unity

%% Define level crossings for QTM calculations
% Distances from level crossings for vs H experiments
% Find indexes of closest points
for k = 1:length(H_QTM)
    [~, index(k)] = min(abs(H_vs_H - H_QTM(k)));
end
% actual field distance to nearest level crossing, in Tesla
dH_QTM_vs_H = min(abs(H_vs_H(:) - H_QTM(:)'), [], 2)';


% Distances from level crossings for vs T experiments
for k = 1:length(H_QTM)
    [~, index(k)] = min(abs(H_vs_T - H_QTM(k)));
end
% actual field distance to nearest level crossing, in tesla
dH_QTM_vs_T = min(abs(H_vs_T(:) - H_QTM(:)'), [], 2)';


% Distances from level crossings for vs freq experiments
for k = 1:length(H_QTM)
    [~, index(k)] = min(abs(H_vs_freq - H_QTM(k)));
end
dH_QTM_vs_freq = min(abs(H_vs_freq(:) - H_QTM(:)'), [], 2)';


%% Define functions 1/tau and tau = f(T,H). The parameters are the ones given above.

funct_tau_inv_vs_TH = @(Ueff,b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,x,y,z)... % x = T, y = H, z = H-H_QTM
    b_Orb * exp(-Ueff./x)+...
    b_Raman * x.^n_Raman+...
    b_Direct * y.^m_Direct .* x+...
    b_QTM1./(1 + b_QTM2 * z.^2); 
func_tau_vs_TH = @(Ueff,b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,x,y,z)... % x = T, y = H
    1./(b_Orb * exp(-Ueff./x)+...
    b_Raman * x.^n_Raman+...
    b_Direct * y.^m_Direct .* x+...
    b_QTM1./(1 + b_QTM2 * z.^2));

%% Calculate and plot tau vs T
tau_inv_Orbach_T = b_Orb * exp(-Ueff./T_vs_T); tau_Orbach_T = 1./tau_inv_Orbach_T;
tau_inv_Raman_T = b_Raman * T_vs_T.^n_Raman; tau_Raman_T = 1./tau_inv_Raman_T;
figure(2)
semilogy(1./T_vs_T,tau_Orbach_T,'--','DisplayName',"Orbach",'color','k')
hold on
semilogy(1./T_vs_T,tau_Raman_T,'--','DisplayName',"Raman",'color','g')
for i = 1:length(H_vs_T)
    legendtxt = strcat(num2str(H_vs_T(i))," T");
    tau_inv_Direct_T = b_Direct * H_vs_T(i).^m_Direct .* T_vs_T;
    tau_Direct = 1./tau_inv_Direct_T;
    tau_inv_QTM_T = ones(1,length(T_vs_T)) * b_QTM1/(1 + b_QTM2 * dH_QTM_vs_T(i).^2); tau_QTM = 1./tau_inv_QTM_T;
    tau_inv_vs_T(:,i) =  tau_inv_Orbach_T + tau_inv_Raman_T + tau_inv_Direct_T + tau_inv_QTM_T; % s-1
    tau_vs_T(:,i) = 1./tau_inv_vs_T(:,i); % In s
    semilogy(1./T_vs_T,tau_Direct,'--','DisplayName',strcat(legendtxt,", Direct"),'color','r')
    semilogy(1./T_vs_T,tau_QTM,'--','DisplayName',strcat(legendtxt,", QTM"),'color','b')
    semilogy(1./T_vs_T,tau_vs_T(:,i),'LineWidth',2,'DisplayName',legendtxt)
end
legend show
legend('boxoff')
% ylim([1e-5 2e6]);
xlim([0 max(1./T_vs_T)]);
xlabel('\fontsize{15} \fontname{Times} {\itT}^{-1} / K^{-1}')
ylabel('\fontsize{15} \fontname{Times} {\it\tau} / s')

%% Calculate and plot tau vs H
for i = 1:length(T_vs_H)
    legendtxt = strcat(num2str(T_vs_H(i))," K");
    
    tau_inv_Orbach_H = ones(1,length(H_vs_H)) * b_Orb * exp(-Ueff/T_vs_H(i)); tau_Orbach_H = 1./tau_inv_Orbach_H;
    tau_inv_Raman_H = ones(1,length(H_vs_H)) * b_Raman * T_vs_H(i)^n_Raman; tau_Raman_H = 1./tau_inv_Raman_H;
    tau_inv_Direct_H = b_Direct * H_vs_H.^m_Direct * T_vs_H(i); % Custom exponent
    
    tau_Direct_H = 1./tau_inv_Direct_H;
    tau_inv_QTM_H = b_QTM1./(1 + b_QTM2 * dH_QTM_vs_H.^2); tau_QTM_H = 1./tau_inv_QTM_H;
    
    tau_inv_vs_H(:,i) =  tau_inv_Orbach_H + tau_inv_Raman_H + tau_inv_Direct_H + tau_inv_QTM_H; % s-1
    tau_vs_H(:,i) = 1./tau_inv_vs_H(:,i); % In s
    
    figure(3)
    semilogy(H_vs_H,tau_vs_H(:,i),'LineWidth',2,'DisplayName',legendtxt)
    hold on
    semilogy(H_vs_H,tau_Orbach_H,'--','DisplayName',"Orbach",'color','k','HandleVisibility','off')
    semilogy(H_vs_H,tau_Raman_H,'--','DisplayName',"Raman",'color','g')
    semilogy(H_vs_H,tau_Direct_H,'--','DisplayName',strcat(legendtxt,", Direct"),'color','r')
    semilogy(H_vs_H,tau_QTM_H,'--','DisplayName',strcat(legendtxt,", QTM"),'color','b')
end
legend show
legend('boxoff')
legend('Location','southeast')
% ylim([1e-5 1e7]);
xlim([0 max(H_vs_H)]);
xlabel('\fontsize{15} \fontname{Times} {\itH} / T')
ylabel('\fontsize{15} \fontname{Times} {\it\tau} / s')
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

%% Calculate static chi vs T for several H (fields defined in H vs T
Exp.Temperature = T_vs_T; Opt.Output = 'chimol'; Opt.Units = 'CGS';% Opt.Output = 'ChiCGS';
chi = zeros(length(H_vs_T),length(T_vs_T));
colorH = jet(length(H_vs_T));
for i = 1:length(H_vs_T);
    Exp.Field = H_vs_T(i)*1e3;
    legendtxt = strcat(num2str(H_vs_T(i))," T");
    if isfile('chi_vs_T_dc.dat') == 0
        chi_vs_T(i,:) =  curry(Sys,Exp,Opt); % Calculate magnetic moment at the field used in the experiment. This is only when exp. dat are not present, and overwrites any experimental interpolated curve
    end
    figure(4)
    plot(T_vs_T,chi_vs_T(i,:),'LineWidth',2,'color',colorH(i,:),'DisplayName',legendtxt);
    hold on
end
legend show
legend('boxoff')
xlabel('\fontsize{15} \fontname{Times} {\itT} / K')
ylabel('\fontsize{15} \fontname{Times} {\it\chi}_{M}{\itT} / cm^{3} mol^{-1} K')
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

%% Calculate and plot tau vs T & H
% Calculate tau for the same T and H values as in chi
tau_vs_TH = func_tau_vs_TH(Ueff,b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,T_vs_T,H_vs_H',dH_QTM_vs_H'); % This is tau = f(T, H, H-H_QTM)

figure(5)
% daspect([5 5 1])
axis tight
colormap jet

surf(1./T_vs_T,H_vs_H',tau_vs_TH,'FaceColor','interp','EdgeColor','none','FaceLighting','gouraud','HandleVisibility','off');
hold on

% Plot Orbach vs T, Raman vs T on wall at max (H)
Hwall_vs_T(1:length(T_vs_T)) = max(H_vs_H);
plot3(1./T_vs_T,Hwall_vs_T,tau_Raman_T,'--','DisplayName',"Raman",'color','g','LineWidth',2);
plot3(1./T_vs_T,Hwall_vs_T,tau_Orbach_T,'--','DisplayName',"Orbach",'color','k','LineWidth',2);
plot3(1./T_vs_T,Hwall_vs_T,tau_QTM,'--','DisplayName',strcat(legendtxt,", QTM"),'color','b','LineWidth',2)
plot3(1./T_vs_T,Hwall_vs_T,tau_Direct,'--','DisplayName',strcat(legendtxt,", Direct"),'color','r','LineWidth',2,'HandleVisibility','off')

% Plot Raman, Direct vs H, QTM vs H on wall at max(Tinv)
Hwall_vs_H(1:length(H_vs_H)) = max(1./T_vs_T);
plot3(Hwall_vs_H,H_vs_H,tau_Raman_H,'--','DisplayName',"Raman",'color','g','LineWidth',2,'HandleVisibility','off')
plot3(Hwall_vs_H,H_vs_H,tau_Direct_H,'--','DisplayName',strcat(legendtxt,", Direct"),'color','r','LineWidth',2)
plot3(Hwall_vs_H,H_vs_H,tau_QTM_H,'--','DisplayName',strcat(legendtxt,", QTM"),'color','b','LineWidth',2,'HandleVisibility','off')

legend('Raman','Orbach','QTM','Direct');
legend('boxoff')
legend('location','northeast')
set(gca,'zscale','log')
set(gca,'ColorScale','log')
zlim([0 1000*max(max(tau_vs_TH))])
xlim([min(1./T_vs_T) max(1./T_vs_T)]);
xlabel('\fontsize{15} \fontname{Times} {\itT}^{-1} / K^{-1}')
ylabel('\fontsize{15} \fontname{Times} {\itH} / T')
zlabel('\fontsize{15} \fontname{Times} {\it\tau} / s')
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

xh = get(gca,'XLabel'); % Handle of the x label
set(xh, 'Units', 'Normalized')
pos = get(xh, 'Position');
set(xh, 'Position',pos+[0,0.07,0],'Rotation',15)
yh = get(gca,'YLabel'); % Handle of the y label
set(yh, 'Units', 'Normalized')
pos = get(yh, 'Position');
set(yh, 'Position',pos.*[0.5,-0.9,1],'Rotation',-25)

%% Calculate χ',χ''= f(freq) for one H and at selected temperatures
Exp.Field = H_vs_freq(jj)*1e3;
color = jet(10*length(T_vs_freq));
chi_in_vs_freq = zeros(length(T_vs_freq),length(freq_vs_freq));
chi_out_vs_freq = zeros(length(T_vs_freq),length(freq_vs_freq));
chi_in_vs_freq_distrib_total = zeros(length(T_vs_freq),length(freq_vs_freq));
chi_out_vs_freq_distrib_total = zeros(length(T_vs_freq),length(freq_vs_freq));
chi_in_vs_freq_distrib_chiS_total = zeros(length(T_vs_freq),length(freq_vs_freq));
chi_out_vs_freq_distrib_chiS_total = zeros(length(T_vs_freq),length(freq_vs_freq));
tau_distrib_vs_freq_avg = zeros(1,length(T_vs_freq));
tau_distrib_vs_freq_total = zeros(length(T_vs_freq),length(Ueff_domain));

for ii = 1:length(T_vs_freq) % Which temperature T_vs_freq vector
    legendtxt = strcat(num2str(T_vs_freq(ii))," K");
    Exp.Temperature = T_vs_freq(ii);
    chi_vs_freq(ii) =  curry(Sys,Exp,Opt); % Chi at specific (T,H)  
    chiS_vs_freq = chi_vs_freq(ii)*chiS_over_chiT; % Chi_S
    tau(ii) = func_tau_vs_TH(Ueff,b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,T_vs_freq(ii),H_vs_freq(jj),dH_QTM_vs_freq(jj));

    %     Monodisp.
    chi_in_vs_freq(ii,:) = chi_vs_freq(ii) ./(1 + w_vs_freq.^2 * tau(ii)^2);
    chi_out_vs_freq(ii,:) = chi_vs_freq(ii) * w_vs_freq * tau(ii) ./(1 + w_vs_freq.^2 .* tau(ii)^2);

    %     Monodisp., only chiS
    chi_in_vs_freq_chiS(ii,:) = chiS_vs_freq + (chi_vs_freq(ii) - chiS_vs_freq) ./(1 + w_vs_freq.^2 .* tau(ii)^2);
    chi_out_vs_freq_chiS(ii,:) = (chi_vs_freq(ii) - chiS_vs_freq) * w_vs_freq .* tau(ii) ./(1 + w_vs_freq.^2 .* tau(ii)^2);

    %     chiS with alpha
    chi_in_vs_freq_chiS_alpha(ii,:) = chiS_vs_freq + (chi_vs_freq(ii) - chiS_vs_freq) .* ...
        (1 + (w_vs_freq * tau(ii)).^(1-alpha) * cos((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_freq * tau(ii)).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_freq * tau(ii)).^(2*(1-alpha)));
    chi_out_vs_freq_chiS_alpha(ii,:) = (chi_vs_freq(ii) - chiS_vs_freq) .* ...
        ((w_vs_freq * tau(ii)).^(1-alpha) * sin((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_freq * tau(ii)).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_freq * tau(ii)).^(2*(1-alpha)));

    %     Only alpha (previous equations with 0*chi_S)
    chi_in_vs_freq_alpha(ii,:) = 0*chiS_vs_freq + (chi_vs_freq(ii) - 0*chiS_vs_freq) .* ...
        (1 + (w_vs_freq * tau(ii)).^(1-alpha) * cos((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_freq * tau(ii)).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_freq * tau(ii)).^(2*(1-alpha)));
    chi_out_vs_freq_alpha(ii,:) = (chi_vs_freq(ii) - 0*chiS_vs_freq) .* ...
        ((w_vs_freq * tau(ii)).^(1-alpha) * sin((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_freq * tau(ii)).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_freq * tau(ii)).^(2*(1-alpha)));

    % Distributed
    for iii = 1:length(Ueff_domain)
        tau_distrib_vs_freq(iii) = func_tau_vs_TH(Ueff_domain(iii),b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,T_vs_freq(ii),H_vs_freq(jj),dH_QTM_vs_freq(jj));
        tau_distrib_vs_freq_avg(ii) = tau_distrib_vs_freq_avg(ii) + tau_distrib_vs_freq(iii)*Ueff_weights(iii);
    % No chiS
        chi_in_vs_freq_distrib = Ueff_weights(iii) * (chi_vs_freq(ii) ./(1 + w_vs_freq.^2 * tau_distrib_vs_freq(iii)^2));
        chi_out_vs_freq_distrib = Ueff_weights(iii) * (chi_vs_freq(ii) * w_vs_freq * tau_distrib_vs_freq(iii) ./(1 + w_vs_freq.^2 * tau_distrib_vs_freq(iii)^2));
        chi_in_vs_freq_distrib_total(ii,:) = chi_in_vs_freq_distrib_total(ii,:) + chi_in_vs_freq_distrib;
        chi_out_vs_freq_distrib_total(ii,:) = chi_out_vs_freq_distrib_total(ii,:) + chi_out_vs_freq_distrib;
    % With chiS
        chi_in_vs_freq_distrib_chiS = Ueff_weights(iii) * (chiS_vs_freq + (chi_vs_freq(ii) - chiS_vs_freq) ./ (1 + w_vs_freq.^2 * tau_distrib_vs_freq(iii)^2));
        chi_out_vs_freq_distrib_chiS = Ueff_weights(iii) * ((chi_vs_freq(ii) - chiS_vs_freq) .* w_vs_freq * tau_distrib_vs_freq(iii) ./ (1 + w_vs_freq.^2 * tau_distrib_vs_freq(iii)^2));
        chi_in_vs_freq_distrib_chiS_total(ii,:) = chi_in_vs_freq_distrib_chiS_total(ii,:) + chi_in_vs_freq_distrib_chiS;
        chi_out_vs_freq_distrib_chiS_total(ii,:) = chi_out_vs_freq_distrib_chiS_total(ii,:) + chi_out_vs_freq_distrib_chiS;
    end

%     chiS = 0
    figure(6)
    semilogx(freq_vs_freq,chi_in_vs_freq(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName','Monodisp.');
    hold on
    semilogx(freq_vs_freq,chi_out_vs_freq(ii,:),'LineWidth',2,'color',color(ii,:),'HandleVisibility','off');
    semilogx(freq_vs_freq,chi_in_vs_freq_distrib_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'DisplayName',legend_sUeff);
    semilogx(freq_vs_freq,chi_out_vs_freq_distrib_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    semilogx(freq_vs_freq,chi_in_vs_freq_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'DisplayName',legendalpha);
    semilogx(freq_vs_freq,chi_out_vs_freq_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    
    xlabel('\fontsize{15} \fontname{Times} {\itf} / Hz')
    ylabel('\fontsize{15} \fontname{Times} {\it\chi}_{M}{\it''},{\it\chi}_{M}{\it''''} / cm^{3} mol^{-1}')
    legend show
    legend('boxoff')
    legend('Location','west')
    axis tight
    % title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\itΤ} = ",num2str(T_vs_freq(ii))," K, {\it\chi_{S}}/{\it\chi_{T}} = 0"));
    title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\itΤ} = ",num2str(T_vs_freq)," K, {\it\chi_{S}}/{\it\chi_{T}} = 0"));

    set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')
    ax1 = gca;
    
%     chiS > 0
    figure(60)
    semilogx(freq_vs_freq,chi_in_vs_freq_chiS(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName','Monodisp.');
    hold on
    semilogx(freq_vs_freq,chi_out_vs_freq_chiS(ii,:),'LineWidth',2,'color',color(ii,:),'HandleVisibility','off');
    semilogx(freq_vs_freq,chi_in_vs_freq_distrib_chiS_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'DisplayName',legend_sUeff);
    semilogx(freq_vs_freq,chi_out_vs_freq_distrib_chiS_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    semilogx(freq_vs_freq,chi_in_vs_freq_chiS_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'DisplayName',legendalpha);
    semilogx(freq_vs_freq,chi_out_vs_freq_chiS_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    
    xlabel('\fontsize{15} \fontname{Times} {\itf} / Hz')
    ylabel('\fontsize{15} \fontname{Times} {\it\chi}_{M}{\it''},{\it\chi}_{M}{\it''''} / cm^{3} mol^{-1}')
    legend show
    legend('boxoff')
    legend('Location','west')
    axis tight
    title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\itΤ} = ",num2str(T_vs_freq(ii))," K, ",legendchiS));
    set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')
    
%     figure(6000)
%     if ii == 1 || ii == length(T_vs_freq)
%     plot3(tau_distrib_vs_freq,1./T_vs_freq(ii)*ones(1,length(tau_distrib_vs_freq)),Ueff_weights,'LineWidth',2,'color',color(ii,:),'DisplayName',legendtxt)
%     hold on
%     else
%     plot3(tau_distrib_vs_freq,1./T_vs_freq(ii)*ones(1,length(tau_distrib_vs_freq)),Ueff_weights,'LineWidth',2,'color',color(ii,:),'DisplayName',legendtxt,'HandleVisibility','off')
%     end
%     view(133,56);
%     set(gca,'Xdir','reverse')
%     axis tight
    
%     Cole-Cole plots
    figure(9)
    plot(chi_in_vs_freq(ii,:),chi_out_vs_freq(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName','Monodisp.');
    hold on
    plot(chi_in_vs_freq_distrib_total(ii,:),chi_out_vs_freq_distrib_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'DisplayName',legend_sUeff);
    plot(chi_in_vs_freq_alpha(ii,:),chi_out_vs_freq_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'DisplayName',legendalpha);
    xlabel('\fontsize{15} \fontname{Times} {\it\chi_{Μ}''} / cm^{3} mol^{-1}')
    ylabel('\fontsize{15} \fontname{Times} {\it\chi_{Μ}''''} / cm^{3} mol^{-1}')
    legend show
    legend('boxoff')
    legend('Location','eastoutside')
    title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\itΤ} = ",num2str(T_vs_freq(ii))," K"));
    
    figure(90)
    plot(chi_in_vs_freq_chiS(ii,:),chi_out_vs_freq_chiS(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName','Monodisp.');
    hold on
    plot(chi_in_vs_freq_distrib_chiS_total(ii,:),chi_out_vs_freq_distrib_chiS_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'DisplayName',legend_sUeff);
    plot(chi_in_vs_freq_chiS_alpha(ii,:),chi_out_vs_freq_chiS_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'DisplayName',legendalpha);
    xlabel('\fontsize{15} \fontname{Times} {\it\chi_{Μ}''} / cm^{3} mol^{-1}')
    ylabel('\fontsize{15} \fontname{Times} {\it\chi_{Μ}''''} / cm^{3} mol^{-1}')
    legend show
    legend('boxoff')
    legend('Location','eastoutside')
    title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\itΤ} = ",num2str(T_vs_freq(ii))," K"));

end

figure(6)
% Plot the Ueff distribution    
    ax2 = axes('Position',[.58 .5 .3 .4]);
    box on;
    plot(Ueff_domain,Ueff_weights)
    xlabel('\fontsize{15} \fontname{Times} {\itU}_{eff} / K')
    ylabel('\fontsize{15} \fontname{Times} {\itweights}')
    set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

figure(60)
% Plot the Ueff distribution    
    ax2 = axes('Position',[.58 .5 .3 .4]);
    box on;
    plot(Ueff_domain,Ueff_weights)
    xlabel('\fontsize{15} \fontname{Times} {\itU}_{eff} / K')
    ylabel('\fontsize{15} \fontname{Times} {\itweights}')
    set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

% figure(6000)
% % daspect([2e4 3 1]);
% plot3(tau_vs_T(:,jj),1./T_vs_T,ones(1,length(tau_vs_T))*max(Ueff_weights),'LineWidth',2,'color','k','DisplayName','{\it\tau} monodisperse')
% plot3(tau_distrib_vs_freq_avg,1./T_vs_freq,ones(1,length(T_vs_freq))*max(Ueff_weights),'--','LineWidth',2,'color','k','DisplayName','{\it\tau} avg')
% ylim([min(1./T_vs_freq) max(1./T_vs_freq)]);
% grid on
% xlabel('\fontsize{15} \fontname{Times} {\it\tau} / s')
% ylabel('\fontsize{15} \fontname{Times} {\itT}^{-1} / K^{-1}')
% zlabel('\fontsize{15} \fontname{Times} {\itweight}')
% 
% xh = get(gca,'XLabel'); % Handle of the x label
% set(xh, 'Units', 'Normalized')
% pos = get(xh, 'Position');
% set(xh, 'Position',pos+[0.1,0.2,0],'Rotation',35)
% yh = get(gca,'YLabel'); % Handle of the y label
% set(yh, 'Units', 'Normalized')
% pos = get(yh, 'Position');
% set(yh, 'Position',pos.*[0.4,-1,1],'Rotation',-40)
% title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\it\sigmaU_{eff}} = ",num2str(Ueff_s)," K"));
% 
% set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')
% set(gcf, 'PaperSize', [10 30], 'Units', 'centimeters');
% print(gcf,'general_ditrib_tau_3D_linear.png','-r900','-dpng')
% 
% set(gca,'xscale','log')
% legend show
% legend('boxoff')
% h = legend;
% set(h,'Position',[0.45 0.28 0.11 0.08]);
% print(gcf,'general_ditrib_tau_3D_log.png','-r900','-dpng')


figure(9)
title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\it\chi_{S}}/{\it\chi_{T}} = 0"));
r = chi_vs_freq(1)/2; % radius
c = [chi_vs_freq(1)/2 0];% center
pos = [c-r 2*r 2*r];
rectangle('Position',pos,'Curvature',[1 1],'EdgeColor','k','LineWidth',2,'LineStyle','--');
% axis square
pbaspect([2 1 1])
ylim(xlim/2);
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

figure(90)
title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, ",legendchiS));
r = chi_vs_freq(1)/2; % radius
c = [chi_vs_freq(1)/2 0];% center
pos = [c-r 2*r 2*r];
rectangle('Position',pos,'Curvature',[1 1],'EdgeColor','k','LineWidth',2,'LineStyle','--');
% axis square
pbaspect([2 1 1])
ylim(xlim/2);
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

% Calculate χ',χ''= f(T) for one H and at selected frequencies
Exp.Field = H_vs_T(jj)*1e3;
color = jet(10*length(freq_vs_T));
chi_in_vs_T = zeros(length(freq_vs_T),length(T_vs_T));
chi_out_vs_T = zeros(length(freq_vs_T),length(T_vs_T));
chi_inout_vs_T = zeros(length(freq_vs_T),length(T_vs_T));
chi_in_vs_T_distrib_total = zeros(length(freq_vs_T),length(T_vs_T));
chi_out_vs_T_distrib_total = zeros(length(freq_vs_T),length(T_vs_T));
chi_in_vs_T_distrib_chiS_total = zeros(length(freq_vs_T),length(T_vs_T));
chi_out_vs_T_distrib_chiS_total = zeros(length(freq_vs_T),length(T_vs_T));
Exp.Temperature = T_vs_T;
if isfile('chi_vs_T_dc.dat') == 0
chi_vs_T = curry(Sys,Exp,Opt); % Chi at specific (T,H). This onerwrites any experimental interpolated curve
end

for ii = 1:length(freq_vs_T) % Which temperature T_vs_freq vector
legendtxt = strcat(num2str(freq_vs_T(ii))," Hz");

    %     Monodisp.
    tau = func_tau_vs_TH(Ueff,b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,T_vs_T,H_vs_T(jj),dH_QTM_vs_T(jj));
    chi_in_vs_T(ii,:) = chi_vs_T                       ./ (1 + w_vs_T(ii)^2 * tau.^2);
    chi_out_vs_T(ii,:) = chi_vs_T * w_vs_T(ii) .* tau ./ (1 + w_vs_T(ii)^2 * tau.^2);
    chi_inout_vs_T(ii,:) = sqrt(chi_in_vs_T(ii,:).^2 + chi_out_vs_T(ii,:).^2);

    %     Monodisp. with chiS
    chiS = chiS_over_chiT*chi_vs_T;
    chi_in_vs_T_chiS(ii,:) = chiS + (chi_vs_T - chiS) ./ (1 + w_vs_T(ii)^2 * tau.^2);
    chi_out_vs_T_chiS(ii,:) = (chi_vs_T - chiS) * w_vs_T(ii) .* tau ./ (1 + w_vs_T(ii)^2 * tau.^2);

    %     chiS with alpha
    chi_in_vs_T_chiS_alpha(ii,:) = chiS + (chi_vs_T - chiS) .* ...
        (1 + (w_vs_T(ii) * tau).^(1-alpha) * cos((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_T(ii) * tau).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_T(ii) * tau).^(2*(1-alpha)));
    chi_out_vs_T_chiS_alpha(ii,:) = (chi_vs_T - chiS) .* ...
        ((w_vs_T(ii) .* tau).^(1-alpha) * sin((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_T(ii) * tau).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_T(ii) * tau).^(2*(1-alpha)));

    %     Only alpha (previous equations with 0*chi_S)
    chi_in_vs_T_alpha(ii,:) = 0*chiS + (chi_vs_T - 0*chiS) .* ...
        (1 + (w_vs_T(ii) * tau).^(1-alpha) * cos((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_T(ii) * tau).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_T(ii) * tau).^(2*(1-alpha)));
    chi_out_vs_T_alpha(ii,:) = (chi_vs_T - 0*chiS) .* ...
        ((w_vs_T(ii) .* tau).^(1-alpha) * sin((1-alpha)*pi/2)) ./ ...
        (1 + 2*(w_vs_T(ii) * tau).^(1-alpha) * cos((1-alpha)*pi/2) + (w_vs_T(ii) * tau).^(2*(1-alpha)));    

%     Distributed
    for iii = 1:length(Ueff_domain)
        tau_distrib = func_tau_vs_TH(Ueff_domain(iii),b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,T_vs_T,H_vs_T(jj),dH_QTM_vs_T(jj));
% No chiS
        chi_in_vs_T_distrib = Ueff_weights(iii) * (chi_vs_T ./(1 + w_vs_T(ii)^2 .* tau_distrib.^2));
        chi_out_vs_T_distrib = Ueff_weights(iii) * (chi_vs_T * w_vs_T(ii) .* tau_distrib ./(1 + w_vs_T(ii)^2 .* tau_distrib.^2));
        chi_in_vs_T_distrib_total(ii,:) = chi_in_vs_T_distrib_total(ii,:) + chi_in_vs_T_distrib;
        chi_out_vs_T_distrib_total(ii,:) = chi_out_vs_T_distrib_total(ii,:) + chi_out_vs_T_distrib;
%         With chiS
        chi_in_vs_T_distrib_chiS = Ueff_weights(iii) * (chiS + (chi_vs_T - chiS) ./ (1 + w_vs_T(ii)^2 .* tau_distrib.^2));
        chi_out_vs_T_distrib_chiS = Ueff_weights(iii) * ((chi_vs_T - chiS) .* w_vs_T(ii) .* tau_distrib ./ (1 + w_vs_T(ii)^2 .* tau_distrib.^2));
        chi_in_vs_T_distrib_chiS_total(ii,:) = chi_in_vs_T_distrib_chiS_total(ii,:) + chi_in_vs_T_distrib_chiS;
        chi_out_vs_T_distrib_chiS_total(ii,:) = chi_out_vs_T_distrib_chiS_total(ii,:) + chi_out_vs_T_distrib_chiS;
    end
    
    figure(7)
    plot(T_vs_T,chi_in_vs_T(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName',strcat("Monodisp., {\itf} = ",num2str(freq_vs_T(ii))," Hz"));
    hold on
    plot(T_vs_T,chi_out_vs_T(ii,:),'LineWidth',2,'color',color(ii,:),'HandleVisibility','off');
    plot(T_vs_T,chi_in_vs_T_distrib_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'DisplayName',legend_sUeff);
    plot(T_vs_T,chi_out_vs_T_distrib_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    plot(T_vs_T,chi_in_vs_T_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'DisplayName',legendalpha);
    plot(T_vs_T,chi_out_vs_T_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

%     figure(8)
%     subplot(2,1,1)
%     plot(T_vs_T,T_vs_T.*chi_in_vs_T(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName',legendtxt);
%     hold on
%     plot(T_vs_T,T_vs_T.*chi_in_vs_T_distrib_total(ii,:),'--','LineWidth',2,'color',color(ii,:),'HandleVisibility','off');
%     subplot(2,1,2)
%     plot(T_vs_T,chi_out_vs_T(ii,:),'color',color(ii,:),'HandleVisibility','off');
%     hold on
% %     plot(T_vs_T,chi_inout_vs_T(ii,:),'LineWidth',4,'color',color(ii,:),'HandleVisibility','off');
%     plot(T_vs_T,chi_out_vs_T_distrib_total(ii,:),'--','color',color(ii,:),'HandleVisibility','off');
%     set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

    figure(70)
    plot(T_vs_T,chi_in_vs_T_chiS(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName',strcat("Monodisp., {\itf} = ",num2str(freq_vs_T(ii))," Hz"));
    hold on
    plot(T_vs_T,chi_out_vs_T_chiS(ii,:),'LineWidth',2,'color',color(ii,:),'HandleVisibility','off');
    plot(T_vs_T,chi_in_vs_T_distrib_chiS_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'DisplayName',legend_sUeff);
    plot(T_vs_T,chi_out_vs_T_distrib_chiS_total(ii,:),'-','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    plot(T_vs_T,chi_in_vs_T_chiS_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'DisplayName',legendalpha);
    plot(T_vs_T,chi_out_vs_T_chiS_alpha(ii,:),'--','LineWidth',1,'color',color(ii,:),'HandleVisibility','off');
    set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

%     figure(80)
%     subplot(2,1,1)
%     plot(T_vs_T,T_vs_T.*chi_in_vs_T(ii,:),'LineWidth',2,'color',color(ii,:),'DisplayName',legendtxt);
%     hold on
%     plot(T_vs_T,T_vs_T.*chi_in_vs_T_chiS(ii,:),'--','LineWidth',2,'color',color(ii,:),'HandleVisibility','off');
%     subplot(2,1,2)
%     plot(T_vs_T,chi_out_vs_T(ii,:),'color',color(ii,:),'HandleVisibility','off');
%     hold on
% %     plot(T_vs_T,chi_inout_vs_T(ii,:),'LineWidth',4,'color',color(ii,:),'HandleVisibility','off');
%     plot(T_vs_T,chi_out_vs_T_chiS(ii,:),'--','color',color(ii,:),'HandleVisibility','off');
%     set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')
    
end
figure(7)
plot(T_vs_T,chi_vs_T,'color','k','DisplayName','DC');
legend show
legend('boxoff')
% ylim([0 1]);
% xlim([0 30]);
xlabel('\fontsize{15} \fontname{Times} {\itT} / K')
ylabel('\fontsize{15} \fontname{Times} {\it\chi''_{M}}/{\it\chi''''_{M}} / cm^{3} mol^{-1}')
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')
% title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\it\chi_{S}}/{\it\chi_{T}} = 0"));
title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, {\itf} = ",num2str(freq_vs_T)," Hz, ",legendchiS));

% figure(8)
% subplot(2,1,1)
% title(strcat(num2str(Exp.Field/1000)," T"));
% plot(T_vs_T,T_vs_T.*chi_vs_T,'color','k','DisplayName','DC');
% xlim([0 25]);
% ylabel('\fontsize{15} \fontname{Times} {\it\chi''_{M}}{\itT} / cm^{3} mol^{-1} K')
% legend show
% legend('boxoff')
% subplot(2,1,2)
% xlim([0 30]);
% xlabel('\fontsize{15} \fontname{Times} {\itT} / K')
% ylabel('\fontsize{15} \fontname{Times} {\it\chi}_{M}{\it''},{\it\chi}_{M}{\it''''} / cm^{3} mol^{-1}')
% set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

figure(70)
plot(T_vs_T,chi_vs_T,'color','k','DisplayName','DC');
legend show
legend('boxoff')
% ylim([0 1]);
% xlim([0 30]);
xlabel('\fontsize{15} \fontname{Times} {\itT} / K')
ylabel('\fontsize{15} \fontname{Times} {\it\chi}_{M}{\it''},{\it\chi}_{M}{\it''''} / cm^{3} mol^{-1}')
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')
title(strcat("{\itH} = ",num2str(Exp.Field/1000)," T, ",legendchiS));

% figure(80)
% subplot(2,1,1)
% title(strcat(num2str(Exp.Field/1000)," T"));
% plot(T_vs_T,T_vs_T.*chi_vs_T,'color','k','DisplayName','DC');
% xlim([0 30]);
% ylabel('\fontsize{15} \fontname{Times} {\it\chi''_{M}}{\itT} / cm^{3} mol^{-1} K')
% legend show
% legend('boxoff')
% subplot(2,1,2)
% xlim([5 35]);
% xlabel('\fontsize{15} \fontname{Times} {\itT} / K')
% ylabel('\fontsize{15} \fontname{Times} {\it\chi''''_{M}} / cm^{3} mol^{-1}')
% set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')

% Hysteresis loops
Exp.Temperature = T_hyster;
Opt.Output = 'muBM'; Opt.Units = 'CGS';

% Level-crossing distances
%---v0.9---
% H_sweep_QTM = zeros(1,length(H_sweep_up));
% for k = 1:length(H_QTM)
%     [dH, sweep_index(k)] = min( abs( H_sweep_up - H_QTM(k) ) );
% end
% for l = min(sweep_index):max(sweep_index)
%     H_sweep_QTM(sweep_index) = 1;
% end
% dH_QTM = bwdist(H_sweep_QTM);
% dH_QTM = dH_QTM*max(H_sweep_QTM)/max(dH_QTM);

%---v2.0---
% H_sweep_QTM = zeros(1,length(H_sweep_up));
for k = 1:length(H_QTM)
    [~, sweep_index(k)] = min(abs(H_sweep_up - H_QTM(k)));
end
% H_sweep_QTM(sweep_index) = 1;
% actual field distance to nearest level crossing, in tesla
dH_QTM = min(abs(H_sweep_up(:) - H_QTM(:)'), [], 2)';
% Saturation value
if exist('M_vs_H_dc.dat')
    Meq_sat = M_vs_H_sweep(length(M_vs_H_sweep));
else
    Exp.Field = max(H_sweep_up)*1e3; % Convert to mT for Easyspin calculation
    Meq_sat = curry(Sys,Exp,Opt); % Calculate saturation magnetization
end

% Equilibrum curves
if exist('M_vs_H_dc.dat')
    Meq_up = M_vs_H_sweep;
    Meq_down = -fliplr(Meq_up);
else
    Exp.Field = H_sweep_up*1e3;
    Meq_up = curry(Sys,Exp,Opt);
    Exp.Field = H_sweep_down*1e3;
    Meq_down = curry(Sys,Exp,Opt);
end
color = jet(length(fraction));

figure(10)
plot(H_sweep_up,Meq_up,'o','color','k','linewidth',2,'DisplayName','{\itM}_{eq}')
hold on
legend show
legend('boxoff')
for iii = 1:length(fraction)
%---v0.9---
% for i = 1:length(H_sweep_up)
%     tau_sweep(i) = func_tau_vs_TH(Ueff,b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,Exp.Temperature,abs(H_sweep_up(i)),dH_QTM(i));
%     f = @(t,y) -(y - Meq_up(i))/(fraction(iii)*double(rate)*double(tau_sweep(i)));
%     if i ==1
%         y0_up = -Meq_sat;
%     else
%         y0_up = M_vs_H_up(i-1);
%     end
%     ySol_up = ode45(f,H_sweep_up,y0_up);
%     M_vs_H_up(i) = deval(ySol_up,H_sweep_up(i));
%     M_vs_H_up(i) = Meq_up(i) + (M_vs_H_up(i) - Meq_up(i)) * exp(-delay/tau_sweep(i)) ;
% end

%---v2.0---
M_vs_H_up = zeros(size(H_sweep_up));
for i = 1:length(H_sweep_up)
    tau_sweep(i) = func_tau_vs_TH(Ueff,b_Orb,n_Raman,b_Raman,b_Direct,b_QTM1,b_QTM2,...
        Exp.Temperature,abs(H_sweep_up(i)),dH_QTM(i));

    if i == 1
        M_vs_H_up(i) = -Meq_sat;
        M_vs_H_up(i) = Meq_up(i) + (M_vs_H_up(i) - Meq_up(i))*exp(-delay/tau_sweep(i));
    else
        f = @(H,y) -(y - Meq_up(i))/(fraction(iii)*rate*tau_sweep(i));
        [~, ySol] = ode45(f, [H_sweep_up(i-1), H_sweep_up(i)], M_vs_H_up(i-1));
        M_vs_H_up(i) = ySol(end,1);
        M_vs_H_up(i) = Meq_up(i) + (M_vs_H_up(i) - Meq_up(i))*exp(-delay/tau_sweep(i));
    end
end
plot(H_sweep_up,M_vs_H_up,'-','color',color(iii,:),'linewidth',2,'DisplayName',strcat("{\it\rho} = ",num2str(fraction(iii),2)))
M_vs_H_down = -(M_vs_H_up);
plot(H_sweep_down,M_vs_H_down,'-','color',color(iii,:),'linewidth',2,'HandleVisibility','Off')
end
xlabel('\fontsize{15} \fontname{Times} {\itH} / T')
ylabel('\fontsize{15} \fontname{Times} {\itM} / {\itN_{A}\mu_{B}}')
title(strcat(num2str(Exp.Temperature)," K"));
set(gca,'FontName','Times','Fontsize',10,'XColor','k','YColor','k')
legend('Location','southeast')

clear f func_tau_vs_TH clear funct_tau_inv_vs_TH ySol_up y0_up xh yh Opt pos r c sweep_index i ii iii k l fid dH dH* fname...
    color colorH cm ax1 ax2 jj legend* ans index 
