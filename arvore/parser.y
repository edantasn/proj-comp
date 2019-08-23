%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct No {
    char *token; //strdup
    int numFilhos;
    struct No** folhas;
} No;

No* allocar_no();
void liberar_no(No * no);
void imprimir_arvore(No* raiz);
No* novo_no(char *, int, No**);
No * criaRamo(char *operador, char *label, No *op1, No *op2);

int yylex();
int yyerror(char *s);

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union {
    int number;
    char simbolo[50];
    struct No* no;
}

%token NUM ADD SUB MUL DIV APAR FPAR EOL IF

%type<no> calc termo fator exp
%type<simbolo> NUM MUL DIV SUB ADD

%%
/* Regras de Sintaxe */

calc:
    | calc exp EOL       { imprimir_arvore($2); } 

exp: fator                
   | exp ADD fator       { $$ = criaRamo("+", "exp", $1, $3); }
   | exp SUB fator       { $$ = criaRamo("-", "exp", $1, $3); }
   ;

fator: termo            
     | fator MUL termo  { $$ = criaRamo("*", "exp", $1, $3); }
     | fator DIV termo  { $$ = criaRamo("/", "exp", $1, $3); }
     ;

termo: NUM{
        $$ = novo_no($1, NULL, NULL); 
    }
     

%%

No* allocar_no(int numFilhos) {
    return (No*) malloc(sizeof(No) * numFilhos);
}

void liberar_no(No * no) {
    free(no);
}

No* novo_no(char token[50], int numFilhos, No** folhas) {
   No* no = allocar_no(3);

   no->token = strdup(token);
   no->numFilhos = numFilhos;
   no->folhas = folhas;

   return no;
}

void imprimir_arvore(No* raiz) {
    int cont;
    int numFilhos = raiz->numFilhos;

    if(raiz == NULL) { printf("***"); return; }

    printf("(%s)", raiz->token);

    if(raiz->folhas != NULL){
        printf("=>\t");
        for(cont = 0; cont < numFilhos; cont++){
            imprimir_arvore(raiz->folhas[cont]);
        }
        printf("(folha)\n");
    }else{
        printf(" < > ");
    }
}

No * criaRamo(char *operador, char *label, No *op1, No *op2){
    No** folhas = (No**) malloc(sizeof(No*) * 3);

    folhas[0] = op1;
    folhas[1] = novo_no(operador, NULL, 0);
    folhas[2] = op2;

    return novo_no(label, folhas, 3);
}

int yyerror(char *s) {
    fprintf(stderr, "erro na linha: %s\n", s);
    return 0;
}

int main(int argc, char** argv) {
    yyparse();
}