;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sat Feb 28 20:55:56 2015
;--------------------------------------------------------
	.module io
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bios_conout
	.globl _bios_conin
	.globl _CLOCK
	.globl _IO_RET
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _putc
	.globl _getc
	.globl _print
	.globl _print_hex
	.globl _print_unsigned_char
	.globl _print_unsigned_int_hex
	.globl _print_unsigned_long_hex
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
;io.c:4: void putc(char c) {
;	---------------------------------
; Function putc
; ---------------------------------
_putc_start::
_putc:
;io.c:5: bios_conout(c);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_bios_conout
	inc	sp
	ret
_putc_end::
;io.c:8: char getc() {
;	---------------------------------
; Function getc
; ---------------------------------
_getc_start::
_getc:
;io.c:9: return bios_conin();
	jp	_bios_conin
_getc_end::
;io.c:12: void print(char* string) {
;	---------------------------------
; Function print
; ---------------------------------
_print_start::
_print:
;io.c:13: const char* ptr = string;
	pop	bc
	pop	hl
	push	hl
	push	bc
;io.c:14: do {
00101$:
;io.c:15: bios_conout(*ptr);
	ld	d,(hl)
	push	hl
	push	de
	inc	sp
	call	_bios_conout
	inc	sp
	pop	hl
;io.c:16: ptr++;
	inc	hl
;io.c:17: } while (*ptr != 0);
	ld	a,(hl)
	or	a, a
	jr	NZ,00101$
	ret
_print_end::
;io.c:20: void print_hex(unsigned char hex) {
;	---------------------------------
; Function print_hex
; ---------------------------------
_print_hex_start::
_print_hex:
;io.c:21: unsigned char tmp = (hex>>4) & 0x0F;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	and	a, #0x0F
;io.c:22: putc(tmp<0x0A?tmp+'0':tmp-0x0A+'A');
	ld	h,a
	sub	a, #0x0A
	jr	NC,00103$
	ld	a,h
	add	a, #0x30
	jr	00104$
00103$:
	ld	a,h
	add	a, #0x37
00104$:
	push	af
	inc	sp
	call	_putc
	inc	sp
;io.c:23: tmp = hex & 0x0F;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	and	a, #0x0F
;io.c:22: putc(tmp<0x0A?tmp+'0':tmp-0x0A+'A');
;io.c:24: putc(tmp<0x0A?tmp+'0':tmp-0x0A+'A');
	ld	h,a
	sub	a, #0x0A
	jr	NC,00105$
	ld	a,h
	add	a, #0x30
	jr	00106$
00105$:
	ld	a,h
	add	a, #0x37
00106$:
	push	af
	inc	sp
	call	_putc
	inc	sp
	ret
_print_hex_end::
;io.c:27: void print_unsigned_char(unsigned char data) {
;	---------------------------------
; Function print_unsigned_char
; ---------------------------------
_print_unsigned_char_start::
_print_unsigned_char:
;io.c:28: if (data>99) putc(data/100 + '0');
	ld	a,#0x63
	ld	iy,#2
	add	iy,sp
	sub	a, 0 (iy)
	jr	NC,00102$
	ld	a,#0x64
	push	af
	inc	sp
	ld	a,0 (iy)
	push	af
	inc	sp
	call	__divuchar_rrx_s
	pop	af
	ld	a,l
	add	a, #0x30
	push	af
	inc	sp
	call	_putc
	inc	sp
00102$:
;io.c:29: if (data>9) putc((data/10)%10 + '0');
	ld	a,#0x09
	ld	iy,#2
	add	iy,sp
	sub	a, 0 (iy)
	jr	NC,00104$
	ld	a,#0x0A
	push	af
	inc	sp
	ld	a,0 (iy)
	push	af
	inc	sp
	call	__divuchar_rrx_s
	pop	af
	ld	d,l
	ld	a,#0x0A
	push	af
	inc	sp
	push	de
	inc	sp
	call	__moduchar_rrx_s
	pop	af
	ld	a,l
	add	a, #0x30
	push	af
	inc	sp
	call	_putc
	inc	sp
00104$:
;io.c:30: putc(data%10 + '0');
	ld	a,#0x0A
	push	af
	inc	sp
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	__moduchar_rrx_s
	pop	af
	ld	a,l
	add	a, #0x30
	push	af
	inc	sp
	call	_putc
	inc	sp
	ret
_print_unsigned_char_end::
;io.c:33: void print_unsigned_int_hex(unsigned int data) {
;	---------------------------------
; Function print_unsigned_int_hex
; ---------------------------------
_print_unsigned_int_hex_start::
_print_unsigned_int_hex:
	push	af
;io.c:35: tmp.value=data;
	ld	hl,#0x0000
	add	hl,sp
	ld	iy,#4
	add	iy,sp
	ld	a,0 (iy)
	ld	(hl),a
	inc	hl
	ld	a,1 (iy)
	ld	(hl),a
;io.c:37: print_hex(tmp.bytes[1]);
	ld	hl,#0x0001
	add	hl,sp
	ld	h,(hl)
	push	hl
	inc	sp
	call	_print_hex
	inc	sp
;io.c:38: print_hex(tmp.bytes[0]);
	ld	hl,#0x0000
	add	hl,sp
	ld	h,(hl)
	push	hl
	inc	sp
	call	_print_hex
	inc	sp
	pop	af
	ret
_print_unsigned_int_hex_end::
;io.c:41: void print_unsigned_long_hex(unsigned long data) {
;	---------------------------------
; Function print_unsigned_long_hex
; ---------------------------------
_print_unsigned_long_hex_start::
_print_unsigned_long_hex:
	push	af
	push	af
;io.c:44: tmp.value=data;
	ld	hl,#0x0000
	add	hl,sp
	ex	de,hl
	ld	hl, #0x0006
	add	hl, sp
	ld	bc, #0x0004
	ldir
;io.c:46: for (i=3;i>=0;i--) {
	ld	d,#0x03
00102$:
;io.c:47: print_hex(tmp.bytes[i]);
	ld	hl,#0x0000
	add	hl,sp
	ld	c,d
	ld	b,#0x00
	add	hl,bc
	ld	h,(hl)
	push	de
	push	hl
	inc	sp
	call	_print_hex
	inc	sp
	pop	de
;io.c:46: for (i=3;i>=0;i--) {
	dec	d
	bit	7, d
	jr	Z,00102$
	pop	af
	pop	af
	ret
_print_unsigned_long_hex_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
