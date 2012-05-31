#include<stdio.h>
char *cpuidfunc(void);

main(){
	char *value;
	value = cpuidfunc();	
	printf("The CPUID is: %s\n",value);
}
