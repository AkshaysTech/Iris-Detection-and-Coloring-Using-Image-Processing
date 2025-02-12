clc; close all; clear all;
i=imread('A_blue_eye.jpg');
imshow(i); title('Original Image')
i_bw=im2bw(imread('akshayeyes.jpg'));
imshow(i_bw); title('BW Image')
i_edge=edge(i_bw,"canny",[0.02 0.8]);
imshow  (i_edge); title('Edge using Canny')
i_close=imclose(i_edge,strel('disk',4,8)); 
imshow(i_close); title('closing')
% i_close=1-i_close;
% imshow(i_close)
i_fill=imfill(i_close,'holes'); 
imshow(i_fill); title('Filling of closed image')
i_mask=bwareaopen(imopen(i_fill,strel(ones(10,10))),50000); 
imshow(i_mask); title('BW Segmented Iris')
i_r=i(:,:,1).*uint8(i_mask);
i_g=i(:,:,2).*uint8(i_mask);

i_b=i(:,:,3).*uint8(i_mask);
i_seg=cat(3,i_r,i_g,i_b);
imshow(i_seg)
% adjust hue in hsv using imtweak()
% lvlpict = imadjust(i,[0 0.75],[0.15 1],1.2);
% % directly replace H and S instead of adjusting original values
% cpict = colorpict(size(i),[160 40 200],'uint8');
% adjustedpict = imblend(255-lvlpict,cpict,1,'transfer lhsl>shsl'); % adjust cast saturation
% adjustedpict = imblend(lvlpict,adjustedpict,1,'lightness'); % then colorize
% % combine images with linear composition in linear RGB
% outpict = replacepixels(adjustedpict,inpict,i_seg,'linear');
% imshow(outpict);
% [centers,radii] = imfindcircles(i1,[20 25],"ObjectPolarity","dark","Sensitivity",0.9);
% 
% si = imdilate(i1,strel('line',3,0));
% se = imerode(i1,strel('line',3,0));
% I = imsubtract(si,se);
% imshow(I)
% i1=imopen(i1,se);
% i1=imfill(i1,"holes");
% i1=imclearborder(i1);
% imshow(i1)
% % 
% I1=imclose(i1,strel('arbitrary',5));
% imshow(I1)
% 
% % [centersBright, radiiBright] = imfindcircles(I,[15 30]);
% % viscircles(centersBright, radiiBright,'Color','b');

% mask = uint8(zeros(627,640,3));
% mask(:,:,1)=0;
% mask(:,:,2)=56;
% mask(:,:,3)=0;
% imshow(mask)
% out = i_seg.*mask;
% imshow(out)
% C = bsxfun(@times,i_seg, mask);
% imshow(C)
% result = bsxfun(@plus,i,C);
% imshow(result)

i1_hsv=rgb2hsv(i);
i_hsv=rgb2hsv(i_seg);
new(:,:,1)=0;
new(:,:,2)=130;
new(:,:,3)=0;
i_hsv=double(i_hsv);
new2=i_hsv.*new;
imshow(new2)
A = bsxfun(@times,i_hsv, new);
imshow(A)
% result1=i1_hsv+new2;
% new3=hsv2rgb(new2);
% % result = bsxfun(@plus,i,uint8(new3));
% result=hsv2rgb(result1);
% imshow(uint8(result),[])

HSV = rgb2hsv(i_seg);
 
% Obtaining Hue channel/matrix of the HSV color space
 H = HSV(:,:,1);
 S = HSV(:,:,2);
 V = HSV(:,:,3);
% Converting All hue values lower than the mean 
% value of Hue channel to .7(blue)
 H( H > mean2(H) ) =0.2;
% Replacing the original HSV channel by the current one
 HSV(:,:,1) = H;
 % Converting the HSV channel to RGB for displaying
C = hsv2rgb(HSV);
figure,imshow(C);title('Color Sliced to Blue');
imwrite(C,'colourspliced.jpeg');
[m,n]=size(C);

% result = bsxfun(@plus,double(i),C);
% imshow(result)
% [r c]=size(C);
% figure();
% M = repmat(all(~C,3),[1 1 3]); %mask black parts
% C(M) = 1;
% imshow(C); title('White Background')
i_mask1=1-i_mask;
i_new=i.*uint8(i_mask1);
imshow(i_new);
%result1 = infuse(i_new,uint8(C));
%result1 = bsxfun(@plus,i_new,uint8(C));
result1=im2double(i_new)+C;
imshow(result1); title('Output')

a=imread("6.PNG");
imshow(a)
a1=imresize(a,[m n/3]);
D= im2double(i_seg) .* im2double(a1);
imshow(D,[])
% LAB=rgb2lab(i_seg);
% LAB(:,:,1)=4;
% LAB(:,:,2)=-60;
% LAB(:,:,3)=30;
% h=rgb2lab(LAB);
% figure()
% imshow(h);
% i_mask1=1-i_mask;
% i_new=i.*uint8(i_mask1);
% imshow(i_new);
% %result1 = infuse(i_new,uint8(C));
% %result1 = bsxfun(@plus,i_new,uint8(C));
% result1=im2double(i_new)+h;
% imshow(result1); title('Output')
