import java.io.StringReader

object Main {
  def main(args: Array[String]): Unit = {
    val upl = """prepare ingredients; 
    boil 4 cups water; 
    add 2 cups flour; 
    stir; 
    add 1 cups flour; 
    stir; 
    press ugali; 
    turn ugali; 
    cook 8 minutes; 
    check consistency; 
    shape ugali; serve ugali; ?
    """;
    val lexer = new Lexer(new StringReader(upl))
    var t = lexer.yylex()
    while (t != null) {
      if (t == Lexer.Token.ILLEGAL)
        println(s"Lexical error at line ${lexer.line()}, column ${lexer.column()}: illegal character '${lexer.yytext()}'")
      else if (t == Lexer.Token.UNTERMINATED_COMMENT) {
        println(s"Lexical error at line ${lexer.commentStartLine()}, column ${lexer.commentStartColumn()}: unterminated multiline comment")
        return
      }
      else if (t == Lexer.Token.NUMBER) println(s"$t(${lexer.numberValue()})")
      else println(s"$t")
      t = lexer.yylex()
    }
  }
}
