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

IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*  
OPERADOR_MATEMATICO "="|">"|">="|"<"|"<="|"**"|"+"|"\/"|"*"
NUMBER              [0-9]+
FLOAT               [0-9]+["."][0-9]+
SEPARADORES         "{"|"}"

%%

{IDENTIFICADOR}        {printf("<token, %s>", yytext); contador++;}
{OPERADOR_MATEMATICO}  {printf("<op_mat, %s>", yytext); contador++;}
{NUMBER}               {printf("<numero, %s>", yytext); contador++;}
{SEPARADORES}          {printf("<separador, %s>", yytext); contador++;}
{FLOAT}                {printf("<numero flutuante, %s>", yytext); contador++;}
<<EOF>>                return 0;

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
