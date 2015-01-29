#include "malloc.h"

static unsigned int heap = MALLOC_HEAP;

void * malloc(unsigned int size) {
	unsigned int tmp = heap;
	heap += size;
	return (void *) tmp;
}