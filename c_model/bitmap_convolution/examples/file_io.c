#include <stdio.h>

int main(){

	int arr[2][3][3];

	FILE *fp  = fopen("array.dat","rt");
	FILE *fp2 = fopen("save.dat","wt");



	int temp;
	int i = 0;
	 while(fscanf(fp,"%d",&temp) != EOF){
	 	*(&arr[0][0][0]+i) = temp;	
		fprintf(fp2,"%d ",temp);
		printf("%d\n",temp);
		i++;
	}

	for(int j = 0 ; j < i ; j++)
		printf("%d\n",*(&arr[0][0][0]+j));


	fclose(fp);	
	fclose(fp2);

	return 0;
}
