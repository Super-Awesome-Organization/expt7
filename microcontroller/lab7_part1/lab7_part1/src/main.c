/**
 * \file
 *
 * \brief Empty user application template
 *
 */

/**
 * \mainpage User Application template doxygen documentation
 *
 * \par Empty user application template
 *
 * Bare minimum empty user application template
 *
 * \par Content
 *
 * -# Include the ASF header files (through asf.h)
 * -# "Insert system clock initialization code here" comment
 * -# Minimal main function that starts with a call to board_init()
 * -# "Insert application code here" comment
 *
 */

/*
 * Include header files for all drivers that have been imported from
 * Atmel Software Framework (ASF).
 */
/*
 * Support and FAQ: visit <a href="https://www.microchip.com/support/">Microchip Support</a>
 */
#include <asf.h>
#include <stdio.h>
#include <avr/io.h>
#include <util/delay.h>

#define SRAM_START_ADDR 0x100
#define SRAM_END_ADDR 0x05FF
#define OFFSET 0
#define NUM_ADDR 64

#define FPGA_0 PORTD0
#define FPGA_1 PORTD1
#define FPGA_2 PORTD2
#define FPGA_3 PORTD3
#define FPGA_4 PORTD4
#define FPGA_5 PORTD5
#define FPGA_6 PORTD6
#define FPGA_7 PORTD7
#define FPGA_BUS PORTD

void init();
extern unsigned char getSRAM (unsigned short address);

//variables to communicate with SRAM.s
unsigned short address = 0;
unsigned char SRAMVal = 0;
unsigned short SRAMValAddr = &SRAMVal;


int main (void)
{
	init();

	//Loop through all values of specified range
	 for (int i = SRAM_START_ADDR + OFFSET; i<SRAM_START_ADDR + NUM_ADDR + OFFSET; i++){
		//Set clock to rising edge
		PORTC = 0b10000000;
		//Puts value into SRAMVal
		//truncate I to address
		address = (short)i;
		SRAMVal = getSRAM(address);
		FPGA_BUS = SRAMVal;
		// Wait 250 ms
		_delay_ms(250);
		//Set clock to falling edge
		PORTC = 0x0;
		//Wait 250 ms
		_delay_ms(250);
		 
		 
	 }

	 while (1){
		//Ending infinite loop
	}

	
	
}

void init()
{
		//link with getSRAM.s

		board_init();

		//Set Input/Output settings for ports
		DDRC = 0b10000000;
		DDRD = 0xff;
		
		//Set clock to 0
		PORTC = 0x0;

	
}
