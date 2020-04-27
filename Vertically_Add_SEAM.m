%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA

%%   
function [VER_IMAGE_1,VER_IMAGE_2] = Vertically_Add_SEAM( First_Image_Import,Imported_SEAM,Duplicate_Image_Import)
MASK_VER=zeros(size(First_Image_Import,1),size(First_Image_Import,2));% Define the Mask variables that for memory allocations
        
Image_1_Memory=zeros(size(First_Image_Import,2),size(First_Image_Import,1),size(First_Image_Import,3)); %memory allocation
Image_2_Memory=zeros(size(Duplicate_Image_Import,2),size(Duplicate_Image_Import,1),size(Duplicate_Image_Import,3)); %memory allocation
        
for Iterator=1:size(First_Image_Import,3)
    Image_1_Memory(:,:,Iterator)=First_Image_Import(:,:,Iterator)'; 
    Image_2_Memory(:,:,Iterator)=Duplicate_Image_Import(:,:,Iterator)';
end
First_Image_Import=Image_1_Memory;
Duplicate_Image_Import=Image_2_Memory;
MASK_VER=MASK_VER';
clear Image_1_Memory;  % clean the memory after use to save the momory used
clear Image_2_Memory;% clean the memory after use to save the momory used
newSize=[size(First_Image_Import,1)+1,size(First_Image_Import,2)]; 
Temporary_SEAM(1,:,2)=Imported_SEAM(1,:,1); 
Temporary_SEAM(1,:,1)=Imported_SEAM(1,:,2);
Imported_SEAM=Temporary_SEAM;
clear Temporary_SEAM; % clean the memory after use to save the momory used
CASE=1; 

linearInd=sub2ind([size(First_Image_Import,1),size(First_Image_Import,2)], Imported_SEAM(:,:,1), Imported_SEAM(:,:,2));
Doublicate_SEAM=sort(cat(2,1:size(First_Image_Import,1)*size(First_Image_Import,2),linearInd)); %doublicate seam indicies
newInd=zeros(size(linearInd)); 
for IT_1=1:length(linearInd)
    ind=find(Doublicate_SEAM==linearInd(IT_1)); 
    newInd(IT_1)=ind(1); 
end
newGray=zeros(length(Doublicate_SEAM),size(First_Image_Import,3)); 
newGray2=zeros(length(Doublicate_SEAM),size(First_Image_Import,3));
VER_IMAGE_1=zeros(newSize(1),newSize(2),size(First_Image_Import,3)); 
VER_IMAGE_2=zeros(newSize(1),newSize(2),size(First_Image_Import,3)); 
MASK_VER=MASK_VER(:);
MASK_VER=MASK_VER(Doublicate_SEAM);
MASK_VER=reshape(MASK_VER,newSize);
for Iterator=1:size(First_Image_Import,3)
    gray=First_Image_Import(:,:,Iterator); 
    gray=gray(:); 
    gray2=Duplicate_Image_Import(:,:,Iterator);
    gray2=gray2(:);
    newGray(:,Iterator)=gray(Doublicate_SEAM);
    newGray2(:,Iterator)=gray2(Doublicate_SEAM);
    
    newInd_previous=newInd-1; 
    newInd_next=newInd+1; 
    newInd_previous(newInd_previous==0)=newInd_previous(newInd_previous==0)+1; 
    newInd_next(newInd_next>newSize(1)*newSize(2))=...
    newInd_next(newInd_next>newSize(1)*newSize(2))-1; 

    newGray2(newInd,Iterator)=abs(newGray2(newInd,Iterator)-randi(255));
    newGray2(newInd_previous,Iterator)=randi(255);
    newGray2(newInd_next,Iterator)=abs(newGray2(newInd,Iterator)+randi(255));
    VER_IMAGE_1(:,:,Iterator)=reshape(newGray(:,Iterator),newSize); 
    VER_IMAGE_2(:,:,Iterator)=reshape(newGray2(:,Iterator),newSize); 
end

if (CASE==1) 
    Image_1_Memory=zeros(size(VER_IMAGE_1,2),size(VER_IMAGE_1,1),size(VER_IMAGE_1,3));
    Image_2_Memory=zeros(size(VER_IMAGE_1,2),size(VER_IMAGE_1,1),size(VER_IMAGE_1,3));
    for Iterator=1:size(First_Image_Import,3)
        Image_1_Memory(:,:,Iterator)=VER_IMAGE_1(:,:,Iterator)';
        Image_2_Memory(:,:,Iterator)=VER_IMAGE_2(:,:,Iterator)';
    end
    VER_IMAGE_1=uint8(Image_1_Memory); %convert to Uint8 types
    VER_IMAGE_2=uint8(Image_2_Memory);%convert to Uint8 types
    clear Image_1_Memory;% clean the memory after use to save the momory used
    clear Image_2_Memory;% clean the memory after use to save the momory used
end
end
%%                                  END