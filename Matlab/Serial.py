

import serial
import matlab
import time
from numpy import array

class SerialMat:
    stm32 = serial.Serial()

    def __init__(self, port):
        self.stm32 = serial.Serial(port, baudrate=115200, timeout=0.1)

    def  SerialRead(self, len):
        dataInt = [0]*len
        if (self.stm32.isOpen()):
            data = self.stm32.read(len)
            for i in range(len):
                dataInt[i] = int(data[i])
            pelle = array(dataInt)
            return pelle

    def  SerialClose(self):
        self.stm32.close()

#a = SerialMat('COM12')
#z = a.SerialRead(1000)
#a.SerialClose()
#print(z)

#SerialInt('COM12')
#a = SerialRead(50000)
#SerialClose()
#print(a)
