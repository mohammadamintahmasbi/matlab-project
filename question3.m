%--الف--
[y, Fs] = audioread('music.wav');
t = (0:length(y)-1) / Fs;
plot(t, y(:,1));
xlabel('زمان (ثانیه)');
ylabel('دامنه');
title('سیگنال صوتی اصلی');

%--ب--
player = audioplayer(y, Fs);
play(player);

%--ج--
Y = fft(y(:,1));
f = (0:length(Y)-1)*Fs/length(Y);
plot(f, abs(Y));
xlabel('فرکانس (Hz)');
ylabel('|Y(f)|');
title('اندازه تبدیل فوریه');

%--د--

Y_truncated = [Y(1:30000); Y(end-29999:end)];
y_recovered = real(ifft(Y_truncated));

audiowrite('recovered_30000.wav', y_recovered, Fs);
[y_play, Fs_play] = audioread('recovered_30000.wav');
player = audioplayer(y_play, Fs_play);
play(player);

%--ه--

Y_truncated_60000 = [Y(1:60000); Y(end-59999:end)];
y_recovered_60000 = real(ifft(Y_truncated_60000));

audiowrite('recovered_60000.wav', y_recovered_60000, Fs);
[y_play_60000, Fs_play_60000] = audioread('recovered_60000.wav');
player_60000 = audioplayer(y_play_60000, Fs_play_60000);
play(player_60000);


%--و--

D = dct(y(:,1));

% با 60000 نمونه
D_truncated_60000 = D(1:60000);
y_recovered_dct_60000 = idct([D_truncated_60000; zeros(length(D)-60000, 1)]);

audiowrite('recovered_dct_60000.wav', y_recovered_dct_60000, Fs);
[y_play_dct_60000, Fs_play_dct_60000] = audioread('recovered_dct_60000.wav');
player_dct_60000 = audioplayer(y_play_dct_60000, Fs_play_dct_60000);
play(player_dct_60000);

% با 120000 نمونه
D_truncated_120000 = D(1:120000);
y_recovered_dct_120000 = idct([D_truncated_120000; zeros(length(D)-120000, 1)]);

audiowrite('recovered_dct_120000.wav', y_recovered_dct_120000, Fs);
[y_play_dct_120000, Fs_play_dct_120000] = audioread('recovered_dct_120000.wav');
player_dct_120000 = audioplayer(y_play_dct_120000, Fs_play_dct_120000);
play(player_dct_120000);

