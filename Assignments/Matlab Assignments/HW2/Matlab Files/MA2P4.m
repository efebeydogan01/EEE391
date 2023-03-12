image = ReadMyImage("Part4.bmp");
mean = 0;
std1 = 0.1;
std2 = 0.25;
std3 = 0.5;
s = size(image);
image1 = image + random('norm', mean, std1, s);
image2 = image + random('norm', mean, std2, s);
image3 = image + random('norm', mean, std3, s);

% DisplayMyImage(image1);
% DisplayMyImage(image2);
% DisplayMyImage(image3);

% code for preparing h
D = 21901548;
D17 = rem(D, 17);
Mh = 20 + D17;
Nh = 20 + D17;  
B1 = 0.5;
B2 = 0.2;
B3 = 0.05;
h1 = zeros(Mh, Nh);
for m = 1 : Mh
    for n = 1 : Nh
        h1(m, n) = sinc(B1 * (m - (Mh - 1) / 2)) .* sinc(B1 * (n - (Nh - 1) / 2)); % line that prepares the matrix h
    end
end

h2 = zeros(Mh, Nh);
for m = 1 : Mh
    for n = 1 : Nh
        h2(m, n) = sinc(B2 * (m - (Mh - 1) / 2)) .* sinc(B2 * (n - (Nh - 1) / 2)); % line that prepares the matrix h
    end
end

h3 = zeros(Mh, Nh);
for m = 1 : Mh
    for n = 1 : Nh
        h3(m, n) = sinc(B3 * (m - (Mh - 1) / 2)) .* sinc(B3 * (n - (Nh - 1) / 2)); % line that prepares the matrix h
    end
end

% code for displaying processed images
out1 = DSLSI2D(h1, image3);
subplot(1,3,1);
imshow(out1, []);
title("Image denoised with B = " + string(B1));

out2 = DSLSI2D(h2, image3);
subplot(1,3,2);
imshow(out2, []);
title("Image denoised with B = " + string(B2));

out3 = DSLSI2D(h3, image3);
subplot(1,3,3);
imshow(out3, []);
title("Image denoised with B = " + string(B3));

function [y] = DSLSI2D(h,x)
    [Mh, Nh] = size(h);
    [Mx, Nx] = size(x);
    y = zeros(Mx + Mh - 1, Nx + Nh - 1);

    for k = 0 : Mh - 1
        for l = 0 : Nh - 1
            y(k+1:k+Mx, l+1:l+Nx) = y(k+1:k+Mx, l+1:l+Nx) + h(k+1, l+1) * x;
        end
    end
end


