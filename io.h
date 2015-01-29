#ifndef IO_H
#define	IO_H

#include "bool.h"
#include "chipset.h"
#include "bios.h"

typedef union {
	unsigned int value;
    unsigned char bytes[2];
} Int; 

typedef union {
	unsigned long value;
    unsigned char bytes[4];
} Long; 

void putc(char c);
char getc();
void print(const char* const string);
void print_hex(unsigned char hex);
void print_unsigned_char(unsigned char data);
void print_unsigned_int_hex(unsigned int data);
void print_unsigned_long_hex(unsigned long data);

#endif /* IO_H */