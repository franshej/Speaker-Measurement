function data = ConvertFromRawData2bytes(raw)
% data = ConvertFromRawData(raw)
% Coverts raw binary data from the uint8 buffer raw to a double array data.
% Data in the raw array are considered to be 16 bit values
% By 2's compliment, the data is converted to the corresponding negative
% values assuming 16 bit values

N = length(raw);

data = double(uint32(raw(1:2:N-1)) + bitshift(uint32(raw(2:2:N)),8));

b = find(data >= 2^15);
data(b)=data(b)-2^16;
end