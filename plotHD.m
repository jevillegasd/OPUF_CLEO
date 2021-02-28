% Develloped by on A. Bojesomo, S. Patnaik, and J. Knechtel, “Security evaluation 
%   frame- work for peo-PUF,” Design for Excellence Laboratory, New York Univ.
%   Abu Dhabi, Abu Dhabi, United Arab Emirates, 2019. [Online]. 
%   Available: https://github.com/DfX-NYUAD/peo-PUF
% Modified by Juan Villegas, NYU 2020

function [xd,pd] = plotHD(HDdata)%,comment)
mu = mean(HDdata);
sigma = std(HDdata);

h = histogram(HDdata,'Visible','off','Normalization','probability');%,'NumBins',25);%round(sqrt(length(HDdata))));
xh = deal((h.BinEdges(1:end-1)+h.BinEdges(2:end))/2);
ph = h.Values;
xd = xh;%linspace(h.BinEdges(1),h.BinEdges(end),2*h.NumBins-1);

gm = makedist('Normal','mu',mu,'sigma',sigma);
yd = pdf(gm,xd); pd = yd/sum(yd);

bar(xh,ph)
hold on
plot(xd,pd,'LineWidth',1)
xlabel('Hamming Distance')
ylabel('Probability')
set(gca,'PlotBoxAspectRatio', [2 1 1])
xlim([0 0.8])
hold off