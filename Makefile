Main.class: Main.scala Lexer.class
	scalac -classpath . Main.scala

Lexer.java: Lexer.flex
	jflex Lexer.flex

Lexer.class: Lexer.java
	javac Lexer.java

run: Main.class
	scala -classpath . Main
