#include "bitmap_util.h"

int main(int args, char* argv[] ){


	int i,j,k;
	FILE *fpBmp;
	FILE *destBmp;
	BITMAPFILEHEADER fileHeader;
	BITMAPINFOHEADER infoHeader;



	fpBmp = fopen(argv[1],"rb");

	if(fpBmp == NULL) {
		printf("error\n");
		return -1;
		}
	
	printf("file opened\n");	
	
	int a = 255;
	int b = 0;

	fread(&fileHeader,sizeof(BITMAPFILEHEADER),1,fpBmp);
	fread(&infoHeader,sizeof(BITMAPINFOHEADER),1,fpBmp);
	
	
	int size = infoHeader.bitWidth * infoHeader.bitHeight * 3;
	unsigned char *data = (unsigned char*)calloc(size,sizeof(unsigned char));
	unsigned char *temp = (unsigned char*)calloc(size,sizeof(unsigned char));


	fread(data,size,2,fpBmp);
	
	fclose(fpBmp);
	destBmp = fopen(argv[2],"wb");

	if(destBmp == NULL) {
		printf("error\n");
		return -1;
		}
 
	sel_color(data,2,50,size);
	sel_position(data,temp,infoHeader.bitWidth,infoHeader.bitHeight,3,1);
	make_frame(temp,data,40,40,472,472,10,infoHeader.bitWidth,infoHeader.bitHeight);

	fwrite(&fileHeader,sizeof(BITMAPFILEHEADER),1,destBmp);
	fwrite(&infoHeader,sizeof(BITMAPINFOHEADER),1,destBmp);
	fwrite(data,size,1,destBmp);
	
	fclose(destBmp);
	return 0;
	
}




