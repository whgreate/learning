#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<unistd.h>
#include<pthread.h>

pthread_t ntid;

void printids(const char *s){
	pid_t pid;
	pthread_t tid;
	pid = getpid();
	tid = pthread_self();
	printf("%s pid = %u, tid = %u(0x%x)\n",s,(unsigned int)pid,(unsigned int)tid, (unsigned int)tid);
	}

void *thread_fun(void *arg){
	printids(arg);
	return NULL;
}

int main(void){
	int err;
	err = pthread_create(&ntid,NULL,thread_fun,"我是新线程");
	if(err) {
		fprintf(stderr, "创建线程失败:%s\n",strerror(err));
		exit(1);	
	}
	printids("我是父进程:");
	sleep(2);
	return 0;
}
