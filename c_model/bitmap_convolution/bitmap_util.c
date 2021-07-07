#include "bitmap_util.h"


void sel_color(unsigned char *data,int color,int weight,int size){
	
	int i;	
	for(i = 0 ; i <size;i++){
		
		int colordefault = *(data+i); 
		
		
		if(i %3 == color){
			
			if ((colordefault + weight) > 255 ){
				*(data+i) = 255;
			}
			else if((colordefault + weight) < 0){
				*(data-i);
			}
			else {
					*(data+i) = colordefault+ weight;
			}

		}
		else   {
			if ((colordefault - weight) > 255 ){
				*(data+i) = 255;
			}
			else if((colordefault - weight) < 0){
				*(data-i);
			}
			else {
				*(data+i) = colordefault - weight;
			}
		}
	}
}

void make_frame(unsigned char *data, unsigned char *temp, int xstart,int ystart, int xend,int yend, int thick,int height,int width){

	int half_thick = thick / 2;
	int i,j,k;
	
	printf("in makeframe\n");

	int visited = 0;

	for(i = 0 ; i <height;i++){
		for(j = 0 ;j <width;j++){
		visited = 0;
			for(k = 0; k <3 ; k++){
				if(visited ==1){
					*(temp + ((i*width*3) + (j*3) + k)) = 0;
					continue;		
				}
				
				//LEFT LINE	
				if( j > xstart - half_thick && j < xstart + half_thick){
					if(ystart - half_thick < i && i < yend +half_thick){
						*(temp +(i*width*3)+(j*3)+k) = 255;
						visited = 1;
					}
						
				}
				//RIGHT LINE
				 if( j > xend - half_thick && j < xend + half_thick){
					if(ystart - half_thick < i && i < yend +half_thick){
						*(temp +(i*width*3)+(j*3)+k) = 255;
						visited = 1;
						}
				}
				//TOP LINE
				 if( i > ystart - half_thick && i < ystart + half_thick){
					if(xstart - half_thick < j && j <xend +half_thick){
						*(temp +(i*width*3)+(j*3)+k) = 255;
						visited = 1;
						}
				}
				//BOTTOM LINE
				if( i > yend - half_thick && i <  yend + half_thick){
					if(xstart - half_thick < j && j< xend +half_thick){
						*(temp +(i*width*3)+(j*3)+k) = 255;
						visited = 1;
						}
				}
				if(!visited)
					*(temp+(i*width*3)+(j*3)+k) = *(data+(i*width*3)+(j*3)+k);
				
			}
		}
	}

}

void sel_position(unsigned char *data,unsigned char *temp, int width,int height,int rgb_bit,int factor){
	
	int i,j,k = 0;

	int iSize = height-1;
	int jSize = width-1;

	
	if(factor ==0){
	
		for(i = 0 ; i <height;i++){
			for(j = 0 ;j <width;j++){
				for(k = 0; k <rgb_bit ; k++){
					*(temp + (i*width)*3+(j*3)+k) = *(data +(width*3*i)+(j*3)+k);
				}	
			}
		}
	}
	else if(factor == 1){
		for(i = 0 ; i <height;i++){
			for(j = 0 ;j <width;j++){
				for(k = 0; k <rgb_bit ; k++){
					*(temp + (i*width*3)+((jSize-j)*3)+k) = *(data +(width*3*i)+(j*3)+k);
				}	
			}
		}
	}
	else if(factor == 2){
		for(i = 0 ; i <height;i++){
			for(j = 0 ;j <width;j++){
				for(k = 0; k <rgb_bit ; k++){
					*(temp + ((iSize-i)*width*3)+(j*3)+k) = *(data +(width*3*i)+(j*3)+k);
				}	
			}
		}
	}
	else if(factor == 3){
		for(i = 0 ; i <height;i++){
			for(j = 0 ;j <width;j++){
				for(k = 0; k <rgb_bit ; k++){
					*(temp + ((iSize-i)*width*3)+(jSize-j)*3+k) = *(data +(width*3*i)+(j*3)+k);
				}	
			}
		}
	}
	
}	


