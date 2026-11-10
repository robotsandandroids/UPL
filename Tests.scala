import java.io.StringReader

/** Runs the scanner against every input used in parts (d), (e), (f), (g) and (h). */
object Tests {
  private def scan(name: String, input: String): Unit = {
    println(s"--- $name ---")
    val lexer = new Lexer(new StringReader(input))
    var t = lexer.yylex()
    while (t != null) {
      if (t == Lexer.Token.ILLEGAL) {
        println(s"Lexical error at line ${lexer.line()}, column ${lexer.column()}: illegal character '${lexer.yytext()}'")
      } else if (t == Lexer.Token.UNTERMINATED_COMMENT) {
        println(s"Lexical error at line ${lexer.commentStartLine()}, column ${lexer.commentStartColumn()}: unterminated multiline comment")
        return
      } else if (t == Lexer.Token.NUMBER) {
        println(s"$t(${lexer.numberValue()})")
      } else {
        println(s"$t")
      }
      t = lexer.yylex()
    }
  }

  def main(args: Array[String]): Unit = {
    scan("d: number attribute", "boil 4 cups water;")

    scan("e: reserved words vs identifiers", "cook cooking_time;\nserve server;")

    scan("f: valid program", """// Ugali preparation program

prepare ingredients;
boil 4 cups water;
add 2 cups flour;
stir;
add 1 cups flour;
stir;
press ugali;
turn ugali;
cook 8 minutes;
check consistency;
shape ugali;
serve ugali;
""")

    scan("g: illegal characters", """prepare ingredients;
boil 4 cups water;
add @2 cups flour;
cook 5# minutes;
""")

    scan("h: multiline comment", """/*
     Ugali should be stirred continuously.
     Add flour gradually.
*/
prepare ingredients;
boil 4 cups water;
""")

    scan("h: unterminated multiline comment", """prepare ingredients;
/*
     This comment never ends.
""")
  }
}
