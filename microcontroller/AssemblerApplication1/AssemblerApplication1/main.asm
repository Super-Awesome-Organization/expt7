;
; Part1micro.asm
; Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
; Experiement 7 Part 1
; 10/24/21

; Description:
;	This asm file reads the SRAM power up data cells and ouputs 64 bytes 
;	of SRAM data to the FPGA on PORT D to create a PUF signature. 
	;On PORTC Pin 7 a clock is generated
;	for the FPGA. The starting address for the SRAM data in this file $2000
;



.include "m16u4def.inc"
.org 0
rjmp start

start:

	ldi r16, 0xFF
	out DDRD, r16	; Set Port D to output
	ldi r16, 0x80	
	out DDRC, r16	; Set Port C Pin7 to output

	;lds r17, $239
	;rcall delay
	;out PORTD, r17
	;rcall delay
	;rcall clk
	
		;02DC for trng with counter of 3

	ldi r16, 81		; counter for 64 bytes
	ldi r28, $00
	ldi r29, $02	; set Y pointer to $0100 02DC for trung with counter 0f 3
	

	Loop: 
		ld r17,Y+		; load data from SRAM and increment pointer
		nop
		out PORTD, r17	; send SRAM data to FPGA
		rcall clk		; Toggle pin C7
		dec r16			
		cpi r16,1		; checks to see if counter is 1
		brne Loop		; If not loops
		rjmp Done		; Jumps to done loop
		

		
	
	clk:
		sbi PortC, 7	; Set bit 7 high
		rcall delay
		cbi PortC, 7	; Set bit 7 low
		rcall delay
		ret	 

	delay:
		ldi r19, 0x00	
	inc_delay:
		inc r19			; Increment counter
		sbrs r19, 7		; If bit 7 is set skip instruction
		rjmp inc_delay	; loops to inc_delay
		ret

	Done:
		rjmp Done




