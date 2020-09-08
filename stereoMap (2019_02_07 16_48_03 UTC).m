 clc
clear all
close all
%turns left image to grayscale
left=rgb2gray(imread( 'path\to\stereo_left.png')); 
%reads left image
left1=imread('path\to\stereo_left.png'); 
%turns right image to grayscale
right=rgb2gray(imread('path\to\stereo_right.png'));

%% Calculates DisparityMap
     [nrleft,ncleft]=size(left);
     [nrright,ncright]=size(right);
     %turn the type of the left and right image to double
      left=im2double(left);
      right=im2double(right);
      window_s=3;
      l=(window_s-1)/2;
  sad=0;
      pixels=0;
      dispMin=0;
      dispMax=18;
      dismap=zeros(nrleft,ncleft);
     for i=1+l:1:nrleft-l
       for j=ncleft-l:-1:1+l+dispMax
        sadmax=1000;
        b_match=dispMin;
        for p=dispMin:dispMax
            Left_region=left(i-l:i+l,j-l:j+l);
            Right_region=right(i-l:i+l,j-p-l:j-p+l);
            sad=sum(sum(abs(Left_region-Right_region)));
            if (sad<sadmax)
                sadmax=sad;
                b_match=p;
            end
        end
       
     dismap(i,j)=b_match;
     pixels=pixels+1;
       end
     end
[nr,nc]=size(dismap);
figure
imagesc(dismap); %%disparity Map color scaled

%% Last part 
[sizex,sizey,sizez] = size(left1); % create 3 variables equals to the size of the left image
final_1 = zeros(sizex , sizey, 3); %blank image         


for i=1:sizex
for j=1:sizey
if dismap(i,j) > 13.5
for d=1:3 
                    final_1(i,j,d) = left1(i,j,d);               
end
end
end
end


[xSize,ySize,zSize] = size(left1);


final_2 = zeros(xSize, ySize, 3);




for i=1:xSize
for j=1:ySize
if (dismap(i,j) > 9.8) && (dismap(i,j) < 13.0 )
for k=1:3 
                    final_2(i,j,k) = left1(i,j,k);               
end
end
end
end

final_1=medfilt3(final_1,[5 5 3]);
final_2=medfilt3(final_2,[5 5 3]);
% Display the outcomes
figure;
clf;
subplot(2,2,1); imshow(left); title('left image ');
subplot(2,2,2); imshow(uint8(final_1)); title(' closest to Camera');
subplot(2,2,3); imshow(left); title('Right image ');
subplot(2,2,4); imshow(uint8(final_2)); title('second closest to Camera');










