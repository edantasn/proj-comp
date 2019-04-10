%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */

#include <stdio.h>

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */

%token NUM
%token ADD
%token MUL
%token DIV
%token SUB
%token OPBAR
%token CLOBAR
%token NEWLIN

%%
/* Regras de Sintaxe */
termo: NUM
     | OPBAR termo CLOBAR
     | OPBAR exp CLOBAR


%%

/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */
