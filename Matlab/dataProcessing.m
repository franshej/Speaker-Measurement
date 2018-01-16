function [bufferLaser, bufferCurrent, bufferVoltage, bufferSound, rawData] = dataProcessing(N, nrOfBytes, rawData)

%Index arrays used to find the bytes corresponding to each measurement 
bufferLaser = zeros(ceil(length(rawData)/10),1);
bufferVoltage = zeros(ceil(length(rawData)/10),1);
bufferCurrent = zeros(ceil(length(rawData)/10),1);
bufferSound = zeros(ceil(length(rawData)/10),1);

indexLaser = zeros(3*N,1);
indexError = zeros(N,1);

%Creating index-arrays for Laser- and error data.
%The laser index array has values for N = 90, [1 2 3 11 12 13 ... 891 892 893]
%The error index array has values for N = 90, [10 20 30 ... 880 890 900]
for i=1:N
    indexLaser(3*(i-1)+1) = (i-1)*nrOfBytes+1;
    indexLaser(3*(i-1)+2) = (i-1)*nrOfBytes+2;
    indexLaser(3*(i-1)+3) = (i-1)*nrOfBytes+3;
    indexError(i) = i*nrOfBytes;
end

%Starting variables used to synch, separate and convert raw data
hasSynch = 0;
numTimesoutOfSynch = 0;
writeIndexLaser = 1;
writeIndexIV = 1;
writeIndexSound = 1;
readIndex = 1;

%Separates and converts raw data, while the raw-data buffer is bigger than
%one package.
while(length(rawData) - readIndex > N*nrOfBytes+3)
    if(hasSynch == 1)
        % we are 'synched', meaning we have a valid location of the
        % previous marker. the next marker is expected to be 900 bytes
        % further in the input
        if(all(rawData(readIndex + N*nrOfBytes: readIndex + N*nrOfBytes+2) == 255) )
            %Stores one package of raw data;
            tempBuff = rawData(readIndex:readIndex+nrOfBytes*N-1);
            
            %Collects the error-bytes from one package in one array
            ErrorArray = tempBuff(indexError);
            
            %From the error array, finds the indices for I/V and Sound that
            %are in synch.
            [indexCurrent, indexVoltage, indexSound] = FindByteIndex(ErrorArray,N, nrOfBytes);
            lenCurrent = ceil(length(indexCurrent)/2);
            lenSound = ceil(length(indexSound)/2);
            
            %Converts byte data to an signed integer
            bufferLaser(writeIndexLaser : writeIndexLaser + N-1) = ConvertFromRawData(tempBuff(indexLaser));
            bufferCurrent(writeIndexIV : writeIndexIV + lenCurrent-1) = ConvertFromRawData2bytes(tempBuff(indexCurrent));
            bufferVoltage(writeIndexIV : writeIndexIV + lenCurrent-1) = ConvertFromRawData2bytes(tempBuff(indexVoltage));
            bufferSound(writeIndexSound : writeIndexSound + lenSound-1) = ConvertFromRawData2bytes(tempBuff(indexSound));
            
            % marker was found at the expected spot, convert this frame of data
            %move the indexes up one frame (100 values, numMes*N*numBytes+3 bytes including the marker)
            readIndex = readIndex + nrOfBytes*N+3;
            writeIndexLaser = writeIndexLaser + N;
            writeIndexIV = writeIndexIV + lenCurrent;
            writeIndexSound = writeIndexSound + lenSound;
        else
            hasSynch = 0;
        end
    else
        % not in synch, look for the marker
        ind = FindStartToken(rawData, readIndex);
        numTimesoutOfSynch = numTimesoutOfSynch + 1;
        if(ind >= 0)
            % remove everything before the marher and set read index to 1
            hasSynch = 1;
            rawData = rawData(ind:end);
            readIndex = 1;
        else
            rawData = uint8([]);
        end
        
    end
end

bufferCurrent = bufferCurrent(1:writeIndexIV-1);
bufferVoltage = bufferVoltage(1:writeIndexIV-1);
bufferLaser = bufferLaser(1:writeIndexLaser-1);
bufferSound = bufferSound(1:writeIndexSound-1);
rawData = rawData(readIndex:end);
