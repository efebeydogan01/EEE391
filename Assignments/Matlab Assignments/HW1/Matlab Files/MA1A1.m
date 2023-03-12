%% PART A
% A1

%A1.1 
% plot of x_1(t)
t = [0 : 1/8192 : 1];
x1 = cos(2*pi*550*t);
plot(t, x1);
title('x_1(t) versus t');
xlabel('t: Time (sec)');
ylabel('A: Amplitude');

% soundsc(x1); 

x2 = cos(2*pi*430*t);
% soundsc(x2);

x3 = cos(2*pi*750*t);
% soundsc(x3);

% Bilkent ID: 21901548
f1 = 154; 
f2 = 190;
y = 2 * cos(2*pi*f1*t) + 3 * sin(2*pi*f2*t);
fmax = max(f1, f2);

% plot of y
% hold on;
plot(t, y);
title('y(t) versus t');
xlabel('t: Time (sec)');
ylabel('Amplitude');

% sampling rate fmax
fs = fmax;
t1 = [0 : 1/fs : 1];
y1 = 2 * cos(2*pi*f1*t1) + 3 * sin(2*pi*f2*t1);
stem(t1, y1);
title('y_1(t) versus t');
xlabel('Time Index (n)');
ylabel('Amplitude');

% sampling rate 2fmax
fs = 2 * fmax;
t2 = [0 : 1/fs : 1];
y2 = 2 * cos(2*pi*f1*t2) + 3 * sin(2*pi*f2*t2);
stem(t2, y2);
title('y_2(t) versus t');
xlabel('Time Index (n)');
ylabel('Amplitude');

% sampling rate 4fmax
fs = 4 * fmax;
t3 = [0 : 1/fs : 1];
y3 = 2 * cos(2*pi*f1*t3) + 3 * sin(2*pi*f2*t3);
stem(t3, y3);
title('y_3(t) versus t');
xlabel('Time Index (n)');
ylabel('Amplitude');

% reconstructing signal (sampling rate fmax)
reconstructed = reconstruction(y1, size(y1, 2), 1 / fmax, size(t, 2));
plot(t,reconstructed);
title('y_1(t) reconstructed versus t');
xlabel('t: Time (sec)');
ylabel('Amplitude');

% reconstructing signal (sampling rate 2fmax)
reconstructed = reconstruction(y2, size(y2, 2), 1 / (2*fmax), size(t, 2));
plot(t, reconstructed);
title('y_2(t) reconstructed versus t');
xlabel('t: Time (sec)');
ylabel('Amplitude');

% reconstructing signal (sampling rate 4fmax)
reconstructed = reconstruction(y3, size(y3, 2), 1 / (4*fmax), size(t, 2));
plot(t, reconstructed);
title('y_3(t) reconstructed versus t');
xlabel('t: Time (sec)');
ylabel('Amplitude');
% method for reconstruction
function[reconstructed] = reconstruction(sampledSignal, numberOfSamples, samplingPeriod, size)
    reconstructed = zeros(1, size);
    t = 0;
    for k = 1 : size
        for n = 1 : numberOfSamples
            reconstructed(1, k) = reconstructed(1, k) + sampledSignal(1, n) * (sin(pi * (t - n * samplingPeriod)) / samplingPeriod) / (pi * (t - n * samplingPeriod) / samplingPeriod);
        end
        t = t + 1/8192;
    end
end