#include <stdio.h>
#include "n_flex.h"

int main( int argc, char** argv )
{
  FILE* fh;
  int token;

  fh = fopen( "../data/input.txt", "r" );
  yyin = fh;

  while ( 1 )
    {
      token = yylex();

      if ( token == TOK_EOF )
        /* End-of-file condition. */
        break;

      printf( "Got token on line %d: id %-20s text \"%s\"\n",
              yylineno,
              ruiflex_token_id( token ),
              yytext );

    }

  return 0;
}
