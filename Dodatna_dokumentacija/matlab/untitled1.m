function varargout = untitled1(varargin)
% UNTITLED1 MATLAB code for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 01-Jan-2019 18:57:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled1_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled1_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)

% Choose default command line output for untitled1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    [filename,user_cancelled] = imgetfile;
    orig = imread(filename);
    imshow(orig, 'Parent', handles.axes1);
    handles.orig=orig;
    set(handles.poruka,'ForegroundColor','Green');
    set(handles.poruka,'String','Image loaded. Process image.');
catch e
    set(handles.poruka,'ForegroundColor','Red');
    set(handles.poruka,'String','No image loaded!');
end
guidata(hObject, handles);




% --- Executes on button press in type.
function type_Callback(hObject, eventdata, handles)
% hObject    handle to type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of type
if get(hObject, 'Value')==0
    type='global';
else
    type='adaptive';
end
handles.type=type;
guidata(hObject, handles);

% --- Executes on button press in processImage.
function processImage_Callback(hObject, eventdata, handles)
% hObject    handle to processImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    orig=handles.orig;
    type=handles.type;
    if ~strcmp(type, 'adaptive') && ~strcmp(type, 'global')
        type='global';
    end
    processed = imresize(imbinarize(rgb2gray(orig), type), [40 40]);
    imshow(processed, 'Parent', handles.axes2);
    handles.processed=processed;
    handles.type=type;
    set(handles.poruka,'ForegroundColor','Green');
    set(handles.poruka,'String','Image processed.');
catch e
    set(handles.poruka,'ForegroundColor','Red');
    set(handles.poruka,'String','Load image first!');
end
guidata(hObject, handles);


function comPort_Callback(hObject, eventdata, handles)
% hObject    handle to comPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of comPort as text
%        str2double(get(hObject,'String')) returns contents of comPort as a double

comPort = get(hObject,'String');
handles.comPort=comPort;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function comPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to comPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sendImage.
function sendImage_Callback(hObject, eventdata, handles)
% hObject    handle to sendImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    slika = handles.processed;
    bajti = '';
    % generisanje bajti 1-bijelo 0-crno
	for i=1:40
        for j=1:40
            bajti = strcat(bajti,num2str(slika(i,j)));
        end
    end
    % kraj generisanja
    'prije otvaranje'
    try
        fclose(s);
    catch e
    end
    try
        delete(s);
    catch e
    end
    s = serial(handles.comPort, 'BaudRate', 9600, 'Terminator', '')
    fopen(s);
    'poslije opena'
    s
    for i=1:size(bajti,2)
        fprintf(s, bajti(i));
%          t = tic();
 %         while toc(t) < 0.00001
%         end
    end
    fclose(s);
    'poslije closea'
    s
    delete(s);
    s
    clear s;
    set(handles.poruka,'ForegroundColor','Green');
    set(handles.poruka,'String','Image sent!');
catch e
    e
    set(handles.poruka,'ForegroundColor','Red');
    set(handles.poruka,'String','Sending not successful!');
    delete(s);
end
