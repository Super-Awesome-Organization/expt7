.extern main

.global getSRAM

.extern address
.extern SRAMValAddr

getSRAM:
	
LDI YH, hi8(address)
LDI YL, lo8(address)
LDI ZH, hi8(SRAMValAddr)
LDI ZL, lo8(SRAMValAddr)

LD r18, Y
ST Z, r18


ret 


