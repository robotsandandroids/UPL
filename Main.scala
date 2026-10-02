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
    val lexer = Lexer(StringReader(upl))
    var t = lexer.yylex()
    while (t != null) {
      if (t == Lexer.Token.ILLEGAL) println(s"ERROR:${lexer.column()}:${lexer.line()} illegal character `${lexer.yytext()}`")
      else if (t == Lexer.Token.NUMBER) println(s"$t(${lexer.yytext()})")
      else println(s"$t")
      t = lexer.yylex()
    }
  }
}
