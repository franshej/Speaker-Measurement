function data = ConvertFromRawData(raw)
% data = ConvertFromRawData(raw)
% Coverts raw binary data from the uint8 buffer raw to a double array data.
% Data in the raw array are considered to be 24 bit values
% By 2's compliment, the data is converted to the corresponding negative
% values assuming 21 bit values

N = length(raw);

data = double(uint32(raw(1:3:N-2)) + bitshift(uint32(raw(2:3:N-1)),8) + bitshift(uint32(raw(3:3:N)),16));
b = find(data >= 2^20);
data(b)=data(b)-2^21;

end