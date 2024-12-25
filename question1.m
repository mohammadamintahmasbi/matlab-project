t = 0:0.01:10;
x = exp(-t.^0.5) .* (t >= 0);
y = (t.^2) .* exp(-t.^0.5) .* (t >= 0);

figure;
plot(t, x, 'b', t, y, 'r');
xlabel('Time');
ylabel('Amplitude');
title('نمایش سیگنال‌های x(t) و y(t)');
legend('x(t)', 'y(t)');
grid on;
% جواب بخش الف
[~, hobj, ~, ~]=legend({'signal1','signal2'},'Fontsize',14,'Location'
,'North'); 
hl = findobj(hobj,'type','line'); 
set(hl,'LineWidth',2); 
ht = findobj(hobj,'type','text') 
set(ht,'FontSize', 14, 'fontname', 'times'); 

% جواب بخش ه
h0 = gca; 
set(h0,'xtick',[0 5 10],'ytick',.5*(0:6)) 
set(h0,'ylim',[0, 2.3]) 
set(h0,'fontsize',12,'fontname','times','fontweight','bold') 
 
set(get(h0,'xlabel'),'string','Time (s)','fontsize',14,'fontname','helivetka','fontweight','normal') 
set(get(h0,'ylabel'),'string','Amplitude (V)','fontsize',14,'fontname','helivetka','fontweight','normal')  
h1 = findobj(h0,'type','line'); 
col = [0 0 0; 0 1 0]; % First row is black [0 0 0], second row is green [0 1 0]

set(h1(1),'color',col(1,:),'linewidth',1) % Black Line
set(h1(2),'color',col(2,:),'linewidth',1.5) % Green Line 

% zoom part
axes('Position',[0.15 0.6 0.25 0.25])  
plot(t, x, 'b', t, y, 'r');
axis([1 3 min(min(x), min(y)) max(max(x), max(y))]); % Zoom in from 1 to 3 on x-axis 

title('Zoomed-in View');
grid on;