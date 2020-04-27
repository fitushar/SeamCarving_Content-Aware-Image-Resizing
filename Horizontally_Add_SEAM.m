%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA

%%   
function [HOR_IAMGE_1,HOR_IMAGE_2] = Horizontally_Add_SEAM(First_Imported_Image,Imported_SEAM ,Duplicate_Image_of_First)

Initialization_OF_Mask=zeros(size(First_Imported_Image,1),size(First_Imported_Image,2));
NewSize_Image=[size(First_Imported_Image,1)+1,size(First_Imported_Image,2)]; 
CASE=0; 
linearInd=sub2ind([size(First_Imported_Image,1),size(First_Imported_Image,2)], Imported_SEAM(:,:,1), Imported_SEAM(:,:,2)); %Convert subscripts to linear indices
C_VAR=sort(cat(2,[1:size(First_Imported_Image,1)*size(First_Imported_Image,2)],linearInd)); %Sort array elements
newInd=zeros(size(linearInd)); 
for i=1:length(linearInd)
    ind=find(C_VAR==linearInd(i)); %Convert subscripts to linear indices
    newInd(i)=ind(1); 
end
newGray=zeros(length(C_VAR),size(First_Imported_Image,3)); 
newGray2=zeros(length(C_VAR),size(First_Imported_Image,3));
HOR_IAMGE_1=zeros(NewSize_Image(1),NewSize_Image(2),size(First_Imported_Image,3)); 
HOR_IMAGE_2=zeros(NewSize_Image(1),NewSize_Image(2),size(First_Imported_Image,3)); 
Initialization_OF_Mask=Initialization_OF_Mask(:);
Initialization_OF_Mask=Initialization_OF_Mask(C_VAR);
Initialization_OF_Mask=reshape(Initialization_OF_Mask,NewSize_Image);
for Iterator=1:size(First_Imported_Image,3)
    gray=First_Imported_Image(:,:,Iterator); 
    gray=gray(:); 
    gray2=Duplicate_Image_of_First(:,:,Iterator);
    gray2=gray2(:);
    newGray(:,Iterator)=gray(C_VAR); 
    newGray2(:,Iterator)=gray2(C_VAR);
    newInd_previous=newInd-1; 
    newInd_next=newInd+1; 
    newInd_previous(newInd_previous==0)=newInd_previous(newInd_previous==0)+1; 
    newInd_next(newInd_next>NewSize_Image(1)*NewSize_Image(2))=...
    newInd_next(newInd_next>NewSize_Image(1)*NewSize_Image(2))-1; 
    newGray2(newInd,Iterator)=abs(newGray2(newInd,Iterator)-randi(255));
    newGray2(newInd_previous,Iterator)=randi(255);
    newGray2(newInd_next,Iterator)=abs(newGray2(newInd,Iterator)+randi(255));
    HOR_IAMGE_1(:,:,Iterator)=reshape(newGray(:,Iterator),NewSize_Image); 
    HOR_IMAGE_2(:,:,Iterator)=reshape(newGray2(:,Iterator),NewSize_Image);
end
if CASE==1 
    IMAGE_1=zeros(size(HOR_IAMGE_1,2),size(HOR_IAMGE_1,1),size(HOR_IAMGE_1,3));
    IMAGE_2=zeros(size(HOR_IAMGE_1,2),size(HOR_IAMGE_1,1),size(HOR_IAMGE_1,3));
    for Iterator=1:size(First_Imported_Image,3)
        IMAGE_1(:,:,Iterator)=HOR_IAMGE_1(:,:,Iterator)';
        IMAGE_2(:,:,Iterator)=HOR_IMAGE_2(:,:,Iterator)';
    end
    HOR_IAMGE_1=IMAGE_1;
    HOR_IMAGE_2=IMAGE_2;
    clear IMAGE_1 IMAGE_2; %delete the variable to save memory
end
HOR_IAMGE_1=uint8(HOR_IAMGE_1);
HOR_IMAGE_2=uint8(HOR_IMAGE_2); 
end
%%                            END