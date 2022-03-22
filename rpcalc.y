// Calculadora de notacion polaca inversa.


// DECLARACIONES DE C
%{ 

#define YYSTYPE double                      // Tipo de dato de las variables.
#include <math.h>                           // Funciones matematicas.
#include <ctype.h>                          // Funciones de caracteres.
#include <stdio.h>                          // Funciones de entrada y salida.

%} 

// DECLARACIONES DE YACC/BISO

%token NUM                                  // Numero.

// REGLAS DE GRAMATICA
%%  


input:                                      // reglas de entrad
                                            // entrada vacia
| input line                                // entrada de line
;                                           // fin de entrad


line:                                       // Reglas de line
'\n'                                        // token caracter de nueva-lıne
| exp '\n' { printf ("\t%.10g\n", $1); }    // expresion seguida de una lınea nueva imprime el resultad
;                                           // fin de linea de entrad

exp:                                        // Reglas de expresione
NUM { $$ = $1; } ;                          // numer
| exp exp '+' { $$ = $1 + $2; }             // sum
| exp exp '-' { $$ = $1 - $2; }             // rest
| exp exp '*' { $$ = $1 * $2; }             // multiplicacio
| exp exp '/' { $$ = $1 / $2; }             // divisio
| exp exp '^' { $$ = pow ($1, $2); }        // potenci
| exp 'n' { $$ = -$1; }                     // negativ
;                                           // fin de expresio


%% // CODIGO 



int yylex ()
{
    int c;

    // ignora los espacios en blanco
    while ((c = getchar ()) == ' ' || c == '\t')
    ;

    // procesa numeros
    if (c == '.' || isdigit (c))
    {
        ungetc (c, stdin);
        scanf ("%lf", &yylval);
        return NUM;
     }

     // devuelve fin-de-fichero
     if (c == EOF)
         return 0;
    
     // devuelve caracteres sencillos
     return c;
 }

 int main ()
{
    yyparse ();

    return 0;
}

 yyerror (s) // Llamada por yyparse ante un error

 char *s;
 {
     printf ("%s\n", s);
 }


