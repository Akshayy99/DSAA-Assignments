
face = rgb2gray(imread('F1.jpg'));
faces = rgb2gray(imread('Faces.jpg'));

c = normxcorr2(face, faces);
% figure, surf(c), shading flat

[ypeak, xpeak] = find(c==max(c(:)));

yoffset = ypeak-size(face,1);
xoffset = xpeak-size(face,2);

figure, imshow(faces);
imrect(gca, [xoffset+1,yoffset+1, size(face,2), size(face,1)]);
