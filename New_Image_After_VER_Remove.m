%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA

%% 
function VAR_Image = New_Image_After_VER_Remove(Input_Image,Imported_SEAM)

Define_Initial_MASK=zeros(size(Input_Image,1),size(Input_Image,2));% DEfine the initial MASK
Image_Memory=zeros(size(Input_Image,2),size(Input_Image,1),size(Input_Image,3)); % Memory AllocationS
for IT_1=1:size(Input_Image,3)
    Image_Memory(:,:,IT_1)=Input_Image(:,:,IT_1)'; 
           
end
Input_Image=Image_Memory;
Define_Initial_MASK=Define_Initial_MASK';
clear Image_Memory; % Delete the variable after using to save the memory
newSize=[size(Input_Image,1)-1,size(Input_Image,2)]; 
New_Seam(1,:,2)=Imported_SEAM(1,:,1); 
New_Seam(1,:,1)=Imported_SEAM(1,:,2);
Imported_SEAM=New_Seam;
clear New_Seam; % Delete the variable after using to save the memory
CASE=1;
linearInd=sub2ind([size(Input_Image,1),size(Input_Image,2)], Imported_SEAM(:,:,1), Imported_SEAM(:,:,2));
C=setdiff(1:size(Input_Image,1)*size(Input_Image,2),linearInd);
newGray=zeros(length(C),size(Input_Image,3)); 
VAR_Image=zeros(newSize(1),newSize(2),size(Input_Image,3));  
Define_Initial_MASK=Define_Initial_MASK(:);
Define_Initial_MASK=Define_Initial_MASK(C);
Define_Initial_MASK=reshape(Define_Initial_MASK,newSize);%Reshape array
for IT_1=1:size(Input_Image,3)
    gray=Input_Image(:,:,IT_1); 
    gray=gray(:); 
    newGray(:,IT_1)=gray(C); 
    VAR_Image(:,:,IT_1)=reshape(newGray(:,IT_1),newSize); %Reshape array
    
end

if CASE==1 
    Image_Memory=zeros(size(VAR_Image,2),size(VAR_Image,1),size(VAR_Image,3)); 
    for IT_1=1:size(Input_Image,3) 
        Image_Memory(:,:,IT_1)=VAR_Image(:,:,IT_1)'; 
    end
    VAR_Image=Image_Memory;
    clear Image_Memory; % Delete the variable after using to save the memory
end
VAR_Image=uint8(VAR_Image); % Conversion to Uint8
end
%%                           END
