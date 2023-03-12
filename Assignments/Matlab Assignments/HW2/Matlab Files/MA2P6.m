x = ReadMyImage("Part6x.bmp");
% DisplayMyImage(x);

y = ReadMyImage("Part6h.bmp");
% DisplayMyImage(y);

% passing the image through the system
out = DSLSI2D(y, x);
% DisplayMyImage(abs(out));
DisplayMyImage(abs(out).^3);
DisplayMyImage(abs(out).^5);

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
