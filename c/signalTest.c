#include<stdio.h>
#include<signal.h>
#include<stdlib.h>
#include<unistd.h>

void func_ctrlc();

int main(){
	(void)signal(SIGINT, func_ctrlc);
	printf("主程序进入无线循环，按ctrl+c暂停\n");
	while(1){
		printf("这是一个循环体....\n");
		sleep(3);
	}
	
	exit(0);
}

void func_ctrlc(){
	printf("您按了Ctrl+C哦：）\n");
	printf("\t此例不处理，重新恢复对SIGINT信号的默认处理。\n");
	(void)signal(SIGINT, SIG_DFL);
}
