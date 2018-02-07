clc; clear all; set(0,'defaultTextInterpreter','latex'); set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'DefaultLegendInterpreter', 'latex'); set(gcf,'units','centimeters'); linecolors = lines(20); set(0,'DefaultAxesFontSize', 14); set(0,'DefaultTextFontSize', 14);

load 2016-12-07_SmoothFix4ExpParams_400_1000_1000_1E-5_200neV

figure(1); clf; hold all; box on; grid on;

bin_edges = -10:0.2:10; %[1E-6 Hz]
hist_diff_f_RLS_DblExp4ParamsFree = histogram(diff_f_RLS_DblExp4ParamsFree*1E6,bin_edges);
hist_diff_f_RLS_SingleExp = histogram(diff_f_RLS_SingleExp*1E6,bin_edges);
hist_diff_f_RLS_SmoothFix4ExpParams = histogram(diff_f_RLS_SmoothFix4ExpParams*1E6,bin_edges);

bin_centers = (bin_edges(1:end-1)+bin_edges(2:end))/2;
figure(2); clf; hold all; box on; grid on;
plot(bin_centers,hist_diff_f_RLS_DblExp4ParamsFree.Values,'-o','LineWidth',2,'Color',linecolors(1,:))
plot(bin_centers,hist_diff_f_RLS_SingleExp.Values,'-o','LineWidth',2,'Color',linecolors(2,:))
plot(bin_centers,hist_diff_f_RLS_SmoothFix4ExpParams.Values,'-o','LineWidth',2,'Color',linecolors(3,:))
xlabel('$f_{\rm true}- f_{\rm extracted}$ [${\rm \mu Hz}$]')
ylabel('number per 0.2${\rm \mu Hz}$')
title('Histogram of difference between true frequency and extracted frequency')
legend('DblExp4ParamsFree','SingleExp','SmoothFix4ExpParams')

[mu_LS,sigma_LS,muci,sigmaci] = normfit(hist_diff_f_RLS_DblExp4ParamsFree.Data);
sigma_LS
[mu_RLS,sigma_RLS,muci,sigmaci] = normfit(hist_diff_f_RLS_SingleExp.Data);
sigma_RLS
[mu_ML,sigma_ML,muci,sigmaci] = normfit(hist_diff_f_RLS_SmoothFix4ExpParams.Data);
sigma_ML

figure(3); clf; hold all; box on; grid on;
plot(bin_centers,hist_diff_f_RLS_DblExp4ParamsFree.Values,'o','LineWidth',2,'Color',linecolors(1,:));
h1=plot(bin_centers,normpdf(bin_centers,mu_LS,sigma_LS)*1000*0.2,'-','LineWidth',2,'Color',linecolors(1,:));
plot(bin_centers,hist_diff_f_RLS_SingleExp.Values,'o','LineWidth',2,'Color',linecolors(2,:));
h2=plot(bin_centers,normpdf(bin_centers,mu_RLS,sigma_RLS)*1000*0.2,'-','LineWidth',2,'Color',linecolors(2,:));
plot(bin_centers,hist_diff_f_RLS_SmoothFix4ExpParams.Values,'o','LineWidth',2,'Color',linecolors(3,:));
h3=plot(bin_centers,normpdf(bin_centers,mu_ML,sigma_ML)*1000*0.2,'-','LineWidth',2,'Color',linecolors(3,:));

xlabel('$f_{\rm true}- f_{\rm extracted}$ [${\rm \mu Hz}$]')
ylabel('number per 0.2${\rm \mu Hz}$')
title('Histogram of difference between true frequency and extracted frequency')
legend([h1 h2 h3],'DblExp4ParamsFree','SingleExp','SmoothFix4ExpParams')


