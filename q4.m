inputImage = imread('F1.jpg');
factor = 4

out_nni = RESIZE_nni(inputImage, factor);
imshow(out_nni);
figure();
out_bi = RESIZE_bi(inputImage, factor);
imshow(out_bi);

function [outputImage] = RESIZE_nni(inputImage, factor)
scale = [factor factor];              %# The resolution scale factors: [rows columns]
oldSize = size(inputImage);                   %# Get the size of your image
newSize = max(floor(scale.*oldSize(1:2)),1);  %# Compute the new image size

rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));
%# Index old image to get new image:
outputImage = inputImage(rowIndex,colIndex,:);
% imshow(outputImage);
end



function [out] = RESIZE_bi(im, factor)

    out_dims = factor * size(im);
    %// Get some necessary variables first
    in_rows = size(im,1);
    in_cols = size(im,2);
    out_rows = out_dims(1);
    out_cols = out_dims(2);
    S_R = in_rows / out_rows;
    S_C = in_cols / out_cols;
    [cf, rf] = meshgrid(1 : out_cols, 1 : out_rows);

    rf = rf * S_R;
    cf = cf * S_C;

    r = floor(rf);
    c = floor(cf);

    r(r < 1) = 1;
    c(c < 1) = 1;
    r(r > in_rows - 1) = in_rows - 1;
    c(c > in_cols - 1) = in_cols - 1;

    delta_R = rf - r;
    delta_C = cf - c;

    in1_ind = sub2ind([in_rows, in_cols], r, c);
    in2_ind = sub2ind([in_rows, in_cols], r+1,c);
    in3_ind = sub2ind([in_rows, in_cols], r, c+1);
    in4_ind = sub2ind([in_rows, in_cols], r+1, c+1);       

    %// Now interpolate
    %// Go through each channel for the case of colour
    %// Create output image that is the same class as input
    out = zeros(out_rows, out_cols, size(im, 3));
    out = cast(out, class(im));

    for idx = 1 : size(im, 3)
        chan = double(im(:,:,idx)); %// Get i'th channel
        %// Interpolate the channel
        tmp = chan(in1_ind).*(1 - delta_R).*(1 - delta_C) + ...
                       chan(in2_ind).*(delta_R).*(1 - delta_C) + ...
                       chan(in3_ind).*(1 - delta_R).*(delta_C) + ...
                       chan(in4_ind).*(delta_R).*(delta_C);
        out(:,:,idx) = cast(tmp, class(im));
    end
end