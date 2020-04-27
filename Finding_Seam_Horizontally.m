%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA
%%
function HOR= Finding_Seam_Horizontally(Imported_Energy_Vector)

Seam_num=size(Imported_Energy_Vector,1);%Finding the number of row/height
Seam_point_num=size(Imported_Energy_Vector,2);%Finding the number of column/Width
Imported_Energy_Vector=padarray(Imported_Energy_Vector, [1,1],'replicate');% Padding

New_Seam_Creation=zeros(Seam_num,Seam_point_num,3); %Memory allocation

    for Iterator_1=2:Seam_num+1
        previous=0;
        for Iterator_2=2:Seam_point_num+1
           
            if previous==0
                New_Seam_Creation(Iterator_1-1,Iterator_2-1,2)=Iterator_2; 
                New_Seam_Creation(Iterator_1-1,Iterator_2-1,1)=Iterator_1;
                previous=1;
            else
                new_x_Define=New_Seam_Creation(Iterator_1-1,Iterator_2-1-1,2)+1;
                new_y_Define=New_Seam_Creation(Iterator_1-1,Iterator_2-1-1,1); 
                Minimum_Energy=min(min(Imported_Energy_Vector(new_y_Define,new_x_Define),...
                    Imported_Energy_Vector(new_y_Define+1,new_x_Define)),...
                    Imported_Energy_Vector(new_y_Define-1,new_x_Define));
                switch Minimum_Energy
                    case Imported_Energy_Vector(new_y_Define,new_x_Define)
                        New_Seam_Creation(Iterator_1-1,Iterator_2-1,1)=new_y_Define;
                        New_Seam_Creation(Iterator_1-1,Iterator_2-1,2)=new_x_Define; 
                    case  Imported_Energy_Vector(new_y_Define-1,new_x_Define)
                        New_Seam_Creation(Iterator_1-1,Iterator_2-1,1)=new_y_Define-1;
                        New_Seam_Creation(Iterator_1-1,Iterator_2-1,2)=new_x_Define;
                    case Imported_Energy_Vector(new_y_Define+1,new_x_Define)
                        New_Seam_Creation(Iterator_1-1,Iterator_2-1,1)=new_y_Define+1;
                        New_Seam_Creation(Iterator_1-1,Iterator_2-1,2)=new_x_Define;
                end
                New_Seam_Creation(Iterator_1-1,Iterator_2-1,3)=Minimum_Energy;
            end
        end
    end
New_Seam_Creation=New_Seam_Creation-1;
New_Seam_Creation(:,:,3)=New_Seam_Creation(:,:,3)+1;
L=(sum(New_Seam_Creation(:,:,3),2)==min(sum(New_Seam_Creation(:,:,3),2)));
HOR=New_Seam_Creation(L(:),:,:);
if size(HOR,1)>1
    ind=randi(size(HOR,1));%Random Integer Generator
    HOR=HOR(ind,:,:);
end
end
%%                               END