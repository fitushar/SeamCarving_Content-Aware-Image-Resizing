%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA
%%
function VAR= Finding_Seam_Vertically(Imported_Energy_Vector)

seam_number_vertically=size(Imported_Energy_Vector,2); %Finding number of column that is height
seam_point_number_Horizontally=size(Imported_Energy_Vector,1); %Finding number of row that is Width

Imported_Energy_Vector=padarray(Imported_Energy_Vector, [1,1],'replicate'); %Padding
New_seams_Creation=zeros(seam_number_vertically,seam_point_number_Horizontally,3); %Memory allocations
  for Iterator_1=2:seam_number_vertically+1
        Initializations=0;
        for Iterator_2=2:seam_point_number_Horizontally+1
            if Initializations==0
                New_seams_Creation(Iterator_1-1,Iterator_2-1,2)=Iterator_1; 
                New_seams_Creation(Iterator_1-1,Iterator_2-1,1)=Iterator_2; 
                Initializations=1;
            else
                new_x=New_seams_Creation(Iterator_1-1,Iterator_2-1-1,2);
                new_y=New_seams_Creation(Iterator_1-1,Iterator_2-1-1,1)+1;
                min_g=min(min(Imported_Energy_Vector(new_y,new_x),...
                    Imported_Energy_Vector(new_y,new_x+1)),...
                    Imported_Energy_Vector(new_y,new_x-1));
                switch min_g
                    case Imported_Energy_Vector(new_y,new_x)
                        New_seams_Creation(Iterator_1-1,Iterator_2-1,1)=new_y;
                        New_seams_Creation(Iterator_1-1,Iterator_2-1,2)=new_x;
                    case  Imported_Energy_Vector(new_y,new_x-1)
                        New_seams_Creation(Iterator_1-1,Iterator_2-1,1)=new_y;
                        New_seams_Creation(Iterator_1-1,Iterator_2-1,2)=new_x-1;
                    case Imported_Energy_Vector(new_y,new_x+1)
                        New_seams_Creation(Iterator_1-1,Iterator_2-1,1)=new_y;
                        New_seams_Creation(Iterator_1-1,Iterator_2-1,2)=new_x+1;
                end
                New_seams_Creation(Iterator_1-1,Iterator_2-1,3)=min_g;
            end
        end
  end

New_seams_Creation=New_seams_Creation-1;
New_seams_Creation(:,:,3)=New_seams_Creation(:,:,3)+1;
L=(sum(New_seams_Creation(:,:,3),2)==min(sum(New_seams_Creation(:,:,3),2)));
VAR=New_seams_Creation(L(:),:,:);
if size(VAR,1)>1 % Number of row
    ind=randi(size(VAR,1));
    VAR=VAR(ind,:,:);
end
end
%%                                 END