%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA
%% Function for Computing 2D convolution.

function convolution_output=Do_2D_convolution(First_Mat,Second_Mat) %Defining the variables of the function.
[row_First_Mat,column_First_Mat] = size(First_Mat); %Given the size of First Matrix.
[row_Second_Mat,column_Second_Mat] = size(Second_Mat); %Given the size of Secong Matrix.
h = rot90(Second_Mat, 2); %180 degree counterclockwise rotation of Second matrix
center = floor((size(h)+1)/2); %rounds the elements  to the nearest integers towards minus infinity
left = center(2) - 1;
right = column_Second_Mat - center(2);%Subtracting the number of colums of Second Matrix by center(2).
top = center(1) - 1;
bottom = row_Second_Mat - center(1); %%Subtracting the number of rows of Second Matrix by center(2).
Rep = zeros(row_First_Mat + top + bottom, column_First_Mat + left + right); %Making a Array of Zeros
for Iterator_1 = 1 + top : row_First_Mat + top % For loop for the Ieration
    for Iterator_2 = 1 + left : column_First_Mat + left
        Rep(Iterator_1,Iterator_2) = First_Mat(Iterator_1 - top, Iterator_2 - left);
    end
end
%Convolution output
convolution_output  = zeros(row_First_Mat , column_First_Mat); %Making a Array of Zeros.
for Iterator_1 = 1 : row_First_Mat %For loop for the Iteration.
    for Iterator_2 = 1 : column_First_Mat
        for IT_1 = 1 : row_Second_Mat
            for IT_2 = 1 : column_Second_Mat
                IT_3 = Iterator_1 - 1;
                IT_4 = Iterator_2 -1;
                convolution_output (Iterator_1, Iterator_2) = convolution_output (Iterator_1, Iterator_2) + (Rep(IT_1 + IT_3, IT_2 + IT_4) * h(IT_1, IT_2));
                % Adding convolution output to the + Arrays of Zeros
                % multiplying with 180 degree counterclockwise rotation.
            end
        end
    end
end
end
%%                                 END