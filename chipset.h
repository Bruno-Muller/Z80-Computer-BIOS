#ifndef CHIPSET_H
#define	CHIPSET_H

#include "io.h"

__sfr __at (0x00) USART_PORT;
__sfr __at (0x01) TIMER_PORT;
__sfr __at (0x02) SDCARD_PORT;
__sfr __at (0x03) EEPROM_PORT;
__sfr __at (0x04) RESTART_PORT;

volatile __at (0x50) unsigned int IO_PARAM1;
volatile __at (0x52) unsigned long IO_PARAM2;
volatile __at (0x56)  unsigned char IO_RET;

#define TIMER_ENABLE	0x00
#define TIMER_DISABLE 	~TIMER_ENABLE

#define SDCARD_READ		0x00
#define SDCARD_INIT		0x01

#define EEPROM_FLASH_BIOS	0x00
#define EEPROM_SAVE_BIOS	~EEPROM_FLASH_BIOS

#define RESTART	0x45

void chipset_restart();
void chipset_load_sector_into_memory(void* memory, unsigned long sector_address);
void chipset_flash_bios(void* memory);
unsigned char chipset_init_sdcard();


#endif /* CHIPSET_H */