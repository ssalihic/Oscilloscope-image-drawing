poruka='';
for i=1:10
    %for j=1:80
        poruka=strcat(poruka,'0');
    %end
end

s=serial('COM8', 'BaudRate', 9600, 'Terminator', '');
fopen(s);
% 
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');
%     fprintf(s, '1');

for i=1:size(poruka, 2)
    fprintf(s, poruka(i));
    i
    t = tic();
    while toc(t) < 0.001
    end
end
fclose(s);
delete(s);
clear s;
