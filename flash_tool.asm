;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Mon Feb 23 21:52:08 2015
;--------------------------------------------------------
	.module flash_tool
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _chipset_flash_bios
	.globl _chipset_load_sector_into_memory
	.globl _print
	.globl _CLOCK
	.globl _IO_RET
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _flash_tool_rescue_mode
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
;flash_tool.c:3: void flash_tool_rescue_mode() {
;	---------------------------------
; Function flash_tool_rescue_mode
; ---------------------------------
_flash_tool_rescue_mode_start::
_flash_tool_rescue_mode:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;flash_tool.c:7: print("\33[H\33[2JFLASH BIOS\r\nREAD SDCARD Sector 1-8");
	ld	hl,#___str_0
	push	hl
	call	_print
	pop	af
;flash_tool.c:9: for (i=0; i<8; i++) {
	ld	-1 (ix),#0x00
00102$:
;flash_tool.c:10: chipset_load_sector_into_memory((void *) addresses[i],i+1);
	ld	l,-1 (ix)
	ld	h,#0x00
	ld	e, l
	ld	d, h
	inc	de
	ld	a,d
	rla
	sbc	a, a
	ld	c,a
	ld	b,a
	add	hl, hl
	ld	a,#<(_flash_tool_rescue_mode_addresses_1_15)
	add	a, l
	ld	l,a
	ld	a,#>(_flash_tool_rescue_mode_addresses_1_15)
	adc	a, h
	ld	h,a
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	pop	iy
	push	bc
	push	de
	push	iy
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;flash_tool.c:9: for (i=0; i<8; i++) {
	inc	-1 (ix)
	ld	a,-1 (ix)
	sub	a, #0x08
	jr	C,00102$
;flash_tool.c:13: print("\r\nWRITE EEPROM");
	ld	hl,#___str_1
	push	hl
	call	_print
;flash_tool.c:15: chipset_flash_bios((void *) 0x1100);
	ld	hl, #0x1100
	ex	(sp),hl
	call	_chipset_flash_bios
	pop	af
	inc	sp
	pop	ix
	ret
_flash_tool_rescue_mode_end::
_flash_tool_rescue_mode_addresses_1_15:
	.dw #0x1100
	.dw #0x1300
	.dw #0x1500
	.dw #0x1700
	.dw #0x1900
	.dw #0x1B00
	.dw #0x1D00
	.dw #0x1F00
___str_0:
	.db 0x1B
	.ascii "[H"
	.db 0x1B
	.ascii "[2JFLASH BIOS"
	.db 0x0D
	.db 0x0A
	.ascii "READ SDCARD Sector 1-8"
	.db 0x00
___str_1:
	.db 0x0D
	.db 0x0A
	.ascii "WRITE EEPROM"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
