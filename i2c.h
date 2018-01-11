/* This source file is under General Public License version 3.
*/

#ifndef I2C_H_
#define I2C_H_

#include <avr/io.h>
#include <util/twi.h>
#include <util/delay.h>

//#define TWBR_VAL 16
//#define TWBR_VAL 32
#define TWBR_VAL 0x48

extern void i2c_init(void);

extern void i2c_send_start(void);

extern void i2c_send_stop(void);

extern void i2c_send_addr(uint8_t addr);

extern void i2c_send_byte(uint8_t data);

extern uint8_t i2c_read_byte(void);

extern void i2cWriteBytes(unsigned char *msg, uint8_t count);
extern uint8_t i2cReadBytes(unsigned char *msg, uint8_t count);

extern void si570_write(uint8_t dev_addr, uint8_t reg_addr, uint8_t data);
extern uint8_t si570_read(uint8_t dev_addr, uint8_t reg_addr);

#endif
