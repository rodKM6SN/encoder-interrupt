/* This source file is under General Public License version 3.
*/


// written for arduino mega 328p 16 MHz
/* rev

01 printf and backlight working

00 writes to display, but backlight is off


*/

//#define PRINTF1602

#ifndef F_CPU
#define F_CPU 16000000UL
#endif

#include <stdlib.h>
#include <stdio.h>
	
#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include <stdbool.h>

#include "i2cBang1602.h"
/* 

in 4-bit mode, data is transfered MS nibble first, LS nibble last

during init iwth 8574A and 1602, nibble transfers are used until
4-bit mode is established

*/

uint8_t addr1602 = 0x27;	// For 8574A I/O port expander

/*
8574A bits for 1602 display, based on ebay i2c adapter

0	RS
1	R/W
2    E
3	???? COULD IT BE BACKLIGHT CONTROLL?
4	D4
5	D5
6	D6
7	D7

*/
// control bits for i2c 8574A  1602, based on ebay i2c adapter
#define L_DATA 1   // known as RS bit, 0=cmd, 1=data xfer
#define L_READ 2	   // 1=read from 1602, 0=write to 1602
#define L_E  4		// pulse high to commit data to 1602
#define L_BKLIGHT 8
#define BUFSZ 50
uint8_t messageBuf[BUFSZ];


#define LED PB5


#define DDR_LED   	DDRB
#define PORT_LED DDR_LED


#define FASTB 1
#define FASTR 1

void show_error(void){
	lcd_goto(0);
//	printf("%s",TWImsgPtr);

}





/* put a command nibble (4 bit command) to the LCD controller
   command is in the upper 4 bits of char */

void lcdPutCmd1(unsigned char c)
{
				messageBuf[0] = (addr1602<<1) ;
				messageBuf[1] = (c&0xf0);       // 
				messageBuf[2] = ((c&0xf0)|L_E );   // pulse the E bit.
				messageBuf[3] = (c&0xf0);       // 
				i2cWriteBytes(messageBuf,4);
}


/* put a command byte to the LCD controller
   command is the full 8 bits of char */

void lcdPutCmd2(unsigned char c)
{
				messageBuf[0] = (addr1602<<1);// | (FALSE<<TWI_READ_BIT));
				messageBuf[1] = (c&0xf0)|L_BKLIGHT;       // The first nibble.
				messageBuf[2] = ((c&0xf0)|L_E)|L_BKLIGHT ;   // pulse the E bit.
				messageBuf[3] = (c&0xf0)|L_BKLIGHT;       // 

				messageBuf[4] = ((c<<4)&0xf0)|L_BKLIGHT;       // The second nibble
				messageBuf[5] = (((c<<4)&0xf0)|L_E) |L_BKLIGHT;   // pulse the E bit.
				messageBuf[6] = (((c<<4)&0xf0)|L_BKLIGHT);       // 
				i2cWriteBytes(messageBuf,7);

}




void lcdPutData(unsigned char c)
{
				messageBuf[0] = (addr1602<<1);// | (FALSE<<TWI_READ_BIT);
				messageBuf[1] = (c&0xf0)|L_DATA|L_BKLIGHT;       // The second byte is used for the data.
				messageBuf[2] = ((c&0xf0)|L_DATA|L_E|L_BKLIGHT) ;   // pulse the E bit.
				messageBuf[3] = (c&0xf0)|L_DATA|L_BKLIGHT;       // 

				messageBuf[4] = ((c<<4)&0xf0)|L_DATA|L_BKLIGHT;       // The second byte is used for the data.
				messageBuf[5] = (((c<<4)&0xf0)|L_DATA|L_E)|L_BKLIGHT ;   // pulse the E bit.
				messageBuf[6] = (((c<<4)&0xf0)|L_DATA)|L_BKLIGHT;       // 
				i2cWriteBytes(messageBuf,7);


}


   // Device specific output (needed for gcc-avr stdio)
int pf_putchar(char c ,FILE *stream) {
	if((c=='\n')  || (c=='\r')) return 0;
	lcdPutData(c);
      return 0;
}

// done in the include file static FILE lcdStdout = FDEV_SETUP_STREAM(pf_putchar, NULL, _FDEV_SETUP_WRITE);


/*
 *      Clear and home the LCD
 */

void
lcd_clear(void)
{

        lcdPutCmd2(0x1);
        _delay_ms(2);
}

/* write a string of chars to the LCD */

void
lcd_puts(const char * s)
{

        while(*s) lcdPutData(*s++);
}

/* write one character to the LCD */

void
lcd_putch(unsigned char c)
{

        lcdPutData(c);
}


/*
 * Go to the specified position
 */

void
lcd_goto(unsigned char pos)
{

        lcdPutCmd2(0x80 + pos);
}
        
/* initialise the LCD - put into 4 bit mode */


void
lcd_init(void)
{
 


        _delay_ms(40);// power on delay
			_delay_ms(50);
  
        lcdPutCmd1(0x30);   // init!        
        _delay_ms(5);

        lcdPutCmd1(0x30);   // init!        
        _delay_ms(5);

        lcdPutCmd1(0x30);   // init!        
        _delay_ms(5);

        lcdPutCmd1(0x20);   // set 4 bit mode        
        
        lcdPutCmd2(0x28);// 4 bit mode, 1/16 duty, 5x8 font, 2lines
        lcdPutCmd2(0x0C);// display on
        lcdPutCmd2(0x06);// entry mode advance cursor
        lcdPutCmd2(0x01);// clear display and reset cursor
        _delay_ms(5);



}



//#define LCD_TESTING

#ifdef LCD_TESTING

void main()
{
    unsigned char i,c=0x30;
  
    lcd_init();
    lcd_clear();
    stdout=&lcdStdout;
    c = 'A';
   
    
    for(i=0;i<16;i++,c++){
    lcd_putch(c);
    }; 
   
lcd_goto(41); 
      c = '0';
    for(i=0;i<16;i++,c++){
    lcd_putch(c);
    }; 
 
    for(i=0;i<2;);// hang looping forever
}

#endif
