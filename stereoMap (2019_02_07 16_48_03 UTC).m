leftImage = imread('stereo_left.png');              %Reads Left Image
rightImage = imread('stereo_right.png');            %Reads Right Image

leftImage = mean(leftImage, 3);
rightImage = mean(rightImage, 3);

leftsmall = imread('stereo_left.png');
rightsmall = imread('stereo_right.png');

worsemap = disparitymap(leftsmall, rightsmall);     %Calculates DisparityMap

badmap = disparity2reloaded(leftsmall, rightsmall); %Recalculates with less error

dispmap = dispmap3ThisTimeItsPersonal(leftImage, rightImage);   %Last and Final Disparity Map

figure;
clf;



subplot(2,2,1); imshow(leftImage,[0,255]); title('Original Black & White');
a = max(max(worsemap));
subplot(2,2,2); imshow(worsemap,[0,a]); title('Worse Map');
a = max(max(badmap));
subplot(2,2,3); imshow(badmap,[0,a]); title('Bad Map');
a = max(max(dispmap));
subplot(2,2,4); imshow(dispmap,[0,a]); title('Disparity Map');


doubleDM = double(dispmap);                                     % Make dispMap double

%% Next Mission !


[sizex sizey sizez] = size(leftsmall);          %Create 3 Variables with the same size
                                                %as the leftsmall image
                                                
final_1 = zeros(sizex , sizey, sizez);          %Create a blank image ready to be painted
 

%% Copying Algorithm! 
%*************************************************************************
%*** Copy And Paste the pixels that appear closest to camera *************
%*** Based on the results of the 2 Dimensional Disparity Map *************
%*************************************************************************

for i=1:sizex                                   
        for j=1:sizey
            if doubleDM(i,j) > 13.5
                for d=1:3 
                    final_1(i,j,d) = leftsmall(i,j,d);               
                end
            end
        end
end


[xSize ySize zSize] = size(leftsmall);


final_2 = zeros(xSize, ySize, zSize);



 
for i=1:xSize                                   
        for j=1:ySize
            if (doubleDM(i,j) > 9.8) && (doubleDM(i,j) < 13.0 )
                for k=1:3 
                    final_2(i,j,k) = leftsmall(i,j,k);               
                end
            end
        end
end



figure;
clf;
subplot(2,2,1); imshow(leftsmall); title('left image to be copied');
subplot(2,2,2); imshow(uint8(final_1)); title('Object closest to Camera');
subplot(2,2,3); imshow(leftsmall); title('Right image to be copied');
subplot(2,2,4); imshow(uint8(final_2)); title('Object between two distances');
