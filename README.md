## Projeto Compiladores

O objetivo do projeto ao final do curso é construir um compilador utilizando uma linguagem baseado na linguagem C.

Um código de entrada padrão utilizado para testes iniciais foi um que recebe um array e faz uma busca sequencial por um número específico.

### Código

#include <stdio.h>

int main(void) {

int i; int tam = 5; int arr[] = {1,7,35,1,9}; int num = 1; int encont = 0;

for(i=0; i<tam; i++) { if(arr[i] == num) { printf("\nNumero encontrado na posicao %d", i+1); encont = 1; } }

if(!encont) printf("Numero nao encontrado!!!");

return 0; }

### Definição da linguagem

A linguagem reconhece tipos inteiros atraves da definição INT e expressões regulares de soma, subtração, divisão e multiplicação representados respectivamente pelos simbolos '+ - * /'. A linguagem define uma arvore ternaria onde a expressão se localiza no No pai e seus filhos são os valores que serão processados pela expressão.


