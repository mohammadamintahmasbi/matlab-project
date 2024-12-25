% خواندن سیگنال ECG
load('ecg_example (1).mat');

% تعریف محور زمان
fs = 360; % فرکانس نمونه‌برداری
t = (0:length(y)-1) / fs;

% رسم سیگنال
figure;
plot(t, y);
xlabel('زمان (ثانیه)');
ylabel('دامنه');
title('سیگنال ECG');
%--ب--


% طراحی فیلتر پایین‌گذر
order = 12;
wn = 0.17; % فرکانس نرمالیزه شده
[b, a] = butter(order, wn, 'low');

% رسم پاسخ فرکانسی فیلتر
[h, w] = freqz(b, a, 1024, fs);
figure;
plot(w, 20*log10(abs(h)));
xlabel('فرکانس (هرتز)');
ylabel('پاسخ (دسیبل)');
title('پاسخ فرکانسی فیلتر پایین‌گذر');


%--ج--
% بارگذاری سیگنال ECG

% تعریف پارامترهای فیلتر
% اعمال فیلتر با استفاده از filter
filtered_signal1 = filter(b, a, y);

% اعمال فیلتر با استفاده از filtfilt
filtered_signal2 = filtfilt(b, a, y);

% نمایش نتایج
figure;
t_window = t(1:360); % پنجره 1 ثانیه‌ای
plot(t_window, y(1:360), 'b', t_window, filtered_signal1(1:360), 'r', t_window, filtered_signal2(1:360), 'g');
legend('سیگنال اصلی', 'فیلتر شده با filter', 'فیلتر شده با filtfilt');
xlabel('زمان (ثانیه)');
ylabel('دامنه');
title('مقایسه سیگنال اصلی و فیلتر شده');

%--و--

% محاسبه z[n]
y1 = filtered_signal2;
z = conv(y1, fliplr(y1));

% رسم z[n] در بازه (0,12)
t_z = (0:length(z)-1) / fs;
figure;
plot(t_z(1:12*fs), z(1:12*fs));
xlabel('زمان (ثانیه)');
ylabel('دامنه');
title('سیگنال z[n]');
xlim([0 12]);
%--ز--

function heart_rate = calculate_heart_rate(z, fs)
    window_size = 4 * fs; % پنجره 4 ثانیه‌ای
    overlap = 0.5 * fs; % همپوشانی 0.5 ثانیه
    
    heart_rate = [];
    for i = 1:overlap:(length(z)-window_size)
        window = z(i:i+window_size-1);
        [~, locs] = findpeaks(window, 'MinPeakDistance', 0.5*fs);
        if ~isempty(locs)
            rate = length(locs) * (60 / 4); % تبدیل به ضربان در دقیقه
            heart_rate = [heart_rate rate];
        end
    end
end

% محاسبه نرخ ضربان قلب
heart_rate = calculate_heart_rate(z, fs);

% نمایش نتایج
figure;
t_hr = (0:length(heart_rate)-1) * 0.5; % هر 0.5 ثانیه یک مقدار
plot(t_hr, heart_rate);
xlabel('زمان (ثانیه)');
ylabel('نرخ ضربان قلب (ضربان در دقیقه)');
title('نرخ ضربان قلب تخمینی');



