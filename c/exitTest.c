#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>

int main(){
	pid_t result ;
	result = fork();
	if(result == 0)  //child 
	{
		printf("测试终止进程_exit函数！\n");
		printf("这是子进程!");   //won't print
		_exit(0);
	}
	else if(result > 0){
		printf("测试终止进程exit函数！\n");
		printf("这是父进程!");
		exit(0);
	}
}
