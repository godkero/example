#include <stdio.h>
#include <stdlib.h>


int* convolution(int * data,int *kernel, int channel,int d_w,int d_h,int k_w, int k_h );

int main(int args,char*argv[]){

    FILE *fp;

    fp = fopen("test","rb");


    int * data = (int *)calloc(100,sizeof(int));

    for(int i = 0 ; i < 3 ; i++){
        for(int j = 0 ; j < 10 ; j++){
            for(int k = 0 ; k < 10 ; k++){
                fscanf(fp, "%d", (data + i * 10*10 + j*10 + k));
            }
        }
    }

    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            for (int k = 0; k < 10; k++)
            {
                printf("%d ", *(data + i * 10*10 + j*10 + k));
            }
            printf("\n");
        }
        printf("\n");
    }

    int *kernel = (int *)calloc(9, sizeof(int));

    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            for (int k = 0; k < 3; k++)
            {
                fscanf(fp, "%d", (kernel + i * 3 * 3 + j * 3 + k));
            }
        }
    }

    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            for (int k = 0; k < 3; k++)
            {
                //printf("%d", *(kernel + i * 3 * 3 + j * 3 + k));
                //printf("%d--- ", (kernel + (i * 3 * 3) + (j * 3) + k));
                printf("%d ", *(kernel + (i * 3 * 3) + (j * 3) + k));
            }
            printf("\n");
        }
        printf("\n");
    }

    //input 주소 , 채널 , 가로, 세로 크기
    //kernel 주소,채널,가로,세로 크기
    int* out = convolution(data,kernel,3,10,10,3,3);
       

       for(int i = 0 ; i < 8 ; i++){
           for(int j = 0; j < 8 ; j++){
               printf("%d ",*(out + (i * 8) + j));
           }
           printf("\n");
       }

        return 0;
    }

int* convolution(int * data,int *kernel, int channel,int d_w,int d_h,int k_w, int k_h ){

    int d_size = d_w * d_h ;
    int k_size = k_w * k_h ;

    int o_w = (d_w - k_w) + 1 ;
    int o_h = (d_h - k_h) + 1 ;
    int o_size = o_w * o_h ; 

    int *out = (int *) calloc(o_h*o_w,sizeof(int));

    for(int i = 0 ; i < channel ; i++){
        printf("----------------------------\n");
        
        
        for (int j = 0; j < o_h; j++){
            for (int k = 0; k < o_w; k++)
            {
                    //each element
                    for (int m = 0; m < k_h; m++)
                {
                        for(int n = 0 ; n <k_w;n++){
                        *(out + (o_w * j) + (k)) += (*(data + (i * d_size) + ((j+m) * d_w) + (k+n) )) * 
                                                         (*(kernel + (i * k_size) + (m * k_w) + n));
                        printf("%d---", (kernel + (i * k_size) + (m * k_w) + n));
                        printf("%d ", *(kernel + (i * k_size) + (m * k_w) + n));
                    }
                    printf("\n");
                }
            }
            printf("\n");
        }
    }


    

    return out;
}

