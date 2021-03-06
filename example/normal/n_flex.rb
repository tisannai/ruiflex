FlexOpt.set( :lineno, true )
FlexOpt.set( :reentrant, false )

Token.new( %q{#[^\n]*},              :comment )
Token.new( %q{{D}+},                 :const )
Token.new( %q{calc},                 :keyword )
Token.new( %q{"+"},                  :longop, "OP_PLUS" )
Token.new( %q{"-"},                  :longop, "OP_MINUS" )
Token.new( %q{"*"},                  :longop, "OP_MULT" )
Token.new( %q{"/"},                  :longop, "OP_DIV" )
Token.new( %q{[ \t\v\n\f]},          :space )
Token.new( nil,                      :unknown )
