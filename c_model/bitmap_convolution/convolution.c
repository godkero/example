//
//  main.c
//  convolution.c
//
//  Created by 이학원 on 2021/07/08.
//

#include <stdio.h>
#include <stdlib.h>

void init_4d(int *arr, FILE *fp, int len_4d, int len_3d, int len_2d, int len_1d);
void init_3d(int *arr, FILE *fp, int len_3d, int len_2d, int len_1d,int index);
void print_array_4d(int *arr, int len_4d, int len_3d, int len_2d, int len_1d, char *str, int index);
void print_array_3d(int *arr, int len_3d, int len_2d, int len_1d, char *str, int index);
void convolution(int *data, int *kernel, int *out, int kernel_count, int channel, int d_w, int d_h, int k_w, int k_h);

int main()
{

    FILE *fp;

    fp = fopen("./test", "rb");
    
    
    //parameters
    int channel = 3;
    int d_w = 10;
    int d_h = 10;
    int k_w = 4;
    int k_h = 4;

    int kernel_vol = 3;
    int index = 0;
    int o_w = d_w - k_w + 1;
    int o_h = d_h - k_w + 1;
    int d_size = d_w * d_h;
    int k_size = k_w * k_h;
    int o_size = o_w * o_h;
    int tot_d_size = d_size * channel;
    int tot_o_size = o_size * kernel_vol;
    int tot_k_size = k_size * kernel_vol * channel;
    

    printf("d_size = %d\n", d_size);
    printf("k_size = %d\n", k_size);
    printf("o_size = %d\n", o_size);
    printf("tot_o_size = %d\n", tot_o_size);
    printf("tot_k_size  = %d\n", tot_k_size);

    int *data = (int *)malloc(tot_d_size * sizeof(int));
    int *out = (int *)malloc(tot_o_size * sizeof(int));
    int *kernel = (int *)malloc(tot_k_size * sizeof(int));

    printf("data size = %d\n", d_size * sizeof(int));
    printf("out size = %d\n", tot_o_size * sizeof(int));
    printf("kernel size = %d\n", tot_k_size * sizeof(int));

    int ker, i, j, k;
    
    init_3d(data,fp,channel,d_h,d_w,0);             //input init
    init_4d(kernel,fp,kernel_vol,channel,k_h,k_w);  //kernel init
    
    for (int ker = 0; ker < kernel_vol; ker++)
    {
        for (int i = 0; i < o_h; i++)
        {
            for (int j = 0; j < o_w; j++)
            {
                *(out + (index++)) = 0;
            }
        }
    }

    print_array_3d(data, channel, d_h, d_w, "input data\n",0);
    print_array_4d(kernel, kernel_vol,channel, k_h, k_w, "kernel value\n",0);
    print_array_3d(out, kernel_vol, o_h, o_w,"init_out\n",0);

    //input 주소 , 채널 , 가로, 세로 크기
    //kernel 주소,채널,가로,세로 크기

    convolution(data, kernel, out, kernel_vol, channel, d_h, d_w, k_h, k_w);

    print_array_3d(out,kernel_vol,o_h,o_w,"result\n",0);

    return 0;
}

void convolution(int *data, int *kernel, int *out, int kernel_count, int channel, int d_w, int d_h, int k_w, int k_h)
{

    int d_size = d_w * d_h;
    int k_size = k_w * k_h;

    int o_w = (d_w - k_w) + 1;
    int o_h = (d_h - k_h) + 1;
    int o_size = o_w * o_h;

    printf("d_size = %d\n", d_size);
    printf("k_size = %d\n", k_size);
    printf("o_w = %d\n", o_w);
    printf("o_h = %d\n", o_h);
    printf("kernel_count = %d\n", kernel_count);
    printf("o_size = %d\n", o_size);

    for (int ker = 0; ker < kernel_count; ker++)
    {
        printf("----------------------------\n");
        for (int i = 0; i < o_h; i++)
        {
            for (int j = 0; j < o_w; j++)
            {
                for (int k = 0; k < channel; k++)
                {
                    //each element
                    for (int m = 0; m < k_h; m++)
                    {
                        for (int n = 0; n < k_w; n++)
                        {
                            int o_index = (ker * o_size) + (o_w * i) + (j);
                            int d_index = (k * d_size) + ((i + m) * d_w) + (j + n);
                            int k_index = (ker * 3 * k_size) + (k * k_size) + (m * k_w) + n;
                            *(out + o_index) += (data[d_index] * kernel[k_index]);

                            //printf("%d ",data[d_index]);
                        }
                        //printf("\n");
                    }
                    //printf("\n");
                }
            }
        }
    }
}

void print_array_4d(int *arr, int len_4d,int len_3d, int len_2d, int len_1d, char *str,int index){
    printf("%s", str);
    
    int sub_size = len_3d * len_2d * len_1d;

    for(int i = 0; i<len_4d;i++){
        print_array_3d(arr,len_3d,len_2d,len_1d,"",i*sub_size);
    }


}

void print_array_3d(int *arr, int len_3d, int len_2d, int len_1d, char *str, int index)
{
    printf("%s\n",str);
    for(int i = 0 ; i < len_3d ;i++){
        for(int j = 0 ; j < len_2d ;j++){
            for(int k = 0 ; k < len_1d ; k++){
                printf("%d ", arr[index++]);
            }
            printf("\n");
        }
        printf("\n");
    }
}

void init_3d(int *arr,FILE *fp, int len_3d,int len_2d,int len_1d,int index){
    
    for (int i = 0; i < len_3d; i++)
    {
        for (int j = 0; j < len_2d; j++)
        {
            for (int k = 0; k < len_1d; k++)
            {
                fscanf(fp, "%d", &arr[index++]); //(data + i * 10*10 + j*10 + k));
            }
        }
    }
}

void init_4d(int *arr,FILE *fp,int len_4d,int len_3d,int len_2d,int len_1d){
    int index = 0;
    int sub_size = len_3d * len_2d * len_1d;
    for (int i = 0; i < len_4d; i++)
    {
        init_3d(arr,fp,len_3d,len_2d,len_1d,i*sub_size);
    }
}