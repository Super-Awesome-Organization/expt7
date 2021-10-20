;
; AssemblerApplication1.asm
;
; Created: 10/19/2021 5:42:37 PM
; Author : raj03
;



.include "m16u4def.inc"
.org 0
rjmp start

start:

	ldi r16, 0xFF
	out DDRD, r16	; Set Port D to output
	ldi r16, 0x80	
	out DDRC, r16	; Set Port C Pin7 to output


	

	ldi r16, 3		; counter for 1 byte of data 
	ldi r28, $DC
	ldi r29, $02	; set Y pointer to $02DC TRUNG happens on address 02DC and 02DD
	

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




