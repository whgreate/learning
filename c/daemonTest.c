#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>
#include<stdlib.h>
#include<sys/stat.h>
#include<sys/param.h>
#include<time.h>


void init_daemon(void);
int main(){
	FILE *fp;
	time_t t;
	init_daemon();
	while(1){
		sleep(10);
		if((fp = fopen("daemon.log","a+"))>=0){
			t = time(0);
			fprintf(fp, "守护进程还在运行，时间是:%s",asctime(localtime(&t)));
			fclose(fp);
		}
	}
}

void init_daemon(void){
	pid_t child1, child2;
	int i;

	child1 = fork();
	if(child1 > 0)   /*(1)创建子进程，终止父进程*/
		exit(0);
	if(child1 < 0){
		perror("");
		exit(1);
	}
	setsid();	/*(2)在子进程中创建新会话，摆脱原会话、组、shell*/
		/*调用此函数的进程不能是进程组的组长进程，因此先fork*/
	chdir("/tmp");	/*(3)改变工作目录*/
	umask(0);	/*(4)重建文件创建掩码*/
	for(i=0;i<NOFILE;++i)	/*(5)关闭文件描述符,NOFILE=256*/
		close(i);
	return;
}
