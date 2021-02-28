avg = zeros(4,length(results{1}));
std = avg;

figure('Name','Average Hamming Distance');
hold on;
x = var(2:end);
for dev = 1:4
    avg(dev,:) = [results{dev}.mean]';
    std(dev,:) = [results{dev}.sigma];
    
    xx=linspace(x(1),x(end),1000);
    yy=interp1(x,avg(dev,:),xx,'PCHIP' );  % use whatever method suits you the best
    plot(xx,yy);
end
legend (['60 deg';'';'45 deg';'';'30 deg';'';'15 deg']);
for dev = 1:4
    plot(x,avg(dev,:),'o');
end

legend (['60 deg';'';'45 deg';'';'30 deg';'';'15 deg']);
hold off
set(gca,'fontsize', 18);
set(gca,'fontname', 'times')
grid on