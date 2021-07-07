#include <stdio.h>

int op[9][2] = {{-1,-1},{0,-1},{1,-1},{-1,0},{0,0},{1,0},{-1,1},{0,1},{1,1}};

void print_array(int* arr,int h,int w);
int depth1_value(int ypos,int xpos, int in_len, int* arr_in,int * filter_in);
void convolution_cal(int * arr_in, int* filter_in,int*arr_out,int in_len,int filter_len,int out_len,int stride,int padding);

int main(){


	int * arr_in;
	int * filter_in;
	int * arr_out;

	
	



	int stride = 1;

	printf("start\n");

	convolution_cal(arr_in,filter_in,arr_out,10,3,8,1);

	return 0;
	}



//print array
void print_array(int* arr,int h,int w){

	for(int i = 0; i <h;i++){
		for(int j =0 ; j <w;j++){
			printf("%5d ",*(arr+w*i+j));
		}
		printf("\n");
	}
}



//convolution operating
int depth1_value(int ypos,int xpos, int in_len, int* arr_in,int * filter_in){


	//printf("output making\n");
	
	int temp = 0;
	for(int i = 0 ; i < 9 ;i++){
		temp += *(arr_in + ((ypos+op[i][1]) *in_len) +(xpos +op[i][0])) * (*(filter_in + 4  + op[i][1] *3 +op[i][0]) ); 
		
	}

	return temp;

}





void convolution_cal(int * arr_in,int* filter_in,int*arr_out,int in_len,int filter_len,int out_len,int stride,int padding){

	arr_in = (int*)calloc(in_len*in_len,sizeof(int));
	filter_in = (int*)calloc(filter_len*filter_len,sizeof(int));
	arr_out = (int*)calloc(out_len*out_len,sizeof(int));



	//input init
	printf("array init--------------------------------------------\n\n");
	for(int i = 0; i < in_len ; i++){
		for(int j = 0 ; j < in_len ;j++){
			*(arr_in + in_len * i + j) = (i * in_len) + j;
		}
	}

	print_array(arr_in,in_len,in_len);
i	printf("filter init---------------------------------------------\n\n");
	//filter init
	for(int i = 0; i < filter_len ; i++){
		for(int j = 0 ; j < filter_len ;j++){
			if(j == 0 )
				*(filter_in + (filter_len * i) + j) = 1; 
			else if(j == 1 )
				*(filter_in + (filter_len * i) + j) = 0; 
			else if(j == 2 )
				*(filter_in + (filter_len * i) + j) = -1;
				}
		}

	print_array(filter_in,filter_len,filter_len);


	printf("---------------------------------------------------------\n");
	//add stride 
	for(int i = 0; i < out_len  ;i = i + stride){
		for(int j = 0 ; j < out_len ; j = j +stride){
			
			*(arr_out + out_len * i + j) = depth1_value(i+1,j+1,in_len,arr_in,filter_in); 	
		}
	}

	print_array(arr_out,out_len,out_len);


	free(arr_in);
	free(filter_in);
	free(arr_out);

	printf("finish con\n");
	return ;
}
