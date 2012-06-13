#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<pthread.h>

pthread_mutex_t mutex ; /*定义互斥锁*/
int var;

void pthread1(void *arg);
void pthread2(void *arg);

int main(int argc,char* argv[]){
	pthread_t id1, id2;
	int ret;
	pthread_mutex_init(&mutex, NULL);
	
	ret = pthread_create(&id1, NULL, (void*)&pthread1, NULL);
	if(ret)	printf("pthread1 create failed");
	
	ret = pthread_create(&id2, NULL, (void*)&pthread2, NULL);
	if(ret)	printf("pthread2 create failed");
	
	pthread_join(id1, NULL);
	pthread_join(id2, NULL);
	
	pthread_mutex_destroy(&mutex);

	exit(0);
}

void pthread1(void *arg){
	int i=0;
	for(i=0;i<2;i++){
		pthread_mutex_lock(&mutex);
		var ++;
		printf("pthread1:第%d次循环，第1次打印var=%d\n",i,var);
		sleep(1);
		printf("pthread1:第%d次循环，第2次打印var=%d\n",i,var);
		pthread_mutex_unlock(&mutex);
		sleep(1);
	}
}
void pthread2(void *arg){
	int i=0;
	for(i=0;i<5;i++){
		pthread_mutex_lock(&mutex);
		sleep(1);
		var ++;
		printf("pthread2:第%d次循环，第1次打印var=%d\n",i,var);
		sleep(1);
		printf("pthread2:第%d次循环，第2次打印var=%d\n",i,var);
		pthread_mutex_unlock(&mutex);
		sleep(1);
	}
}


		
	
