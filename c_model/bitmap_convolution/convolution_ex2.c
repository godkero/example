#include <stdio.h>
#include <stdlib.h>
#include "bitmap_util.h"

void merge_channel(unsigned char *src, unsigned char *dest, int size, int count);
void split(unsigned char *src, unsigned char *dest, int size, int count);
void set_filter(unsigned char *fil_in, int fil_len);
void set_arr(unsigned char *arr_in, int arr_len);
void print_array(unsigned char *arr, int h, int w);
int depth1_value(int ypos, int xpos, int in_len, int filter_len, unsigned char *arr_in, unsigned char *filter_in, int stride);
unsigned char* convolution_cal(unsigned char *arr_in, unsigned char *filter_in, int in_len, int filter_len,int out_len, int stride, int padding);
void convolution_channel(unsigned char *arr_in, unsigned char *filter_in, unsigned char * arr_out,int in_len, int filter_len,int out_len, int stride, int padding, int channel, int count);


int main(int args,char*argv[]){


	FILE *fpBmp;
	FILE *destBmp;
	BITMAPFILEHEADER fileHeader;
	BITMAPINFOHEADER infoHeader;

	fpBmp = fopen(argv[1], "rb");
	destBmp = fopen(argv[2], "wb");

	if (fpBmp == NULL || destBmp == NULL)
	{
		printf("error\n");
		return -1;
	}

	printf("file opened\n");

	fread(&fileHeader, sizeof(BITMAPFILEHEADER), 1, fpBmp);
	fread(&infoHeader, sizeof(BITMAPINFOHEADER), 1, fpBmp);

	int bitmap_size = infoHeader.bitWidth * infoHeader.bitHeight * 3;
	int in_len = infoHeader.bitWidth;
	printf("in_len = %d\n",in_len);

	unsigned char *data = (unsigned char *)calloc(bitmap_size, sizeof(unsigned char));
	unsigned char *temp = (unsigned char *)calloc(bitmap_size, sizeof(unsigned char));

	fread(data, bitmap_size, 2, fpBmp);

	//--------------------- file input

	//parameters
	int arr_len = infoHeader.bitWidth;
	int filter_len = 3;
	int channel_count = 3;
	int padding = 0;
	int stride = 1;


	int out_len = (((in_len - filter_len) + 2 * padding) / stride) + 1;
	printf("out_len = %d\n",out_len);
	int out_size = out_len * out_len * 3;
	int out_pixel = out_len * out_len;
	//set and init
	unsigned char *filter_in = (unsigned char *)calloc(filter_len * filter_len, sizeof(unsigned char));
	unsigned char *arr_out = (unsigned char *)calloc(out_size, sizeof(unsigned char));
	printf("size = %d\n", out_size);
	//if want to merge
	unsigned char *file_out = (unsigned char *)calloc(out_size, sizeof(unsigned char));
	set_filter(filter_in, filter_len);

	//input split using channel 
	split(data, temp, bitmap_size, channel_count);

	printf("start convolution\n");
	for(int i = 0 ; i < 3 ; i ++)
		convolution_channel(temp, filter_in,(arr_out + out_pixel * i) , arr_len, filter_len,out_len, stride, padding,channel_count,i);


	//------------------- merge and file output
	merge_channel(arr_out, file_out,out_size, 3);
	printf("after merge\n");	
	fwrite(&fileHeader, sizeof(BITMAPFILEHEADER), 1, destBmp);
	fwrite(&infoHeader, sizeof(BITMAPINFOHEADER), 1, destBmp);
	printf("write bitmap data\n");
	fwrite(arr_out, out_size, 1, destBmp);

	fclose(fpBmp);
	fclose(destBmp);
	free(filter_in);
	free(data);
	free(temp);
	free(arr_out);
	free(file_out);

	return 0;
	}



void split(unsigned char * src, unsigned char * dest, int size, int count ){

	int  ptr[count];

	int div_size = size/count;

	for(int i = 0; i < count ; i++){
		ptr[i] = i * div_size; 
	}

	for(int i = 0 ; i < size ; i++){
		*(dest + (i/3) +(ptr[i%count])) = *(src +i); 
		//ptr[i%count]++;
	}

}

void merge_channel(unsigned char * src,unsigned char * dest, int size, int count){
	int ptr[count];

	int div_size = size / count;

	for (int i = 0; i < count; i++)
	{
		ptr[i] = i * div_size;
	}

	int k = 0 , j = 0;
	for(int i = 0 ; i <div_size ; i++){
		j = 0;
		while(j<count){
			*(dest + k ) = *(src+i+ptr[j]);
			j++;
			k++;
		}
	}
} 



//print array
void print_array(unsigned char* arr,int h,int w){

	for(int i = 0; i <h;i++){
		for(int j =0 ; j <w;j++){
			printf("%5d ",*(arr+w*i+j));
		}
		printf("\n");
	}
}
//init
void set_arr(unsigned char * arr_in,int arr_len){
	//input init
	printf("array init--------------------------------------------\n\n");
	
	for (int i = 0; i < arr_len; i++)
	{
		for (int j = 0; j < arr_len; j++)
		{
				if(i == j) *(arr_in + arr_len * i + j) = 1;
				else
					*(arr_in + arr_len * i + j) = 0;
		}
	}
	print_array(arr_in, arr_len, arr_len);
}
//init
void set_filter(unsigned char * fil_in,int fil_len){

	printf("filter init--------------------------------------------\n\n");

	for (int i = 0; i < fil_len; i++)
	{
		for (int j = 0; j < fil_len; j++)
		{
			if (i == 1 && j == 1)
				*(fil_in + fil_len * i + j) = 1;
			else
				*(fil_in + fil_len * i + j) = 0;
		}
	}
	print_array(fil_in, fil_len, fil_len);
}


//convolution operating
int depth1_value(int ypos, int xpos, int in_len, int filter_len, unsigned char *arr_in, unsigned char *filter_in, int stride)
{

	//printf("output making\n");

	int temp = 0;
	for(int i = 0 ; i <filter_len ; i++){
		 		for(int j = 0 ; j < filter_len;j++){
					 temp += *(arr_in + ((i+(stride*ypos)) *in_len) + (j+(stride*xpos) )) 
					 		* (*(filter_in + (i *filter_len) +j));
					//  printf("%d 곱", *(arr_in + (stride * (i + ypos) * in_len) + ((stride * j) + xpos)));
					//  printf("%d:", (*(filter_in + (i *filter_len) +j)));
					//  printf("%d  ",temp);
				 }
				 //printf("\n");
				
	}
	//printf("%d\n",temp);
	return temp;
}

void convolution_channel(unsigned char *arr_in, unsigned char *filter_in,unsigned char *arr_out, int in_len, int filter_len,int out_len, int stride, int padding, int channel,int count)
{

	unsigned char * ptr;

	unsigned char * anchor = arr_out;

	 //for(int i = 0 ; i < channel ; i++){
	ptr = (unsigned char *)(arr_in + count * (in_len * in_len));
		
	arr_out = (arr_out + count *(out_len * out_len));
		//printf("size = %d\n", arr_out + i *out_len * out_len);
		//printf("ptr = %d\n", i * (out_len * out_len));
	arr_out = convolution_cal(ptr, filter_in, in_len, filter_len, out_len, stride, padding);
		//printf("address = %ld\n", (unsigned char*)out_ptr - (unsigned char*)anchor);
	//}

	for(int i = 0 ; i < out_len ; i++){
		if (i == 0 && *(arr_out + (out_len * out_len * 2) + i) != *(out_ptr + i))
		{
			printf("%d ", *(arr_out + (out_len * out_len * 2) + i));
			printf("%d\n", *(out_ptr + i));
		}
		else if (*(arr_out + (out_len * out_len * 2) + i ) != *(out_ptr+i)){
			printf("error\n");
		}
	}

}

unsigned char* convolution_cal(unsigned char *arr_in, unsigned char *filter_in, int in_len, int filter_len,int out_len, int stride, int padding)
{

	
	int padded_len = in_len + (padding*2);
	unsigned char * padded_arr = (unsigned char *)calloc(padded_len * padded_len, sizeof(unsigned char));
	//filter_in = (int*)calloc(filter_len*filter_len,sizeof(int));
	
	unsigned char * arr_out = (unsigned char*)calloc(out_len * out_len,sizeof(unsigned char));

	//printf("size = %d\n", out_len * out_len);

	//padding
	//printf("padding init--------------------------------------------\n\n");
	int k = 0;
	for(int i = 0; i < padded_len ; i++){
		for(int j = 0 ; j < padded_len ;j++){
			if (i >= padding && j >= padding && i < (in_len) + padding  && j < (in_len) + padding )
				{
					//copy algritomn
					*(padded_arr + padded_len * i + j) = *(arr_in + ((i-padding)*in_len) + (j-padding));
					k++;
				}
			else {
				*(padded_arr + padded_len * i + j) = 0;
			}
		}
	}
	//printf("padding width = %d\n",padded_len);
	//print_array(padded_arr, padded_len, padded_len);


	//printf("result -----------------------------------------------------\n");
	//add stride 
	for(int i = 0; i < out_len  ;i++){
		for(int j = 0 ; j < out_len ; j++){
			//printf("output index %d %d\n",i,j);
			*(arr_out + out_len * i + j) = depth1_value(i, j, padded_len, filter_len, padded_arr, filter_in, stride);
		}
	}

	//printf("out width = %d\n", out_len);
	//print_array(arr_out,out_len,out_len);
	
	free(padded_arr);

	printf("finish convolution\n");
	return arr_out;
}
