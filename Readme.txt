
Dissplacement setup for miniuture speakers by Frans Rosencrantz and Mattias Dahlstedt:

Setting up:
1. Connect usb cable from computer to power the STM32. (This could be replaced with an external power source). 
2. Connect the USB_OTG cable from STM32 to the computer. Check which COM-port in device manager. (Install drivers if not shown)
3. Replace the COM-port in pyobj = py.Serial.SerialMat('COM12'); in SpeakerMeasurements.m with your COM-port.
4. Connect the USB from laser to have common ground between STM32 and Laser.
5. Open LK-Navigator and if needed zero the laser.
6. Connect the TAS2552 via USB and open the associated application CodecControl. Press the yellow box "DIGITAL IO and ..." and set the input mode to analog.
7. Run SpeakerMeasurements.m

Power supplies:
STM32 			--> USB or 5V
PCM1861 		--> 5V from STM32
TAS2552 		--> 3.7V for analog part and 5V from USB.
Laser controller	--> 24V

Pin configuruation:
Pin from LK-G3001P  ||	Pin on STM32
PIN 1		-->	PC1
PIN 2		-->	PC0
PIN 3		-->	PE5
PIN 4		-->	PC2
PIN 5		-->	PA1
PIN 6		-->	PA0
PIN 7		-->	PA3
PIN 8		-->	PA2
PIN 9		-->	PA5
PIN 10		-->	PD0
PIN 11		-->	PA7
PIN 12		-->	PA6
PIN 13		-->	PC5
PIN 14		-->	PC4
PIN 15		-->	PB1
PIN 16		-->	PB0
PIN 17		-->	PB2
PIN 18		-->	PE7
PIN 19		-->	PE8
PIN 20		-->	PE9
PIN 21		-->	PE10
PIN 22		-->	PE11
PIN 23		-->	PE12
PIN 24		-->	PE13
PIN 25		-->	PE14
PIN 26		-->	PE15
PIN 27		-->	PA8
PIN 28		-->	PB11
PIN 29		-->	PD2
PIN 30		-->	PB13
PIN 31		-->	PB14
PIN 32		-->	PB15
PIN 33		-->	PD8
PIN 34		-->	PD9
PIN 35		-->	PD10
PIN 36		-->	PD11
PIN 37		-->	PD12
PIN 38		-->	PD13
PIN 39		-->	PD14
PIN 40		-->	PD15

Pin from TAS2552 (IV)  ||	Pin on STM32
DOUT		-->		PC3
BCLK		-->		PB10
MCLK		-->		PC6
LRCLK		-->		PB12

Pin from PCM1861 (IV)  ||	Pin on STM32
DOUT		-->		PC12
BCLK		-->		Pc10
MCLK		-->		PC7
LRCLK		-->		PA4
5+ 		-->		5
GND		-->		GND

NOTICE
PA9, PA11, PA12 is used by the USB_OTG.



	