;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sat Feb 28 20:55:56 2015
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _test
	.globl _get_unsigned_char
	.globl _print_datetime
	.globl _flash_tool_rescue_mode
	.globl _chipset_set_datetime
	.globl _chipset_get_datetime
	.globl _chipset_init_sdcard
	.globl _chipset_load_sector_into_memory
	.globl _chipset_restart
	.globl _print_hex
	.globl _print
	.globl _getc
	.globl _putc
	.globl _CLOCK
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
;main.c:20: void print_datetime() {
;	---------------------------------
; Function print_datetime
; ---------------------------------
_print_datetime_start::
_print_datetime:
;main.c:21: print("\r\n20");
	ld	hl,#___str_0
	push	hl
	call	_print
	pop	af
;main.c:22: print_hex(CLOCK.year);
	ld	a, (#(_CLOCK + 0x0006) + 0)
	push	af
	inc	sp
	call	_print_hex
	inc	sp
;main.c:23: putc('-');
	ld	a,#0x2D
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:24: print_hex(CLOCK.month);
	ld	a, (#(_CLOCK + 0x0005) + 0)
	push	af
	inc	sp
	call	_print_hex
	inc	sp
;main.c:25: putc('-');
	ld	a,#0x2D
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:26: print_hex(CLOCK.date);
	ld	a, (#(_CLOCK + 0x0004) + 0)
	push	af
	inc	sp
	call	_print_hex
	inc	sp
;main.c:28: putc(' ');
	ld	a,#0x20
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:29: print_hex(CLOCK.hours);
	ld	a, (#(_CLOCK + 0x0002) + 0)
	push	af
	inc	sp
	call	_print_hex
	inc	sp
;main.c:30: putc(':');
	ld	a,#0x3A
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:31: print_hex(CLOCK.min);
	ld	a, (#(_CLOCK + 0x0001) + 0)
	push	af
	inc	sp
	call	_print_hex
	inc	sp
;main.c:32: putc(':');
	ld	a,#0x3A
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:33: print_hex(CLOCK.sec);
	ld	a, (#_CLOCK + 0)
	push	af
	inc	sp
	call	_print_hex
	inc	sp
;main.c:34: print("\r\n");
	ld	hl,#___str_1
	push	hl
	call	_print
	pop	af
	ret
_print_datetime_end::
_SDCARD_FAILED:
	.dw __str_2
_mbr:
	.dw #0x1100
___str_0:
	.db 0x0D
	.db 0x0A
	.ascii "20"
	.db 0x00
___str_1:
	.db 0x0D
	.db 0x0A
	.db 0x00
__str_2:
	.db 0x0D
	.db 0x0A
	.ascii "SDCARD MISSING OR FAILED!"
	.db 0x0D
	.db 0x0A
	.db 0x00
;main.c:37: unsigned char get_unsigned_char() {
;	---------------------------------
; Function get_unsigned_char
; ---------------------------------
_get_unsigned_char_start::
_get_unsigned_char:
;main.c:39: c1 = getc();
	call	_getc
	ld	d,l
;main.c:40: putc(c1);
	push	de
	push	de
	inc	sp
	call	_putc
	inc	sp
	call	_getc
	pop	de
	ld	e,l
;main.c:42: putc(c2);
	push	de
	ld	a,e
	push	af
	inc	sp
	call	_putc
	inc	sp
	pop	de
;main.c:43: return ((c1-'0')<<4) | (c2-'0');
	ld	a,d
	add	a,#0xD0
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	d,a
	ld	a,e
	add	a,#0xD0
	or	a, d
	ld	l,a
	ret
_get_unsigned_char_end::
;main.c:46: void test() {
;	---------------------------------
; Function test
; ---------------------------------
_test_start::
_test:
;main.c:48: print("\r\n20YY-MM-DD hh:mm:nn");
	ld	hl,#___str_3+0
	push	hl
	call	_print
;main.c:49: print("\r\n20");
	ld	hl, #___str_4+0
	ex	(sp),hl
	call	_print
	pop	af
;main.c:50: CLOCK.year = get_unsigned_char();
	call	_get_unsigned_char
	ld	a,l
	ld	(#(_CLOCK + 0x0006)),a
;main.c:51: putc('-');
	ld	a,#0x2D
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:52: CLOCK.month = get_unsigned_char();
	call	_get_unsigned_char
	ld	a,l
	ld	(#(_CLOCK + 0x0005)),a
;main.c:53: putc('-');
	ld	a,#0x2D
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:54: CLOCK.date = get_unsigned_char();
	call	_get_unsigned_char
	ld	a,l
	ld	(#(_CLOCK + 0x0004)),a
;main.c:55: putc(' ');
	ld	a,#0x20
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:56: CLOCK.hours = get_unsigned_char();
	call	_get_unsigned_char
	ld	a,l
	ld	(#(_CLOCK + 0x0002)),a
;main.c:57: putc(':');
	ld	a,#0x3A
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:58: CLOCK.min = get_unsigned_char();
	call	_get_unsigned_char
	ld	a,l
	ld	(#(_CLOCK + 0x0001)),a
;main.c:59: putc(':');
	ld	a,#0x3A
	push	af
	inc	sp
	call	_putc
	inc	sp
;main.c:60: CLOCK.sec = get_unsigned_char();
	call	_get_unsigned_char
	ld	a,l
	ld	(#_CLOCK),a
;main.c:61: print_datetime();
	call	_print_datetime
;main.c:62: print("Save ? (Y/N) ");
	ld	hl,#___str_5+0
	push	hl
	call	_print
	pop	af
;main.c:63: temp = getc();
	call	_getc
	ld	h,l
;main.c:64: putc(temp);
	push	hl
	push	hl
	inc	sp
	call	_putc
	inc	sp
	pop	hl
;main.c:65: if (temp == 'Y') chipset_set_datetime();
	ld	a,h
	sub	a, #0x59
	jr	NZ,00102$
	call	_chipset_set_datetime
00102$:
;main.c:66: chipset_get_datetime();
	call	_chipset_get_datetime
;main.c:67: print_datetime();
	jp	_print_datetime
_test_end::
___str_3:
	.db 0x0D
	.db 0x0A
	.ascii "20YY-MM-DD hh:mm:nn"
	.db 0x00
___str_4:
	.db 0x0D
	.db 0x0A
	.ascii "20"
	.db 0x00
___str_5:
	.ascii "Save ? (Y/N) "
	.db 0x00
;main.c:70: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;main.c:72: unsigned char exit = FALSE;
	ld	-1 (ix),#0x00
;main.c:74: print("\33[H"); // Home
	ld	hl,#___str_6
	push	hl
	call	_print
;main.c:75: print("\33[2J"); // VT100 clear screen
	ld	hl, #___str_7
	ex	(sp),hl
	call	_print
;main.c:78: print("\r\n  ________   ___   ____                            _\r\n |__  ( _ ) / _ \\ / ___|___  _ __ ___  _ __  _   _| |_ ___ _ __\r\n   / // _ \\| | | | |   / _ \\| '_ ` _ \\| '_ \\| | | | __/ _ \\ '__|\r\n  / /| (_) | |_| | |__| (_) | | | | | | |_) | |_| | ||  __/ |\r\n /____\\___/ \\___/ \\____\\___/|_| |_| |_| .__/ \\__,_|\\__\\___|_|\r\n                                      |_|\r\n\r\n");  
	ld	hl, #___str_8
	ex	(sp),hl
	call	_print
	pop	af
;main.c:81: chipset_get_datetime();
	call	_chipset_get_datetime
;main.c:82: print_datetime();
	call	_print_datetime
;main.c:83: print("\r\nBIOS v0.9 - Functions :\r\n");
	ld	hl,#___str_9
	push	hl
	call	_print
;main.c:85: print("\r\n1 RESTART");
	ld	hl, #___str_10
	ex	(sp),hl
	call	_print
;main.c:86: print("\r\n2 BOOT");
	ld	hl, #___str_11
	ex	(sp),hl
	call	_print
;main.c:87: print("\r\n3 FLASH BIOS (SDCARD Sector 1-8)");
	ld	hl, #___str_12
	ex	(sp),hl
	call	_print
;main.c:88: print("\r\n4 SET DATE/TIME\r\n");
	ld	hl, #___str_13
	ex	(sp),hl
	call	_print
	pop	af
;main.c:90: enable_interrupt();	
	EI
;main.c:92: while(exit == FALSE) {
00116$:
	ld	a,-1 (ix)
	or	a, a
	jp	NZ,00119$
;main.c:93: byte = getc();
	call	_getc
	ld	h,l
;main.c:94: putc(byte);
	push	hl
	push	hl
	inc	sp
	call	_putc
	inc	sp
	pop	hl
;main.c:96: switch(byte) {
	ld	a,h
	sub	a, #0x31
	jp	C,00114$
	ld	a,#0x34
	sub	a, h
	jp	C,00114$
	ld	a,h
	add	a,#0xCF
	ld	e,a
	ld	d,#0x00
	ld	hl,#00149$
	add	hl,de
	add	hl,de
;main.c:97: case '1':
	jp	(hl)
00149$:
	jr	00101$
	jr	00102$
	jr	00109$
	jr	00113$
00101$:
;main.c:98: chipset_restart();
	call	_chipset_restart
;main.c:99: break;
	jr	00116$
;main.c:100: case '2':
00102$:
;main.c:101: if (chipset_init_sdcard() == 0) {
	call	_chipset_init_sdcard
	ld	a,l
	or	a, a
	jr	NZ,00107$
;main.c:102: chipset_load_sector_into_memory(mbr, MBR_SECTOR);
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
;main.c:103: if (mbr->signature == MBR_SIGNATURE)
	ld	hl,(_mbr)
	ld	de, #0x01FE
	add	hl, de
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	ld	a,d
	sub	a, #0x55
	jr	NZ,00104$
	ld	a,e
	sub	a, #0xAA
	jr	NZ,00104$
;main.c:104: exit = TRUE;
	ld	-1 (ix),#0x01
	jr	00116$
00104$:
;main.c:106: print("\r\nNON SYSTEM DISK\r\n");
	ld	hl,#___str_14
	push	hl
	call	_print
	pop	af
	jr	00116$
00107$:
;main.c:108: print(SDCARD_FAILED);
	ld	hl,(_SDCARD_FAILED)
	push	hl
	call	_print
	pop	af
;main.c:110: break;
	jp	00116$
;main.c:111: case '3':
00109$:
;main.c:112: if (chipset_init_sdcard() == 0) {
	call	_chipset_init_sdcard
	ld	a,l
	or	a, a
	jr	NZ,00111$
;main.c:113: flash_tool_rescue_mode();
	call	_flash_tool_rescue_mode
;main.c:114: chipset_restart();
	call	_chipset_restart
	jp	00116$
00111$:
;main.c:116: print(SDCARD_FAILED);
	ld	hl,(_SDCARD_FAILED)
	push	hl
	call	_print
	pop	af
;main.c:118: break;
	jp	00116$
;main.c:119: case '4':
00113$:
;main.c:120: test();
	call	_test
;main.c:121: break;
	jp	00116$
;main.c:122: default:
00114$:
;main.c:123: print("\r\nUnknown command\r\n");
	ld	hl,#___str_15
	push	hl
	call	_print
	pop	af
;main.c:124: }
	jp	00116$
00119$:
	inc	sp
	pop	ix
	ret
_main_end::
___str_6:
	.db 0x1B
	.ascii "[H"
	.db 0x00
___str_7:
	.db 0x1B
	.ascii "[2J"
	.db 0x00
___str_8:
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
___str_9:
	.db 0x0D
	.db 0x0A
	.ascii "BIOS v0.9 - Functions :"
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_10:
	.db 0x0D
	.db 0x0A
	.ascii "1 RESTART"
	.db 0x00
___str_11:
	.db 0x0D
	.db 0x0A
	.ascii "2 BOOT"
	.db 0x00
___str_12:
	.db 0x0D
	.db 0x0A
	.ascii "3 FLASH BIOS (SDCARD Sector 1-8)"
	.db 0x00
___str_13:
	.db 0x0D
	.db 0x0A
	.ascii "4 SET DATE/TIME"
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_14:
	.db 0x0D
	.db 0x0A
	.ascii "NON SYSTEM DISK"
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_15:
	.db 0x0D
	.db 0x0A
	.ascii "Unknown command"
	.db 0x0D
	.db 0x0A
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
