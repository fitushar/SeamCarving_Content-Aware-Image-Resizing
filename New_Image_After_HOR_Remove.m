%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA
%%
function HOR_Image = New_Image_After_HOR_Remove(Input_Image,Imported_SEAM)

Initial_Define_Mask=zeros(size(Input_Image,1),size(Input_Image,2));% Initial Masking Define
newSize=[size(Input_Image,1)-1,size(Input_Image,2)]; 
CASE=0; 
linearInd=sub2ind([size(Input_Image,1),size(Input_Image,2)], Imported_SEAM(:,:,1), Imported_SEAM(:,:,2));%Convert subscripts to linear indices
C=setdiff(1:size(Input_Image,1)*size(Input_Image,2),linearInd);% Set difference of two arrays
NewGray_Define=zeros(length(C),size(Input_Image,3));
HOR_Image=zeros(newSize(1),newSize(2),size(Input_Image,3));  
Initial_Define_Mask=Initial_Define_Mask(:);
Initial_Define_Mask=Initial_Define_Mask(C);
Initial_Define_Mask=reshape(Initial_Define_Mask,newSize);
for Iterator=1:size(Input_Image,3)
    gray=Input_Image(:,:,Iterator); 
    gray=gray(:); 
    NewGray_Define(:,Iterator)=gray(C); 
    HOR_Image(:,:,Iterator)=reshape(NewGray_Define(:,Iterator),newSize);%Reshape the Array
end

if CASE==1 
    New_Image=zeros(size(HOR_Image,2),size(HOR_Image,1),size(HOR_Image,3)); 
    for Iterator=1:size(Input_Image,3) 
        New_Image(:,:,Iterator)=HOR_Image(:,:,Iterator)'; 
    end
    HOR_Image=New_Image;
    clear New_Image; %Delete variable to save memory
end
HOR_Image=uint8(HOR_Image);
end
%%                            END