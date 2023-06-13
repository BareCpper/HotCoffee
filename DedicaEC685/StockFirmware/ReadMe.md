# Dissasembly

Use: gputils https://gputils.sourceforge.io/
Commandline: `gpdasm -p p16f1938 -csno DedicaEC685_PIC16F1938_StockFirmware.hex > DedicaEC685_PIC16F1938_StockFirmware.S`

# Code PSECT Linker Region address

-Wl,-ACODE=0h-3fffh


# Development Logs:
2023-06-14
	Resolve issue by realising linker option for PSECT needed `-Wl,-ACODE=0h-3fffh
	Used gputils for dissasembly with function labels
	Many fixes to dissasembly, only significant changes are hacks possibly due to entry not being @ 0x0:
	- ljmp used in place of goto
	- fcall in place of call
	Entry is currently at 0xce0 when flashing on target... hmmm


2023-06-13 
	Raised STackoverflow to source help to assist in round-trip build of DisAssy output
	https://stackoverflow.com/questions/76468338/mplab-x-pic-building-the-dissembled-output-and-flashing-to-the-same-target-roun
	
2023-06-05
	Extracted Delonghi Dedica EC685 stock firmware from target PCB with PIC16F1938 MCU
	Taken lots of referenc eimages of the device for later schematic extraction.