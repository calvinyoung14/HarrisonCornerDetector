clear;
 im1 = imread('left.jpg');
 im2 = imread('right.jpg');
 
 thresh = 10000;
 radius = 3;
 N = 1000;
 subpixel = false;
 disp = true;
 sigma = 3;
 k = 0.04;
 
  % Compute derivatives and the elements of the structure tensor.
    [Ix, Iy] = derivative5(im1, 'x', 'y');
    Ix2 = gaussfilt(Ix.^2,  sigma);
    Iy2 = gaussfilt(Iy.^2,  sigma);    
    Ixy = gaussfilt(Ix.*Iy, sigma); 
    
    [IxR, IyR] = derivative5(im2, 'x', 'y');
    Ix2R = gaussfilt(IxR.^2,  sigma);
    Iy2R = gaussfilt(IyR.^2,  sigma);    
    IxyR = gaussfilt(IxR.*IyR, sigma); 

    % Compute Harris corner measure. 
    cim = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2; 
    cim2 = (Ix2R.*Iy2R - IxyR.^2) - k*(Ix2R + Iy2R).^2;



            [r,c] = nonmaxsuppts(cim, 'thresh', thresh, 'radius', radius, 'N', N, ...
                                 'subpixel', subpixel, 'im', im1);
                             
            [r2,c2] = nonmaxsuppts(cim2, 'thresh', thresh, 'radius', radius, 'N', N, ...
                                 'subpixel', subpixel, 'im', im2);