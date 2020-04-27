%% An content aware image resizing based on seam carving

%% This code is written by-
                %Md. Kamrul Hasan, M1 MAIA
                %Md. Fakrul Islam Tushar, M1 MAIA
%%
function varargout = seamCarving_GUI(varargin)
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

function browse_btn_Callback(hObject, eventdata, handles)
global img; 
global mask;
global filename;
global pathname;
[filename, pathname] = ...
    uigetfile({'*.bmp';'*.jpg';'*.png';'*.jpeg'},'Image File Selector'); % By this take the image from the directory 
if filename~=0
    img=imread(fullfile(pathname,filename));
    mask=zeros(size(img,1),size(img,2)); 
    handles.cwidth.String=num2str(size(img,2)); 
    handles.cheight.String=num2str(size(img,1));
    axes(handles.img); 
    imshow(img);
    handles.markup_plus_btn.Enable='on';
    handles.markup_minus_btn.Enable='on';
    handles.save_btn.Enable='off';
    handles.retarget_btn.Enable='on';
end
function markup_plus_btn_Callback(hObject, eventdata, handles)
global img;
global mask; 
h=figure;
imshow(img);
title('Specify a polygonal region of interest (ROI)');
bw=roipoly;
mask=mask+(double(bw)*+100000000000000000);
close(h);
function markup_minus_btn_Callback(hObject, eventdata, handles)
global img; 
global mask;
h=figure;
imshow(img);
title('Specify a polygonal region of interest (ROI)');
bw=roipoly;
mask=mask+(double(bw)*-100000000000000000000);
close(h);
function retarget_btn_Callback(hObject, eventdata, handles)
global img;
global mask;
global out_img;

if length(handles.nwidth.String)<=1 || length(handles.nheight.String)<=1
    msgbox('Please specify valid dimensions of the image','Error','error');
else
    w=round(str2double(handles.nwidth.String)); 
    h=round(str2double(handles.nheight.String));
    if w<=0 || h<=0
        msgbox('Please specify non-zero dimensions of the image','Error','error');
    else
        out_img=ZIP_OF_SEAM_CURVING(img,w,h); %calling the all function that makes a ZIP
        h=figure;
        imshow(out_img);
        title('Results');
        handles.save_btn.Enable='on';
    end
end


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
msgbox('saved!');

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



function axes5_CreateFcn(hObject, eventdata, handles)

I=imread('MAIA_LOGO.jpg');
imshow(I);


function axes6_CreateFcn(hObject, eventdata, handles)

I=imread('logo-condorcet.jpg');
imshow(I);
%%                                       END