


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
