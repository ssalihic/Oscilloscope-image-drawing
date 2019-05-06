

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



