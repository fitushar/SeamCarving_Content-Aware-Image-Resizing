%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA

%% 
function Imported_Image=ZIP_OF_SEAM_CURVING(Imported_Image,Width_of_Image,Height_of_Image)

if Width_of_Image<10 || Height_of_Image<10
    error('very small dimensions!');
end

[New_Height_of_Image,New_Width_of_Image,count]=size(Imported_Image); %Finding the Imported Image Information
k=abs(Width_of_Image-New_Width_of_Image)+abs(Height_of_Image-New_Height_of_Image); %Find the Eclidean Distance
waitbar_Variable = waitbar(0,'Computation in Process. Please be patient.....');

count=0;

if New_Width_of_Image>Width_of_Image
   Difference_of_Width=New_Width_of_Image-Width_of_Image;
    for i=1:Difference_of_Width
        waitbar(count/k,waitbar_Variable,'Computation in Process. Please be patient.....');% Message to Waitbar
        Sobel_Energy=Energy_calculation_of_image(Imported_Image);% Energy Function is calling
        Determination_of_SEAM = Finding_Seam_Vertically(Sobel_Energy); % finding seam function calling
        [Imported_Image]=New_Image_After_VER_Remove(Imported_Image,Determination_of_SEAM);% reomove seam function calling
        count=count+1;
    end
end

if New_Height_of_Image>Height_of_Image % Comparison between Two different Height of images 
   Difference_of_Width=New_Height_of_Image-Height_of_Image; %Difference between two image width
    for i=1:Difference_of_Width
        waitbar(count/k,waitbar_Variable,'Computation in Process. Please be patient.....');% Message to Waitbar
        Sobel_Energy=Energy_calculation_of_image(Imported_Image);% Energy Function calling
        Determination_of_SEAM = Finding_Seam_Horizontally(Sobel_Energy); % Finding Seam Function calling
        [Imported_Image]=New_Image_After_HOR_Remove(Imported_Image,Determination_of_SEAM); % Remove seam function calling
        count=count+1;
    end
end
if New_Height_of_Image<Height_of_Image % Comparison between Two different Height of images 
    I=Imported_Image;
    Difference_of_Width=Height_of_Image-New_Height_of_Image;%Difference between two image width
    for i=1:Difference_of_Width
        waitbar(count/k,waitbar_Variable,'Computation in Process. Please be patient.....');% Message to Waitbar
        Sobel_Energy=Energy_calculation_of_image(I);
        Determination_of_SEAM = Finding_Seam_Horizontally(Sobel_Energy);
        
        [Imported_Image,I]=Horizontally_Add_SEAM(Imported_Image,Determination_of_SEAM,I); % ADD seam function calling
        count=count+1;
    end
end
if New_Width_of_Image<Width_of_Image
    Difference_of_Width=Width_of_Image-New_Width_of_Image; %Difference between two image width
    I=Imported_Image;% New Image Variable I
    for i=1:Difference_of_Width
        waitbar(count/k,waitbar_Variable,'Computation in Process. Please be patient.....');% Message to Waitbar
        Sobel_Energy=Energy_calculation_of_image(I); % Energy finding function calling
         Determination_of_SEAM = Finding_Seam_Vertically(Sobel_Energy); %Finding Seam Function calling
        [Imported_Image,I]=Vertically_Add_SEAM(Imported_Image,Determination_of_SEAM,I); %Add seam Calling
        count=count+1;
    end
end
close(waitbar_Variable); %Clossing the Waitbar Variables
end
%%                                END