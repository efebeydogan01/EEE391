A = ReadMyImage("Part5.bmp");
DisplayMyImage(A);

x = [2 1 1; -3 0 2; 1 -1 2];
h = [2 1; -1 0];

disp( DSLSI2D(h, x));

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
