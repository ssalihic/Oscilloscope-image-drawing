
function comPort_Callback(hObject, eventdata, handles)
% hObject    handle to comPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of comPort as text
%        str2double(get(hObject,'String')) returns contents of comPort as a double

comPort = get(hObject,'String');
handles.comPort=comPort;
