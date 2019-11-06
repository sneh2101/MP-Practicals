#include<stdio.h>
#include<conio.h>
void main()
{
	int i,temp,len,num,sum,avg,arr[10];   
	clrscr();    //clear screen is always after declaring the variables
	len =10;
	sum=0;
	for(i=0; i<len; i++)
	{
		printf("Enter Element: ");
		scanf("%d",&arr[i]);
	}
	i = 0;
	asm mov ch,00h
	asm mov cl,0ah // question will be for 10 numbers
	labelloop:
		temp =arr[i];
		asm mov bx,temp
		asm add sum,bx
		i++;
		asm loop labelloop  // I am not sure if asm commands need semi-colons, check that 

	
	avg = sum/len; 
	printf("Average is: %d", avg);
	getch();   // dont forget getch
}