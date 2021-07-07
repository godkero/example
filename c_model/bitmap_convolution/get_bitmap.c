#include <stdio.h>
#include "bitmap.h"

int main(){


	int i,j,k;
	int size;
	FILE *fpBmp;
	FILE *newBmp;
	BITMAPFILEHEADER fileHeader;
	BITMAPINFOHEADER infoHeader;



	fpBmp = fopen("./img/lenna.bmp","rb");
	newBmp = fopen("./img/lenna_cp.bmp","wb");

	if(fpBmp == NULL) {
		printf("error\n");
		return -1;
		}
	
	printf("file opened\n");	
	
	fread(&fileHeader,sizeof(BITMAPFILEHEADER),1,fpBmp);
	fread(&infoHeader,sizeof(BITMAPINFOHEADER),1,fpBmp);
	


	int imgSize = infoHeader.bitWidth * infoHeader.bitHeight * (infoHeader.biBitCount /8);
        unsigned char *imgData = (unsigned char*)malloc(imgSize);
	
	fread(imgData,imgSize,1,fpBmp);	
	

	printf("file read\n");
	printf("imgSize = %d\n",imgSize);
	

	fwrite(&fileHeader,sizeof(BITMAPFILEHEADER),1,newBmp);
	fwrite(&infoHeader,sizeof(BITMAPINFOHEADER),1,newBmp);
	fwrite(imgData,imgSize,1,newBmp);


	fclose(fpBmp);
	fclose(newBmp);

	return 0;

	}
