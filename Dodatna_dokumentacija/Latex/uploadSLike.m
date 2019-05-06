
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
