# RuiFlex - Gnu Flex front-end using Ruby

RuiFlex is a light abstraction over Flex. It tries to make the typical
Flex usage really simple and quick. User creates a RuiFlex control
file, which includes Ruby commands that create lexer token
descriptions. There is possibility for some Flex configuration as
well. RuiFlex generates, based on the control file, a Flex input file
(`*.l`) and a corresponding C header file (`*.h`), where token has
symbolic C names (i.e. defines).


## Control file

Control file includes mainly token descriptions. For example:

    Token.new( %q{calc},                 :keyword )
    Token.new( %q{"+"},                  :longop, "OP_PLUS" )
    Token.new( %q{[ \t\v\f]},            :space ).action( "/* Skip space */" )


The first description creates a lexer entry which matches to regexp
`calc` and returns a C define value `TOK_KEY_CALC`, i.e. token
id. Token id values are greater than 300, so they don't get mixed with
ASCII values, e.g. if some characters are used literally.

The regexp is a string using Ruby single quoting rules in order to
make the special char handling as easy as possible. You can use
whatever is good for the particular entry, since in the end it is just
a Ruby String and passed to Flex as is.

The second description creates a lexer entry which matches an operator
(`+`), and returns a C define value `TOK_OP_PLUS`.

The third is for eating white space (excluding newlines). The default
action, which is to return the token id, is skipped, and the lexer
will continue with further characters after `:space`.

In `*.l` file these look like:

    "calc"                         { return TOK_KEY_CALC; }
    "+"                            { return TOK_OP_PLUS; }
    [ \t\v\f]                      { /* Skip space */ }


The second argument for `Token.new` is a token class, which defines
its behavior. Keywords are unique, so the token id can be directly
constructed from the regexp.

For the operator we want to specify the token id explicitly.

For the complete list of token classes, run:

    shell> ruiflex -d


Flex options are set with `FlexOpt.set` commands:

    FlexOpt.set( :reentrant, true )


This will set the `%option reentrant` option for Flex. There is also
`:lineno`, and literal `:flexopt` which is a list of custom entries to
`%option`.

You can add your own code to `*.l` header (with `:l_header`), and to
`*.l` footer (with `:l_footer`). Likewise you can add own code to
`*.h` C file (with `:h_header`) and to footer (with `:h_footer`).

For example:

    FlexOpt.set( :l_header, "\n#include <my_defs.h>\n" )


See `example` directory and `README.md` for two simple examples.


## Flex file

The generated Flex file (`*.l`) includes all set options and token
descriptions. Additionally it includes generated C code which can be
used to get information about the used tokens at runtime.

Some convenient character classes are defined in the top of the file.

User have access to `ruiflex_token_desc` function, which returns a
string describing the token class.

There is also function `ruiflex_token_id`, which returns token id in
text format (as string).

These token info functions are useful in parser error reporting.


## Header file

The generated C header file (`*.h`) includes prototypes of used Flex
API functions, and all the token id defines. There is also prototypes
for token info functions.


## Code generation

RuiFlex assumes that it can use the basename of the control file for
generating the other files.

For example if control file is `my_tokens.rb`, the files
`my_tokens.l`, `my_tokens.h` will be created, and optionally also
`my_tokens.c` is created, if `ruiflex` is run with `-t` command line
option.


## Disclaimer

RuiFlex intents to target the very basic Flex usage. If you need
something fancy, you can suggest a new feature, or you can just tweak
the `ruiflex` command on your own.
