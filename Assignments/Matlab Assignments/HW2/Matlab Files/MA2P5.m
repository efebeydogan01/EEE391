x = ReadMyImage("Part5.bmp");
DisplayMyImage(x);

% processing image with h1 filter
h1 = [1 0 -1; 2 0 -2; 1 0 -1];
y1 = DSLSI2D(h1, x);
DisplayMyImage(y1.^2);

% processing image with h2 filter
h2 = [1 2 1; 0 0 0; -1 -2 -1];
y2 = DSLSI2D(h2, x);
DisplayMyImage(y2.^2);

% processing image with s3
DisplayMyImage(sqrt(y1.^2 + y2.^2));

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