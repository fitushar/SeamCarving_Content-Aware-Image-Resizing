%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA
%%
function varargout = Content_Aware_Resizing_Graphical_User_Interface(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @seamCarving_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @seamCarving_GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function seamCarving_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
global img; 
global mask; 
if exist('ocean.bmp','file')~=0
    img=imread('ocean.bmp'); 
    axes(handles.img); 
    imshow(img);
    mask=zeros(size(img,1),size(img,2));  
    handles.cwidth.String=num2str(size(img,2)); 
    handles.cheight.String=num2str(size(img,1));  
else
    img=[];
    handles.retarget_btn.Enable='off'; 
    handles.markup_plus_btn.Enable='off';
    handles.markup_minus_btn.Enable='off'; 
end
guidata(hObject, handles);

function varargout = seamCarving_GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

%function for browing for the input/target image for Seam Carving
function browse_btn_Callback(hObject, eventdata, handles)
global img; 
global mask; 
global filename;
global pathname;
[filename, pathname] = ...
    uigetfile({'*.bmp';'*.jpg';'*.png';'*.jpeg'},'Image File Selector');
if filename~=0
    img=imread(fullfile(pathname,filename)); 
    mask=zeros(size(img,1),size(img,2)); 
    handles.cwidth.String=num2str(size(img,2)); %give the weight of the target image
    handles.cheight.String=num2str(size(img,1));%give thw hwight of the target image
    axes(handles.img); 
    imshow(img);
    handles.markup_plus_btn.Enable='on';
    handles.markup_minus_btn.Enable='on';
    handles.save_btn.Enable='off';
    handles.retarget_btn.Enable='on';
end

%Function for Adding Positive energy to the ROI
function markup_plus_btn_Callback(hObject, eventdata, handles)
global img; 
global mask; 
h=figure;
imshow(img);
title('Specify a polygonal region of interest (ROI)');
bw=roipoly; 
mask=mask+(double(bw)*+100000000000000000); 
close(h);

%funtion for Adding Negative Energy to the ROI
function markup_minus_btn_Callback(hObject, eventdata, handles)
global img; 
global mask; 
h=figure;
imshow(img);
title('Specify a polygonal region of interest (ROI)');
bw=roipoly; 
mask=mask+(double(bw)*-100000000000000000000); 
close(h);

%Function for Specifying the Desired Image Dimention (Height and Weight)
function retarget_btn_Callback(hObject, eventdata, handles)
global img;
global mask;
global out_img;

%Checking given dimention is valid or not.
if length(handles.nwidth.String)<=1 || length(handles.nheight.String)<=1
    msgbox('Please specify valid dimensions of the image','Error','error');
else
    w=round(str2double(handles.nwidth.String)); 
    h=round(str2double(handles.nheight.String)); 
    if w<=0 || h<=0
        msgbox('Please specify non-zero dimensions of the image','Error','error');
    else
        out_img=ZIP_OF_SEAM_CURVING(img,w,h); %Calling the Seam Carving function.
        h=figure;
        imshow(out_img); %Shows the Desired Image After Executing Seam Carving
        title('Results');
        handles.save_btn.Enable='on';
    end
end

%Function for saving the output image
function save_btn_Callback(hObject, eventdata, handles)
global out_img;
global filename;
global pathname;
if length(filename)<=1 
    imwrite(out_img,'Ocean_result.bmp'); 
else
    imwrite(out_img,fullfile(pathname,strcat(filename(1:end-4),'_result',...
        filename(end-3:end))));    
end
msgbox('saved!'); %confirming the saving.

function nwidth_Callback(hObject, eventdata, handles)

function nwidth_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nheight_Callback(hObject, eventdata, handles)

function nheight_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cwidth_Callback(hObject, eventdata, handles)

function cwidth_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cheight_Callback(hObject, eventdata, handles)

function cheight_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function figure1_CreateFcn(hObject, eventdata, handles)

%Shoing the official logo of Center University Condorcet.
function axes7_CreateFcn(hObject, eventdata, handles)
I=imread('logo-condorcet.jpg');
imshow(I);
%Shoing the Official logo of MAIA program.
function axes8_CreateFcn(hObject, eventdata, handles)
I=imread('MAIA_LOGO.jpg');
imshow(I);
%%                                 END
