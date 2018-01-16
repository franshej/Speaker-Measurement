function index = FindStartToken(buffer, start)
% FindStartToken(buffer, start)
% Finds the start token (3 consecutive bytes of 0xFF)
% in the array buffer, starting at index start.
% Returns the index of the first value after the found marker, 
% or -1 if none was found

index = strfind(buffer(start:end)', [255, 255, 255]);
if(length(index) <= 0)
   index = -1; 
else
    index = index(1) + start + 2;
end

end