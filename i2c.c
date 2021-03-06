/* This source file is under General Public License version 3.
*/


#include "i2c.h"

#define WAIT() _delay_us(50)

uint8_t i2c_success;

void i2c_init(void){
    TWSR &= ~((1<<TWPS1)|(1<<TWPS0));
    TWBR = TWBR_VAL;
}

void i2c_send_start(void){
    TWCR = (1<<TWINT)|(1<<TWSTA)|(1<<TWEN);
    while(!(TWCR & (1<<TWINT)));
    //WAIT();
}

void i2c_send_stop(void){
    TWCR = (1<<TWINT)|(1<<TWSTO)|(1<<TWEN);
    while((TWCR & (1<<TWSTO)));
    //WAIT();
}

void i2c_send_addr(uint8_t addr){
    TWDR = addr;
    TWCR = (1<<TWINT) | (1<<TWEN);
    while(!(TWCR & (1<<TWINT)));
    //WAIT();
}
inline void i2c_send_byte(uint8_t data){
    TWDR = data;
    TWCR = (1<<TWINT) | (1<<TWEN);
    while(!(TWCR & (1<<TWINT)));
    //WAIT();
}

inline uint8_t i2c_read_byte(void){
    TWCR = (1<<TWINT)|(1<<TWEN);
    while(!(TWCR & (1<<TWINT)));
    //WAIT();

    return TWDR;
}

void si570_write(uint8_t dev_addr, uint8_t reg_addr, uint8_t data){
    i2c_send_start();
    i2c_send_addr( dev_addr | TW_WRITE );
    i2c_send_byte( reg_addr );
    i2c_send_byte( data ) ;
    i2c_send_stop();
}

uint8_t si570_read(uint8_t dev_addr, uint8_t reg_addr){
    uint8_t val;
    i2c_send_start();
    i2c_send_addr( dev_addr | TW_WRITE );
    i2c_send_byte( reg_addr );

    i2c_send_start();
    i2c_send_addr( dev_addr | TW_READ );
    val = i2c_read_byte();
    i2c_send_stop();

    return val;
}


// msg[0] has i2c addr left shifted 1

void i2cWriteBytes(unsigned char *msg, uint8_t count){
	uint8_t i;
    i2c_send_start();
    for(i=0;i<count;i++)i2c_send_byte( msg[i] );
    i2c_send_stop();
}

// msg[0] has i2c addr left shifted 1

uint8_t i2cReadBytes(unsigned char *msg, uint8_t count){
	uint8_t i;
    i2c_send_start();
	i2c_send_byte( msg[0] );
    for(i=1;i<count;i++)msg[i]=i2c_read_byte();
    i2c_send_stop();
    return 0;

}
