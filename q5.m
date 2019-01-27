[in,fs] = audioread('sa_re_ga_ma.wav');
start = 100
finish = 200

subplot(5,2,1);
plot(in(start : finish));
title('Original');
    
test1 = smoothdata(in,'movmean');
subplot(5,2,2);
plot(test1(start : finish));
title('Movmean');

test2 = smoothdata(in,'movmedian');
subplot(5,2,3);
plot(test2(start : finish));
title('Movmedian');

test3 = smoothdata(in,'gaussian');
subplot(5,2,4);
plot(test3(start : finish));
title('Gaussian');

test4 = smoothdata(in,'lowess');
subplot(5,2,5);
plot(test4(start : finish));
title('Lowess');

test5 = smoothdata(in,'loess');
subplot(5,2,6);
plot(test5(start : finish));
title('Loess');

test6 = smoothdata(in,'rlowess');
subplot(5,2,7);
plot(test6(start : finish));
title('Rlowessp');

test7 = smoothdata(in,'rloess');
subplot(5,2,8);
plot(test7(start : finish));
title('Rloess');

test8 = smoothdata(in,'sgolay');
subplot(5,2,9);
plot(test8(start : finish));
title('Sgolay');

test9 = smoothdata(in,'includenan');
subplot(5,2,10);
plot(test9(start : finish));
title('IncludeNan');


% sound(test1, fs);