#include<stdio.h>

int main(){
	int data1 = 10;
	int data2 = 50;
	int result;

	asm("imull %%edx, %%ecx\n\t"
	    "movl %%ecx, %%eax"
	    :"=a"(result)
	    :"d"(data1), "c"(data2));
	
	printf("The result is %d\n",result);
	return 0;
}
