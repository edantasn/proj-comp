%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */
#define NUM_FILHOS 3;
#include <stdio.h>
#include <stdlib.h>


typedef struct No {
    char token[50];
    int numFilhos;
    struct No** filhos;
} No;


No* allocar_no();
void liberar_no(void* no);
void imprimir_arvore(No* raiz);
No* novo_no(char[50], No**, int);

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union 
{
    int number;
    char simbolo[50];
    struct No* no;
}
%token NUM
%token ADD
%token SUB
%token MUL
%token DIV
%token APAR
%token FPAR
%token EOL

%type<no> calc
%type<no> termo
%type<no> fator
%type<no> exp

%type<simbolo> NUM
%type<simbolo> MUL
%type<simbolo> DIV
%type<simbolo> SUB
%type<simbolo> ADD


%%
/* Regras de Sintaxe */

calc:
    | calc exp EOL  { imprimir_arvore($2); } 

exp: fator                
   | exp ADD fator  {    
                        No **filhos = (No**) malloc (sizeof(No*)*NUM_FILHOS);
                        filhos[0] = $1; 
                        filhos[1] = novo_no("+", NULL, 0);
                        filhos[2] = $2;

                        $$ = novo_no("exp", filhos, );
        }
   | exp SUB fator{
                    No **filhos = (No**) malloc (sizeof(No*)*3);
                    filhos[0] = $1; 
                    filhos[1] = novo_no("-", NULL, 0);
                    filhos[2] = $2;

                    $$ = novo_no("exp", filhos, );
        }
   ;

fator: termo            
     | fator MUL termo  { 
                        No **filhos = (No**) malloc (sizeof(No*)*NUM_FILHOS);
             filhos[0] = $1; 
             filhos[1] = novo_no("+", NULL, 0);
             filhos[2] = $2;

       $$ = novo_no("fator", filhos, );
    }
     | fator DIV termo  { 
                        No **filhos = (No**) malloc (sizeof(No*)*NUM_FILHOS);
             filhos[0] = $1; 
             filhos[1] = novo_no("/", NULL, 0);
             filhos[2] = $2;
             $$ = novo_no("fator", filhos, );
        }
     ;

termo: NUM{
        $$ = novo_no($1, NULL, NULL); 
    }
     

%%

/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */

No* allocar_no() {
    return (No*) malloc(sizeof(No));
}

void liberar_no(void* no) {
    free(no);
}

No* novo_no(char token[50], No* direita, No* esquerda) {
   No* no = allocar_no();
   snprintf(no->token, 50, "%s", token);
   no->direita = direita;
   no->esquerda = esquerda;

   return no;
}

void imprimir_arvore(No* raiz) {
    
    if(raiz == NULL) { printf("***"); return; }
    printf("(%s)", raiz->token);
    printf("direira>");
    imprimir_arvore(raiz->direita);
    printf("esquerda>");
    imprimir_arvore(raiz->esquerda);

}


int main(int argc, char** argv) {
    yyparse();
}

yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}
