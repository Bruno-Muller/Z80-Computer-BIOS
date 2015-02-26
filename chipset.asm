;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Mon Feb 23 21:52:08 2015
;--------------------------------------------------------
	.module chipset
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _CLOCK
	.globl _IO_RET
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _chipset_flash_bios
	.globl _chipset_restart
	.globl _chipset_load_sector_into_memory
	.globl _chipset_init_sdcard
	.globl _chipset_get_datetime
	.globl _chipset_set_datetime
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_USART_PORT	=	0x0000
_TIMER_PORT	=	0x0001
_SDCARD_PORT	=	0x0002
_EEPROM_PORT	=	0x0003
_RESTART_PORT	=	0x0004
_KEYBOARD_PORT	=	0x0005
_VGA_PORT	=	0x0006
_CLOCK_PORT	=	0x0007
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_IO_PARAM1	=	0x0050
_IO_PARAM2	=	0x0052
_IO_RET	=	0x0056
_CLOCK	=	0x0057
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;chipset.c:3: void chipset_flash_bios(void* memory) {
;	---------------------------------
; Function chipset_flash_bios
; ---------------------------------
_chipset_flash_bios_start::
_chipset_flash_bios:
;chipset.c:4: IO_PARAM1 = (unsigned int) memory;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 1),a
;chipset.c:5: EEPROM_PORT = EEPROM_FLASH_BIOS;
	ld	a,#0x00
	out	(_EEPROM_PORT),a
	ret
_chipset_flash_bios_end::
;chipset.c:8: void chipset_restart() {
;	---------------------------------
; Function chipset_restart
; ---------------------------------
_chipset_restart_start::
_chipset_restart:
;chipset.c:9: RESTART_PORT = RESTART;
	ld	a,#0x45
	out	(_RESTART_PORT),a
	ret
_chipset_restart_end::
;chipset.c:12: void chipset_load_sector_into_memory(void* memory, unsigned long sector_address) {
;	---------------------------------
; Function chipset_load_sector_into_memory
; ---------------------------------
_chipset_load_sector_into_memory_start::
_chipset_load_sector_into_memory:
;chipset.c:13: IO_PARAM1 = (unsigned int) memory;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 1),a
;chipset.c:14: IO_PARAM2 = sector_address;
	ld	de, #_IO_PARAM2
	ld	hl, #4
	add	hl, sp
	ld	bc, #4
	ldir
;chipset.c:15: SDCARD_PORT = SDCARD_READ;
	ld	a,#0x00
	out	(_SDCARD_PORT),a
	ret
_chipset_load_sector_into_memory_end::
;chipset.c:18: unsigned char chipset_init_sdcard() {
;	---------------------------------
; Function chipset_init_sdcard
; ---------------------------------
_chipset_init_sdcard_start::
_chipset_init_sdcard:
;chipset.c:19: SDCARD_PORT = SDCARD_INIT;
	ld	a,#0x01
	out	(_SDCARD_PORT),a
;chipset.c:20: return IO_RET;
	ld	iy,#_IO_RET
	ld	l,0 (iy)
	ret
_chipset_init_sdcard_end::
;chipset.c:23: void chipset_get_datetime() {
;	---------------------------------
; Function chipset_get_datetime
; ---------------------------------
_chipset_get_datetime_start::
_chipset_get_datetime:
;chipset.c:24: CLOCK_PORT = CLOCK_GET_DATETIME;
	ld	a,#0x00
	out	(_CLOCK_PORT),a
	ret
_chipset_get_datetime_end::
;chipset.c:27: void chipset_set_datetime() {
;	---------------------------------
; Function chipset_set_datetime
; ---------------------------------
_chipset_set_datetime_start::
_chipset_set_datetime:
;chipset.c:28: CLOCK_PORT = CLOCK_SET_DATETIME;
	ld	a,#0x01
	out	(_CLOCK_PORT),a
	ret
_chipset_set_datetime_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
