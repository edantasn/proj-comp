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
calc:
    | calc exp NEWLIN   {printf("%d\n", $2);}
    ;

exp : fator
    | exp ADD fator     {$$ = $1 + $3; }
    | exp SUB fator     {$$ = $1 - $3; }
    ;

termo: NUM
     | OPBAR termo CLOBAR   { $$ = $2; }
     | OPBAR exp CLOBAR     { $$ = $2; }
     ;

fator: termo
     | fator MUL termo      {$$ = $1 * $3; }
     | fator DIV termo      {$$ = $1 / $3; } 
     ;

%%

/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */

int main (int argc, char**agrv){
  yyparser();
  return 0;
}

yyerro(char *s){
  fprintf(stderr, "error: %s\n", s);
}

