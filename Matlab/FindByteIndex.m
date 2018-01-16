function [indexCurrent, indexVoltage, indexSound] = FindByteIndex(ErrorArray, N, nrOfBytes)
%Creates three arrays with the indices of the I/V- and sound measurements
%that is NOT a doublet of the previous measurement
indexCurrent = [];
indexVoltage = [];
indexSound = [];

for i=1:N
    if ErrorArray(i) == 3
        %All values are saved
        indexCurrent = [indexCurrent (i-1)*nrOfBytes+4];
        indexCurrent = [indexCurrent (i-1)*nrOfBytes+5];
        indexVoltage = [indexVoltage (i-1)*nrOfBytes+6];
        indexVoltage = [indexVoltage (i-1)*nrOfBytes+7];
        indexSound = [indexSound (i-1)*nrOfBytes+8];
        indexSound = [indexSound (i-1)*nrOfBytes+9];
    elseif ErrorArray(i) == 2
        %The sound measurement is discarded
        indexCurrent = [indexCurrent (i-1)*nrOfBytes+4];
        indexCurrent = [indexCurrent (i-1)*nrOfBytes+5];
        indexVoltage = [indexVoltage (i-1)*nrOfBytes+6];
        indexVoltage = [indexVoltage (i-1)*nrOfBytes+7];
    elseif ErrorArray(i) == 1
        %The I/V measurements are discarded
        indexSound = [indexSound (i-1)*nrOfBytes+8];
        indexSound = [indexSound (i-1)*nrOfBytes+9];
    end   
end