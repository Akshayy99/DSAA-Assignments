in = audiorecorder(44100, 24, 1);

disp('Start speaking.');
recordblocking(in, 3);
disp('End of recording.');

% play(in);
y = getaudiodata(in);

y1 = resample(y, 24000, 44100);
y2 = resample(y, 16000, 44100);
y3 = resample(y, 8000, 44100);
y4 = resample(y, 4000, 44100);

plot(y);
hold on
plot(y1);plot(y2);plot(y3);plot(y4);
hold off
BTCombined = [y1;y2;y3;y4]
% sound(BT  Combined);

xu1 = audioread('SMALL CHURCH E001 M2S.wav');
xu2 = audioread('HIGH DAMPING CAVE E001 M2S.wav');
xu3 = audioread('BIG HALL E001 M2S.wav');

xvec = y3(:);
x1 = xu1(:);
x2 = xu2(:);
x3 = xu3(:);

yu1 = conv(xvec, y1);
yu2 = conv(xvec, y2);
yu3 = conv(xvec, x3);

% sound(yu3);
