%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA
%% Function for calculating the enery of the pixels
function Output_Energy = Energy_calculation_of_image(input_image_matrix )
if size(input_image_matrix,3)>1 % Comparing the image is RGB or not.
input_image_matrix = rgb2gray(input_image_matrix); % Convert RGB to Gray.
end
input_image_matrix_rgb_double = im2double(input_image_matrix); %converting to double.
horizontal_sobel_filter = [-1 0 1;-2 0 2;-1 0 1]; %Definging Horizontal Sobel Filter.
vertical_sobel_filter = [-1 -2 -1;0 0 0;1 2 1]; %Definging vertical Sobel Filter.
Sobel_convo_horizontal = Do_2D_convolution(input_image_matrix_rgb_double, horizontal_sobel_filter);% Computing Convolution using Hirizoltal Sobel Filter.
Sobel_convo_vertical = Do_2D_convolution(input_image_matrix_rgb_double, vertical_sobel_filter); %Computing Convolution using vertical Sobel Filter. 
Output_Energy=sqrt( Sobel_convo_horizontal.^2 + Sobel_convo_vertical.^2 ); %Computing the Square Root and Given Energy of the Image.
end
%%                                    END