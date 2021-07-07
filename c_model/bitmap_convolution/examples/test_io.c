
#include<stdio.h>

int main(){

	FILE *fp_from = fopen("test.dat","rt");
	
	FILE *fp_to = fopen("test_save.dat","wt");

	if(fp_from == NULL || fp_to == NULL){
		printf("error\n");
		fclose(fp_to);
		fclose(fp_from);
		return 0;
		}

	int a;
	float b;
	char c [20];


	fscanf(fp_from,"%s %d %f ",c,&a,&b);

	if(fprintf(fp_to,"%s\n%d\n%f",c,a,b) == EOF){
		printf("EOF error\n");
		fclose(fp_to);
		fclose(fp_from);
		return 0;
		}


	printf("%s\n",c);
	printf("%d\n",a);
	printf("%lf\n",b);
	




	fclose(fp_from);
	fclose(fp_to);

	return 0;
	}
