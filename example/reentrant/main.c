#include <stdio.h>
#include "n_flex.h"

int main( int argc, char** argv )
{
  yyscan_t scan;

  FILE* fh;
  int token;
  int curline = 1;

  fh = fopen( "../data/input.txt", "r" );

  yylex_init( &scan );
  yyset_in( fh, scan );


  while ( 1 )
    {
      token = yylex( scan );

      if ( token == TOK_EOF )
        /* End-of-file condition. */
        break;

      curline = yyget_lineno( scan );

      /* Fix line number at newline token. */
      if ( token == TOK_NEWLINE )
        curline = curline - 1;

      if ( token != TOK_NEWLINE )
        printf( "Got token on line %d: id %-20s text \"%s\"\n",
              curline,
              ruiflex_token_id( token ),
              yyget_text( scan )
              );
      else
        printf( "Got token on line %d: id %-20s text \"\\n\"\n",
              curline,
              ruiflex_token_id( token )
              );

    }

  yylex_destroy( scan );

  return 0;
}
