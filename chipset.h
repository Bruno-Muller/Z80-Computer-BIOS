#ifndef CHIPSET_H
#define	CHIPSET_H

#include "io.h"

typedef struct {
	unsigned char sec;
	unsigned char min;
	unsigned char hours;
	unsigned char day;
	unsigned char date;
	unsigned char month;
	unsigned char year;
} Clock;

__sfr __at (0x00) USART_PORT;
__sfr __at (0x01) TIMER_PORT;
__sfr __at (0x02) SDCARD_PORT;
__sfr __at (0x03) EEPROM_PORT;
__sfr __at (0x04) RESTART_PORT;
__sfr __at (0x05) KEYBOARD_PORT;
__sfr __at (0x06) VGA_PORT;
__sfr __at (0x07) CLOCK_PORT;

volatile __at (0x50) unsigned int IO_PARAM1;
volatile __at (0x52) unsigned long IO_PARAM2;
volatile __at (0x56) unsigned char IO_RET;
volatile __at (0x57) Clock CLOCK;

#define TIMER_ENABLE	0x00
#define TIMER_DISABLE 	0x01

#define SDCARD_READ		0x00
#define SDCARD_INIT		0x01

#define EEPROM_FLASH_BIOS	0x00
#define EEPROM_SAVE_BIOS	~EEPROM_FLASH_BIOS

#define RESTART	0x45

#define CLOCK_GET_DATETIME	0x00
#define CLOCK_SET_DATETIME	0x01
#define CLOCK_INT_ENABLE   	0x02
#define CLOCK_INT_DISABLE  	0x03

void chipset_restart();
void chipset_load_sector_into_memory(void* memory, unsigned long sector_address);
void chipset_flash_bios(void* memory);
unsigned char chipset_init_sdcard();
void chipset_get_datetime();
void chipset_set_datetime();


#endif /* CHIPSET_H */