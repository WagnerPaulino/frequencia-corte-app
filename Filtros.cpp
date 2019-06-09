#include <stdlib.h>
#include <stdio.h>
#include <locale.h>
#include <math.h>
int escolha,n,e;
float fc,r1,r2,c1,c2;

int escolhas()
{
	    
	    
		printf("\n1- Frequencia de corte");
		printf("\n2- Resistor");
		printf("\n3- Capacitor");
		printf("\n\nEscolha uma opcao:");
		scanf("%i",&e);
		return(e);
		
}

void alta()
{
	    do
		escolha=escolhas();
	    while(escolha<1 || escolha >3);
	    
		if(escolha==1){
			printf("\nValor do resistor1:");
			scanf("%f",&r1);
			printf("\nValor do resistor2:");
			scanf("%f",&r2);
			printf("\nValor do capacitor:");
			scanf("%f",&c1);
			fc=1/(2*M_PI*c1*sqrt(r1*r2));
		
			printf("Frequencia de Corte: %g  \n\n",fc);
			}else
			if(escolha==2){	
			printf("\nValor da frequencia de corte:");
			scanf("%f",&fc);
			printf("\nValor do capacitor:");
			scanf("%f",&c1);
			r1=1/(2*M_PI*c1*fc*sqrt(2));

			printf("Resistor1: %g  e Resistor2: %g \n\n",r1,1.9994*r1);
			}else
			if(escolha==3){
			printf("\nValor da frequencia de corte:");
			scanf("%f",&fc);
			printf("\nValor do resistor1:");
			scanf("%f",&r1);
			printf("\nValor do resistor2:");
			scanf("%f",&r2);  
			
			c1=1/(2*M_PI*fc*sqrt(r1*r2));

			printf("Capacitor: %g  \n\n",c1);
			}
}

void baixa()
{
        do
		escolha=escolhas();
	    while(escolha<1 || escolha >3);
	    
		if(escolha==1){
			printf("\nValor do capacitor1:");
			scanf("%f",&c1);
			printf("\nValor do capacitor2:");
			scanf("%f",&c2);
			printf("\nValor do resistor:");
			scanf("%f",&r1);
			fc=1/(2*M_PI*r1*sqrt(c1*c2));
		
			printf("Frequencia de Corte: %g \n\n",fc);
			}else
			if(escolha==2){	
			printf("\nValor da frequencia de corte:");
			scanf("%f",&fc);
			printf("\nValor do resistor:");
			scanf("%f",&r1);
			c1=1/(2*M_PI*r1*fc*sqrt(2));
			printf("Capacitor1: %g  e Capacitor2: %g \n\n",c1,1.9994*c1);
			}else
			if(escolha==3){
			printf("\nValor da frequencia de corte:");
			scanf("%f",&fc);
			printf("\nValor do Capacitor1:");
			scanf("%f",&c1);
			printf("\nValor do Capacitor2:");
			scanf("%f",&c2);  
			
			r1=1/(2*M_PI*fc*sqrt(c1*c2));

			printf("resistor: %g  \n\n",r1);
			}	
}

void ampganho()
{
	float rg,ganho;
	int b;
	
	 do{
	    
		printf("\n1- Ganho");
		printf("\n2- Resistor(Rg)");
		printf("\n\nEscolha uma opcao:");
		scanf("%i",&b);
	 }while(b<1||b>2);
	 
	 
	 if(b==1)
	 {
	 	printf("Valor do Resistor(Rg):");
	 	scanf("%f",&rg);
	    ganho=(49400/rg)+1;
	    
	    printf("\nValor do Ganho: %f  \n\n",ganho);
	 }else
	 if(b==2)
	 {
	 	printf("Valor do Ganho desejado:");
	 	scanf("%f",&ganho);
	    rg=49400/(ganho-1);
	    
	    printf("\nValor do resistor(Rg): %f  \n\n",rg);
	 }
}

main()
{
	setlocale(LC_ALL,"Portuguese");
	
	do{
	
	printf("\n1 - Passa-Alta ");
	printf("\n2 - Passa-Baixa");
	printf("\n3 - Amplificacao");
	printf("\n\nEscolha uma opcao:");
	scanf("%d",&n);
	}while(n<1 || n>3);
	
	if(n==1)
	alta();
	else
	if(n==2)
	baixa();
	else
	if(n==3)
	ampganho();
    
}