%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA

%%                
clear all;
clc;
close all;
%% Read the image from the workspace/Devices
I=imread('Test_Iamge_2.bmp');
%%
                 %Shrinking the Image

%Define the vertical and horizontal Shrink value
n_Vertical_Shrink=50;
n_Horizontal_Shrink=50;
%% Vertical Shrink
for i=1:n_Vertical_Shrink
    Sobel_Energy=Energy_calculation_of_image(I); % Call the energy Function
    Vertical_Seam = Finding_Seam_Vertically(Sobel_Energy); %finding the SEAM
    I=New_Image_After_VER_Remove(I,Vertical_Seam); % Remove SEAM
    imshow(I);
end
%% Horizontal Shrink
for i=1:n_Horizontal_Shrink
    Sobel_Energy=Energy_calculation_of_image(I);% Call the energy Function
    Horizontal_Seam = Finding_Seam_Horizontally(Sobel_Energy);%finding the SEAM
    I=New_Image_After_HOR_Remove(I,Horizontal_Seam); % Remove SEAM
    imshow(I);
end
%% Saving of the shrinking Image
imwrite(I,'Output_Shrink_Image.bmp');
%%
                   %Enlarging the Image
                   
%Define the vertical and horizontal Enlarging value
n_Vertical_Enlarge=50;
n_Horizontal_Enlarge=50;
%%
I2=I; %I2 to avoid add same seams
f1 = figure('IntegerHandle','off'); %new image figure
f2 = figure('IntegerHandle','off'); %seam image figure
%% Vertical Enlarge
for i=1:n_Vertical_Enlarge
    Sobel_Energy=Energy_calculation_of_image(I2); % Call the energy Function
    Vertical_Seam = Finding_Seam_Vertically(Sobel_Energy);%finding the SEAM
    [I,I2]=Vertically_Add_SEAM(I,Vertical_Seam,I2); % Add SEAM
    figure(f1);
    imshow(I);
    figure(f2);
    imshow(I2);
end
%% Horizontal Enlarge
for i=1:n_Horizontal_Enlarge;
    Sobel_Energy=Energy_calculation_of_image(I2);% Call the energy Function
    Horizontal_Seam = Finding_Seam_Horizontally( Sobel_Energy);%finding the SEAM
    [I,I2]=Horizontally_Add_SEAM(I,Horizontal_Seam,I2); % Add SEAM
    figure(f1);
    imshow(I);
    figure(f2);
    imshow(I2);
end
%% Saving of the Enlarging Image
imwrite(I,'Output_Enlarge_Image.bmp');
%% Saving of the Seaming Image
imwrite(I2,'Output_Seam_path_Image.bmp');
%%                                   THE END