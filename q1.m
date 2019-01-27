[x, Fs] = audioread('sa_re_ga_ma.mp3');
y = resample(x, 1, 2);
z = resample(x, 2, 1);
plot(z);
hold on;
plot(x);
plot(y);

sound(y, Fs);


