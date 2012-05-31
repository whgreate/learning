#include<stdio.h>
#include<stdlib.h>
#include<signal.h>
#include<sys/types.h>
#include<unistd.h>

void func_ctrlc();
void func_ctrlz();
void func_ctrld(); //不能阻塞

int main(){
	int i;
	sigset_t set, pendset;
	struct sigaction action;
	(void)signal(SIGINT,func_ctrlc);
	(void)signal(SIGTSTP,func_ctrlz);
	(void)signal(SIGQUIT,func_ctrld);
	if(sigemptyset(&set) < 0)
		perror("初始化信号集合错误");

	if(sigaddset(&set, SIGINT) < 0)
		perror("加入信号集合失败");
	if(sigaddset(&set, SIGTSTP) < 0)
		perror("加入信号集合失败");

	if(sigprocmask(SIG_BLOCK, &set, NULL) < 0)
		perror("往信号阻塞集增加一个信号集合失败");
	else{
		for(i=0;i<5;i++){
			printf("显示此文字，表示程序处于阻塞信号状态!\n");
			sleep(2);
		}
	}	
	if(sigprocmask(SIG_UNBLOCK,&set,NULL)<0)
		perror("从信号阻塞集删除一个信号集合错误");
}

void func_ctrlc(){
	printf("\t您按了Ctrl+C系统是不是很长时间没理你？\n");
	printf("\t");
	(void)signal(SIGINT,SIG_DFL);
}

void func_ctrlz(){
	printf("\t您按了Ctrl+Z系统是不是很长时间没理你？\n");
	printf("\t");
	(void)signal(SIGINT,SIG_DFL);
}


void func_ctrld(){
	printf("\t您按了Ctrl+\\系统立即反应");
	printf("\t");
	(void)signal(SIGINT,SIG_DFL);
}
