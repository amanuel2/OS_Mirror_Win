#ifndef _STD_LIB_H_
#pragma once
#define _STD_LIB_H_ 1

#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>
#include "math.h"
#include "serial.h"

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;




//static int num_count_viedo_memory = 0;

void printf(char *str,...);
void putchar(char str,char next_str,va_list &arg);
int32_t strlen(int8_t *str);
void strcat(char * Dest, char const * Src);
//int8_t* str_cat(int8_t *dest, const int8_t *src);
void reverse(char str[], int32_t length);
char* itoa(int val);
void cls();
void update_clock_time_taken(int sec);
#endif