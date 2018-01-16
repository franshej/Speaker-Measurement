# Speaker-Measurement
Measurement setup for membrane dissplacement, sound pressure, voltage and current.
by Frans Rosencrantz and Mattias Dahlstedt

Setting up:
1. Connect usb cable from computer to power the STM32. (This could be replaced with an external power source). 
2. Connect the USB_OTG cable from STM32 to the computer. Check which COM-port in device manager. (Install drivers if not shown)
3. Replace the COM-port in pyobj = py.Serial.SerialMat('COM12'); in SpeakerMeasurements.m with your COM-port.
4. Connect the USB from laser to have common ground between STM32 and Laser.
5. Open LK-Navigator and if needed zero the laser.
6. Connect the TAS2552 via USB and open the associated application CodecControl. Press the yellow box "DIGITAL IO and ..." and set the input mode to analog.
7. Run SpeakerMeasurements.m
