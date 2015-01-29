;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sun Jan 25 23:44:54 2015
;--------------------------------------------------------
	.module fat16
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _putc
	.globl _IO_RET
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _fat16_print_file_name
	.globl _fat16_compare_file_name
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
_fat16_print_file_name_i_1_16:
	.ds 1
_fat16_print_file_name_c_1_16:
	.ds 1
_fat16_compare_file_name_name2_1_20:
	.ds 2
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
;fat16.c:22: static const unsigned char* name2 = "BIOS    BIN";
	ld	hl,#___str_0+0
	ld	(_fat16_compare_file_name_name2_1_20),hl
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;fat16.c:3: void fat16_print_file_name(unsigned char *string) {
;	---------------------------------
; Function fat16_print_file_name
; ---------------------------------
_fat16_print_file_name_start::
_fat16_print_file_name:
;fat16.c:7: for (i=0; i<8; i++) {
	ld	hl,#_fat16_print_file_name_i_1_16 + 0
	ld	(hl), #0x00
00107$:
;fat16.c:8: c = string[i];
	ld	hl,#_fat16_print_file_name_i_1_16
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	add	a, (hl)
	ld	e,a
	ld	a,1 (iy)
	adc	a, #0x00
	ld	d,a
	ld	a,(de)
;fat16.c:9: if (c == ' ') break;
	ld	(#_fat16_print_file_name_c_1_16 + 0),a
	sub	a, #0x20
	jr	Z,00103$
;fat16.c:10: putc(c);
	ld	a,(_fat16_print_file_name_c_1_16)
	push	af
	inc	sp
	call	_putc
	inc	sp
;fat16.c:7: for (i=0; i<8; i++) {
	ld	hl, #_fat16_print_file_name_i_1_16+0
	inc	(hl)
	ld	a,(#_fat16_print_file_name_i_1_16 + 0)
	sub	a, #0x08
	jr	C,00107$
00103$:
;fat16.c:12: putc('.');
	ld	a,#0x2E
	push	af
	inc	sp
	call	_putc
	inc	sp
;fat16.c:14: for (i=8; i<11; i++) {
	ld	hl,#_fat16_print_file_name_i_1_16 + 0
	ld	(hl), #0x08
00109$:
;fat16.c:15: c = string[i];
	ld	hl,#_fat16_print_file_name_i_1_16
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	add	a, (hl)
	ld	e,a
	ld	a,1 (iy)
	adc	a, #0x00
	ld	d,a
	ld	a,(de)
;fat16.c:16: if (c == ' ') break;
	ld	(#_fat16_print_file_name_c_1_16 + 0),a
	sub	a, #0x20
	ret	Z
;fat16.c:17: putc(c);
	ld	a,(_fat16_print_file_name_c_1_16)
	push	af
	inc	sp
	call	_putc
	inc	sp
;fat16.c:14: for (i=8; i<11; i++) {
	ld	hl, #_fat16_print_file_name_i_1_16+0
	inc	(hl)
	ld	a,(#_fat16_print_file_name_i_1_16 + 0)
	sub	a, #0x0B
	jr	C,00109$
	ret
_fat16_print_file_name_end::
;fat16.c:21: unsigned char fat16_compare_file_name(unsigned char* const name1) {
;	---------------------------------
; Function fat16_compare_file_name
; ---------------------------------
_fat16_compare_file_name_start::
_fat16_compare_file_name:
;fat16.c:24: for (i=0; i<11; i++) {
	ld	c,#0x00
00104$:
;fat16.c:25: if (name1[i] != name2[i]) {
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	b,#0x00
	add	hl, bc
	ld	b,(hl)
	ld	iy,(_fat16_compare_file_name_name2_1_20)
	ld	e,c
	ld	d,#0x00
	add	iy, de
	ld	d, 0 (iy)
	ld	a,b
	sub	a, d
	jr	Z,00105$
;fat16.c:26: return FALSE;
	ld	l,#0x00
	ret
00105$:
;fat16.c:24: for (i=0; i<11; i++) {
	inc	c
	ld	a,c
	sub	a, #0x0B
	jr	C,00104$
;fat16.c:29: return TRUE;
	ld	l,#0x01
	ret
_fat16_compare_file_name_end::
___str_0:
	.ascii "BIOS    BIN"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
