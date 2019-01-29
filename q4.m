inputImage = imread('F1.jpg');
fac = 4;
% imshow(inputImage);
outNN = resize_NN(inputImage, 10);
imshow(outNN);


outBI = resizeBI(inputImage, 3);
% imshow(outBI);

function out = resize_NN(I, fac)
[rows, cols, depth] = size(I);
new_rows = rows * fac;
new_cols = cols * fac;
out = zeros(new_rows, new_cols, depth);
for i = 1:rows
   for j = 1:cols
       for k = 1:depth
            out((i-1)*fac+1:i*fac,(j-1)*fac+1:j*fac,k) = I(i,j,k);
        end
    end
end
out = uint8(out);
end

function out = resizeBI(I, fac)
[rows, cols, depth] = size(I);
new_rows = rows*fac;
new_cols = cols*fac;
out = zeros(new_rows, new_cols, depth,'double');
for i = 1:rows
    for j = 1:cols
        for k = 1:depth
            out((i-1)*fac+1, (j-1)*fac+1, k) = I(i,j,k);
        end
    end
end

for i = 1:rows
    for j = 1:cols-1
        for k = 1:depth
            for x = 1:fac
                out((i-1)*fac+1,(j-1)*fac+x,k) = ((fac-x)*out((i-1)*fac+1,(j-1)*fac+1,k)+x*out((i-1)*fac+1,j*fac+1,k))/fac;
            end
        end
    end
end
for i = 1:new_rows-fac
    for j = 1:cols
        for k = 1:depth
            for x = 1:fac
                out(i,(j-1)*fac+x,k) = ((fac-x)*out((floor((i-1)/fac))*fac+1,(j-1)*fac+x,k)+x*out((floor((i-1)/fac)+1)*fac+1,(j-1)*fac+x,k))/fac;
            end
        end
    end
end
out = uint8(out);
end

                



