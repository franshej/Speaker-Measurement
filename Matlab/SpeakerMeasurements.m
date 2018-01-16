clear all;
close all;
%Choose the time T of the measurement
T = 7;

%N is number of samples/package for each measurement
%nrOfBytes is the number of bytes per measurement, 3-laser bytes, 2-I/V and
%sound bytes and one error byte
%totBytes is an approximation of the total number of bytes needed for
N=90;
nrOfBytes = 10;
totBytes = T*50000*10;


%Array which saves all raw data
totByteData = zeros(totBytes,1);
t = 0;
cntIndex = 1;

%Opens the py serial script
pyobj = py.Serial.SerialMat('COM12');

%Collect raw data from python-script
disp('Data is being collected')
while t < T
    tic
    a = pyobj.SerialRead(uint32(10000));
    totByteData(cntIndex:cntIndex+10000-1) = uint8(py.array.array('d',py.numpy.nditer(a)));
    cntIndex = cntIndex + 10000; 
    t = t +toc;
end
disp('Data transfer is complete')

totByteData = totByteData(1:cntIndex-1);
pyobj.SerialClose()


%Separating and converting raw data
[bufferLaser, bufferCurrent, bufferVoltage, bufferSound, rawData] = dataProcessing(N, nrOfBytes, totByteData);

%Scaling of the I/V and Laser measurements. Peak values are 1.4 A, 
% 8.5 V, 5 mm. The number of bits are 16 for the I/V measurement and 21 for
% the Laser.
bufferCurrent = bufferCurrent*1.4/2^15;
bufferVoltage = bufferVoltage*8.5/2^15;
bufferLaser = bufferLaser*5/2^20;



%The sampling frequencies of the laser fl = 49.998 kHz and the IV- and
%sound: fIV = 48.8315 KHz
fl = 49998;
fIV = 48831;


tL = 0:1/fl:length(bufferLaser)/fl-1/fl;
tIV = 0:1/fIV:length(bufferCurrent)/fIV-1/fIV;
tS = 0:1/fIV:length(bufferSound)/fIV-1/fIV;


%Plotting the I/V-, Laser- and soundpressure data.
close all

figure
subplot(4,1,1)
plot(tIV,bufferCurrent)
xlabel('time [s]')
ylabel('Current [A]')
title('Current')

subplot(4,1,2)
plot(tIV,bufferVoltage)
xlabel('time [s]')
ylabel('Voltage [V]')
title('Voltage')

subplot(4,1,3)
plot(tL,bufferLaser)
xlabel('time [s]')
ylabel('Membrane displacement [mm]')
title('Laser')

subplot(4,1,4)
plot(tS,bufferSound)
xlabel('time [s]')
ylabel('Sound pressure [dB]')
title('Soundpressure')

