;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sat Feb 28 20:55:56 2015
;--------------------------------------------------------
	.module malloc
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _malloc
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_heap:
	.ds 2
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
;malloc.c:5: void * malloc(unsigned int size) {
;	---------------------------------
; Function malloc
; ---------------------------------
_malloc_start::
_malloc:
;malloc.c:6: unsigned int tmp = heap;
	ld	de,(_heap)
;malloc.c:7: heap += size;
	ld	hl,#2
	add	hl,sp
	push	de
	ld	iy,#_heap
	push	iy
	pop	de
	ld	a,(de)
	add	a, (hl)
	ld	(de),a
	inc	de
	ld	a,(de)
	inc	hl
	adc	a, (hl)
	ld	(de),a
;malloc.c:8: return (void *) tmp;
	pop	hl
	ret
_malloc_end::
	.area _CODE
	.area _INITIALIZER
__xinit__heap:
	.dw #0x1100
	.area _CABS (ABS)
