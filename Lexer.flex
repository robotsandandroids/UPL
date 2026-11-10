%%

%class Lexer
%type Token
%unicode
%line
%column

%x COMMENT

%{
  public int line()   { return yyline + 1; }
  public int column() { return yycolumn + 1; }

  // Attributes exposed to later compiler phases (part d).
  private int numberValue;
  private String numberText = "";
  public int numberValue()  { return numberValue; }
  public String numberText() { return numberText; }

  // Start position of the current multiline comment (part h).
  private int commentStartLine;
  private int commentStartColumn;
  public int commentStartLine()   { return commentStartLine; }
  public int commentStartColumn() { return commentStartColumn; }

  public enum Token {
      PREPARE, INGREDIENTS, BOIL,
      WATER, ADD, FLOUR,
      STIR, PRESS, TURN,
      COOK, CHECK, CONSISTENCY,
      SHAPE, SERVE, UGALI,
      CUPS, MINUTES, IDENTIFIER,
      NUMBER, SEMICOLON, ILLEGAL,
      UNTERMINATED_COMMENT
  }
%}

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
";"                              { return Token.SEMICOLON; }
[a-zA-Z][a-zA-Z0-9_]*            { return Token.IDENTIFIER; }
[0-9]+                           {
                                     numberText = yytext();
                                     try {
                                       numberValue = Integer.parseInt(numberText);
                                     } catch (NumberFormatException e) {
                                       // Keep the token even if the literal is out of int range.
                                       numberValue = 0;
                                     }
                                     return Token.NUMBER;
                                 }
[ \t\n\r]+                       { /* ignore whitespace */ }
"//"[^\r\n]*                     { /* ignore single-line comment */ }
"/*"                             {
                                     commentStartLine = line();
                                     commentStartColumn = column();
                                     yybegin(COMMENT);
                                 }
.                                { return Token.ILLEGAL; }

<COMMENT> {
  "*/"                           { yybegin(YYINITIAL); }
  [^*]+                          { /* ignore comment body */ }
  "*"                            { /* ignore a lone '*' */ }
  <<EOF>>                        { return Token.UNTERMINATED_COMMENT; }
}
