FlexOpt.set( :lineno, true )
FlexOpt.set( :reentrant, true )
FlexOpt.add( :flexopt, "extra-type=\"int*\"" )
FlexOpt.set( :l_header, "\n\n/* My Lexer Header Comment. */\n\n" )
FlexOpt.set( :l_footer, "\n\n/* My Lexer Footer Comment. */\n\n" )
FlexOpt.set( :h_header, "\n\n/* My C Header Comment. */\n\n" )
FlexOpt.set( :h_footer, "\n\n/* My C Footer Comment. */\n\n" )

Token.new( %q{#[^\n]*[\n]},          :comment ).ignore
Token.new( %q{{D}+},                 :const )
Token.new( %q{calc},                 :keyword )
Token.new( %q{"+"},                  :longop, "OP_PLUS" )
Token.new( %q{"-"},                  :longop, "OP_MINUS" )
Token.new( %q{"*"},                  :longop, "OP_MULT" )
Token.new( %q{"/"},                  :longop, "OP_DIV" )
Token.new( %q{"\\."},                :punct, "DOT" )
Token.new( %q{[ \t\v\f]},            :space ).action( "/* Skip space */" )
Token.new( %q{[\n]},                 :custom, "NEWLINE" )
Token.new( %q{.},                    :error ) do
    action( "printf( \"Input error, exiting!\\n\" ); exit( EXIT_FAILURE );" )
end
