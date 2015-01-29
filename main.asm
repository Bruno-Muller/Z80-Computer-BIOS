;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sun Jan 25 23:44:55 2015
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _flash_tool_fat16
	.globl _flash_tool_rescue_mode
	.globl _chipset_init_sdcard
	.globl _chipset_load_sector_into_memory
	.globl _chipset_restart
	.globl _print
	.globl _getc
	.globl _putc
	.globl _IO_RET
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _mbr
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_USART_PORT	=	0x0000
_TIMER_PORT	=	0x0001
_SDCARD_PORT	=	0x0002
_EEPROM_PORT	=	0x0003
_RESTART_PORT	=	0x0004
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_IO_PARAM1	=	0x0050
_IO_PARAM2	=	0x0052
_IO_RET	=	0x0056
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
;main.c:19: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;main.c:21: unsigned char exit = FALSE;
	ld	-1 (ix),#0x00
;main.c:23: print("\33[H"); // Home
	ld	hl,#___str_0
	push	hl
	call	_print
;main.c:24: print("\33[2J"); // VT100 clear screen
	ld	hl, #___str_1
	ex	(sp),hl
	call	_print
;main.c:27: print("\r\n  ________   ___   ____                            _\r\n |__  ( _ ) / _ \\ / ___|___  _ __ ___  _ __  _   _| |_ ___ _ __\r\n   / // _ \\| | | | |   / _ \\| '_ ` _ \\| '_ \\| | | | __/ _ \\ '__|\r\n  / /| (_) | |_| | |__| (_) | | | | | | |_) | |_| | ||  __/ |\r\n /____\\___/ \\___/ \\____\\___/|_| |_| |_| .__/ \\__,_|\\__\\___|_|\r\n                                      |_|\r\n\r\n");  
	ld	hl, #___str_2
	ex	(sp),hl
	call	_print
;main.c:30: print("BIOS v0.9 - Functions :\r\n");
	ld	hl, #___str_3
	ex	(sp),hl
	call	_print
;main.c:31: print("\r\n1 FLASH TOOL");
	ld	hl, #___str_4
	ex	(sp),hl
	call	_print
;main.c:32: print("\r\n2 RESTART");
	ld	hl, #___str_5
	ex	(sp),hl
	call	_print
;main.c:33: print("\r\n3 BOOT");
	ld	hl, #___str_6
	ex	(sp),hl
	call	_print
;main.c:34: print("\r\n4 FLASH BIOS in rescue mode (SDCARD Sector 1-8)\r\n");
	ld	hl, #___str_7
	ex	(sp),hl
	call	_print
	pop	af
;main.c:36: enable_interrupt();	
	EI
;main.c:38: while(exit == FALSE) {
00119$:
	ld	a,-1 (ix)
	or	a, a
	jp	NZ,00122$
;main.c:39: byte = getc();
	call	_getc
	ld	h,l
;main.c:40: putc(byte);
	push	hl
	push	hl
	inc	sp
	call	_putc
	inc	sp
	pop	hl
;main.c:42: switch(byte) {
	ld	a,h
	sub	a, #0x31
	jp	C,00117$
	ld	a,#0x34
	sub	a, h
	jp	C,00117$
	ld	a,h
	add	a,#0xCF
	ld	e,a
	ld	d,#0x00
	ld	hl,#00156$
	add	hl,de
	add	hl,de
;main.c:43: case '1':
	jp	(hl)
00156$:
	jr	00101$
	jr	00105$
	jr	00106$
	jr	00113$
00101$:
;main.c:44: if (chipset_init_sdcard() == 0) {
	call	_chipset_init_sdcard
	ld	a,l
	or	a, a
	jr	NZ,00103$
;main.c:45: flash_tool_fat16();
	call	_flash_tool_fat16
;main.c:46: chipset_restart();
	call	_chipset_restart
	jr	00119$
00103$:
;main.c:48: print(SDCARD_FAILED);
	ld	hl,(_SDCARD_FAILED)
	push	hl
	call	_print
	pop	af
;main.c:50: break;
	jr	00119$
;main.c:51: case '2':
00105$:
;main.c:52: chipset_restart();
	call	_chipset_restart
;main.c:53: break;
	jr	00119$
;main.c:54: case '3':
00106$:
;main.c:55: if (chipset_init_sdcard() == 0) {
	call	_chipset_init_sdcard
	ld	a,l
	or	a, a
	jr	NZ,00111$
;main.c:56: chipset_load_sector_into_memory(mbr, MBR_SECTOR);
	ld	de,(_mbr)
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	push	de
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:57: if (mbr->signature == MBR_SIGNATURE)
	ld	hl,(_mbr)
	ld	de, #0x01FE
	add	hl, de
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	ld	a,d
	sub	a, #0x55
	jr	NZ,00108$
	ld	a,e
	sub	a, #0xAA
	jr	NZ,00108$
;main.c:58: exit = TRUE;
	ld	-1 (ix),#0x01
	jp	00119$
00108$:
;main.c:60: print("\r\nNON SYSTEM DISK\r\n");
	ld	hl,#___str_8
	push	hl
	call	_print
	pop	af
	jp	00119$
00111$:
;main.c:62: print(SDCARD_FAILED);
	ld	hl,(_SDCARD_FAILED)
	push	hl
	call	_print
	pop	af
;main.c:64: break;
	jp	00119$
;main.c:65: case '4':
00113$:
;main.c:66: if (chipset_init_sdcard() == 0) {
	call	_chipset_init_sdcard
	ld	a,l
	or	a, a
	jr	NZ,00115$
;main.c:67: flash_tool_rescue_mode();
	call	_flash_tool_rescue_mode
;main.c:68: chipset_restart();
	call	_chipset_restart
	jp	00119$
00115$:
;main.c:70: print(SDCARD_FAILED);
	ld	hl,(_SDCARD_FAILED)
	push	hl
	call	_print
	pop	af
;main.c:72: break;
	jp	00119$
;main.c:73: default:
00117$:
;main.c:74: print("\r\nUnknown command\r\n");
	ld	hl,#___str_9
	push	hl
	call	_print
	pop	af
;main.c:75: }
	jp	00119$
00122$:
	inc	sp
	pop	ix
	ret
_main_end::
_SDCARD_FAILED:
	.dw __str_10
_mbr:
	.dw #0x1100
___str_0:
	.db 0x1B
	.ascii "[H"
	.db 0x00
___str_1:
	.db 0x1B
	.ascii "[2J"
	.db 0x00
___str_2:
	.db 0x0D
	.db 0x0A
	.ascii "  ________   ___   ____                            _"
	.db 0x0D
	.db 0x0A
	.ascii " |__"
	.ascii "  ( _ ) / _ "
	.db 0x5C
	.ascii " / ___|___  _ __ ___  _ __  _   _| |_ ___ _ __"
	.db 0x0D
	.db 0x0A
	.ascii "   / // _ "
	.db 0x5C
	.ascii "| | | | |   / _ "
	.db 0x5C
	.ascii "| '_ ` _ "
	.db 0x5C
	.ascii "| '_ "
	.db 0x5C
	.ascii "| | | | __/ _ "
	.db 0x5C
	.ascii " '__|"
	.db 0x0D
	.db 0x0A
	.ascii "  / /| (_) | |_| | |__| (_) | | | | | | |_) | |_| | |"
	.ascii "|  __/ |"
	.db 0x0D
	.db 0x0A
	.ascii " /____"
	.db 0x5C
	.ascii "___/ "
	.db 0x5C
	.ascii "___/ "
	.db 0x5C
	.ascii "____"
	.db 0x5C
	.ascii "___/|_| |_| |_| .__/ "
	.db 0x5C
	.ascii "__,_"
	.ascii "|"
	.db 0x5C
	.ascii "__"
	.db 0x5C
	.ascii "___|_|"
	.db 0x0D
	.db 0x0A
	.ascii "                                      |_|"
	.db 0x0D
	.db 0x0A
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_3:
	.ascii "BIOS v0.9 - Functions :"
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_4:
	.db 0x0D
	.db 0x0A
	.ascii "1 FLASH TOOL"
	.db 0x00
___str_5:
	.db 0x0D
	.db 0x0A
	.ascii "2 RESTART"
	.db 0x00
___str_6:
	.db 0x0D
	.db 0x0A
	.ascii "3 BOOT"
	.db 0x00
___str_7:
	.db 0x0D
	.db 0x0A
	.ascii "4 FLASH BIOS in rescue mode (SDCARD Sector 1-8)"
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_8:
	.db 0x0D
	.db 0x0A
	.ascii "NON SYSTEM DISK"
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_9:
	.db 0x0D
	.db 0x0A
	.ascii "Unknown command"
	.db 0x0D
	.db 0x0A
	.db 0x00
__str_10:
	.db 0x0D
	.db 0x0A
	.ascii "SDCARD MISSING OR FAILED!"
	.db 0x0D
	.db 0x0A
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
