#include <stdio.h>
#include "bitmap.h"

void sel_color(unsigned char *data,int color,int weight,int size);
void make_frame(unsigned char *data, unsigned char *temp, int xstart,int ystart, int xend,int yend, int thick,int height,int width);
void sel_position(unsigned char *data,unsigned char *temp, int width,int height,int rgb_bit,int factor);

