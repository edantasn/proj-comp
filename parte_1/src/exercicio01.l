/* 
Crie um Analisador Léxico utilizando Flex que consiga gerar os tokens
do arquivo de entrada "exercicio01.in" que consiste em um código na
linguagem C. O analisador deverá identificar todos os tokens referentes a:

1. Identificadores
2. Números Inteiros
3. Números de Ponto Flutuante
4. Palavras reservadas
5. Operadores Matemáticos e Relacionais
6. Chaves, Colchetes e Chaves

utilize os exemplos no diretório "flex" como ponto de partida.
*/

/* SEÇÃO DE DEFINIÇÕES */

%{
    /*
        Definições que estarão disponíveis 
            - variáveis
            - constantes
        O que for aqui será copiado para o arquivo *.yy.c
    
        Variáveis declaradas aqui estarão acessível nas funções yylex() e 
        main().
    */
    int contador = 0;
%}

/* Definições de Nomes */
TIPO				"int"|"float"|"char"|"double"|"unsigned"|"void"
ABERTURA			"\("|"\{"|"["
FECHAMENTO			"\)"|"\}"|"]"
OPERADOR_UNICO			"++"|"--"
OPERADOR_MATEMATICO     "+"|"-"|"/"|[\*]
OPERADOR_ATRIBUICAO		"="|"+="|"-="|"&="|"*="
OPERADOR_RELACIONAL		"<"|">"|"<="|">="|"=="|"!="
CONDICIONAL         "if"|"else"|"switch"
LACO			"while"|"for"|"do"
NUMBER              [0-9]+

PALAVRAREERVADA     "main"|"return"|"print"
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*
FIMCOMANDO          ";"


/* FIM DA SEÇÃO DE DEFINIÇÕES */

%%
    /* SEÇAO DE REGRAS 
        Uma entrada por linha no formato:
        
        padrão  ação

    */
    
{TIPO}               {printf("<tipo, %s>", yytext); contador++;}
{IDENTIFICADOR}        {printf("<identificador, %s>", yytext); contador++;}
{OPERADOR_MATEMATICO}  {printf("<op_mat, %s>", yytext); contador++;}
{NUMBER}               {printf("<numero, %s>", yytext); contador++;}
{PALAVRAREERVADA}      {printf("<palavra, %s>", yytext); contador++;}
{OPERADOR_RELACIONAL}   {printf("<op_Relacao, %s>", yytext); contador++;}
{OPERADOR_ATRIBUICAO}            {printf("<op_atribuicao, %s>", yytext); contador++;}
{ABERTURA}             {printf("<abertura, %s>", yytext); contador++;}
{FECHAMENTO}                {printf("<fechamento, %s>", yytext); contador++;}
{FIMCOMANDO}                {printf("<fim de comando, %s>", yytext); contador++;}
{CONDICIONAL}                {printf("<condicional, %s>", yytext); contador++;}
{LACO}                {printf("<laco, %s>", yytext); contador++;}
    
%%

/*
Seção de Código do Usuário
*/

int yywrap() {}
int main() {
    printf("Iniciando Análise Léxica...\n---\n");
    yylex();
    printf("Foram encontradas %d ocorrências de identificadores.\n", contador);
    printf("---\nÁnalise Finalizada!\n");
    
    return 0;
}
