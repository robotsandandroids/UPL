%%

%class Lexer
%type Token
%unicode
%line
%column

%{
  public int line()   { return yyline + 1; }
  public int column() { return yycolumn + 1; }
  public enum Token {
      PREPARE, INGREDIENTS, BOIL,
      WATER, ADD, FLOUR,
      STIR, PRESS, TURN,
      COOK, CHECK, CONSISTENCY,
      SHAPE, SERVE, UGALI,
      CUPS, MINUTES, IDENTIFIER,
      NUMBER, SEMICOLON, ILLEGAL
  }
%}%

%%
"prepare"                        { return Token.PREPARE; }
"ingredients"                    { return Token.INGREDIENTS; }
"boil"                           { return Token.BOIL; } 
"water"                          { return Token.WATER; } 
"add"                            { return Token.ADD; } 
"flour"                          { return Token.FLOUR; }
"stir"                           { return Token.STIR; }
"press"                          { return Token.PRESS; }
"turn"                           { return Token.TURN; }
"cook"                           { return Token.COOK; }
"check"                          { return Token.CHECK; }
"consistency"                    { return Token.CONSISTENCY; }
"shape"                          { return Token.SHAPE; }
"serve"                          { return Token.SERVE; }
"ugali"                          { return Token.UGALI; }
"cups"                           { return Token.CUPS; }
"minutes"                        { return Token.MINUTES; }
";"                              { return Token.SEMICOLON;}
[a-zA-Z_][a-zA-Z0-9_]*           { return Token.IDENTIFIER; }
[0-9]+                           { return Token.NUMBER; }
[ \t\n\r]+                       { /* ignore whitespace */ }
"//"[^\r\n]*                     { /* ignore single-line comment */ }
.                                { return Token.ILLEGAL; }
