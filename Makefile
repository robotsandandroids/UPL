SCALA  ?= scala
SCALAC ?= scalac

.PHONY: all run test clean

all: Main.class

Main.class: Main.scala Lexer.class
	$(SCALAC) -classpath . Main.scala

Tests.class: Tests.scala Lexer.class
	$(SCALAC) -classpath . Tests.scala

Lexer.java: Lexer.flex
	jflex Lexer.flex

Lexer.class: Lexer.java
	javac Lexer.java

run: Main.class
	$(SCALA) -classpath . Main

test: Main.class Tests.class
	$(SCALA) -classpath . Tests

clean:
	rm -f *.class *.tasty Lexer.java Lexer.java~ Tests.java
