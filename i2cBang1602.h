/* This source file is under General Public License version 3.
*/

#define USE_I2C1602 1

#ifdef USE_I2C1602
#define PRINTF1602
#endif

#include "i2c.h"
/*
 write a byte to the LCD in 4 bit mode */

extern void lcdPutData(unsigned char);

/* write a byte to the LCD in 4 bit mode */

extern void lcdPutCmd1(unsigned char);


extern void lcdPutCmd2(unsigned char);

/* Clear and home the LCD */

extern void lcd_clear(void);

/* write a string of characters to the LCD */

extern void lcd_puts(const char * s);

/* Go to the specified position */

extern void lcd_goto(unsigned char pos);
        
/* intialize the LCD - call before anything else */

extern void lcd_init(void);

extern int pf_putchar(char c ,FILE *stream);

static FILE lcdStdout = FDEV_SETUP_STREAM(pf_putchar, NULL, _FDEV_SETUP_WRITE);


/*      Set the cursor position */

#define lcd_cursor(x)   lcd_write(((x)&0x7F)|0x80)
#define         LINE1                   0x00    /* position of line1 */
#define         LINE2                   0x40    /* position of line2 */

