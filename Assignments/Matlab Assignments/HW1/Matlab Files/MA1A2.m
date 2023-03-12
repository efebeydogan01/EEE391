%% PART A
% A2
syms t
x(t) = piecewise(0 <= t & t < 1, 3*t, 1 <= t & t < 2, 5-t, 2 <= t & t < 3, 3);

fplot(x(mod(t, 3)), [0, 9]);

y = @(k) (3 * (-6*1i*pi*exp(2*1i*pi*k)*k - 3*exp(4*1i*pi*k/3) + 2*exp(2*1i*pi*k/3)*(6+1i*pi*k)-9) / (4*pi.^2*k.^2));

sum = 0;
magnitudes = zeros(1, 20);
phases = zeros(1, 20);
counter = 1;
indices = zeros(1, 20);
for ind = -10 : 10
    if ~isnan(y(ind))
        ak = y(ind);
        magnitudes(1, counter) = abs(ak);
        phases(1, counter) = angle(ak);
        indices(1, counter) = ind;
        counter = counter + 1;
    end
end

subplot(1,2,1);
stem(indices, magnitudes);
title('Plot of Magnitudes of Xks for k in [-10, 10]');
xlabel('k');
ylabel('Magnitude');

subplot(1,2,2);
stem(indices, phases);
title('Plot of Phases of Xks for k in [-10, 10]');
xlabel('k');
ylabel('Phase');