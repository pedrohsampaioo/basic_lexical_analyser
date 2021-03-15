<p align="center">	
   <a href="https://www.linkedin.com/in/pedro-henrique-da-silva-sampaio-ba2b7716b/">
      <img alt="Pedro Henrique" src="https://img.shields.io/badge/-PedroHenrique-8257E5?style=flat&logo=Linkedin&logoColor=white" />
   </a>
  <a href="https://github.com/pedrohsampaioo/basic_lexical_analyser/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/pedrohsampaioo/covid_app?color=8257E5&logo=github">
  </a>
</p>

> :speech_balloon: It's a basic tokenization algorithm.

# :notebook_with_decorative_cover:  Basic Tokenization algorithm

# :movie_camera: Overview

Tokens that are identified: 

* **INTEGER**: any number between 0 and 9
* **MINUS**: -
* **PLUS**: +
* **MULTIPLE**: *
* **DIVIDE**: /

Example:

```dart
void main(List<String> args) {
  LexicalAnalyser('   15 + 1   +   5 \n  5  +   0 + 6').generateTokens().forEach(print);
}
```

Output:

```
Token(INTEGER,1)
Token(INTEGER,5)
Token(PLUS,+)
Token(INTEGER,1)
Token(PLUS,+)
Token(INTEGER,5)
Token(INTEGER,5)
Token(PLUS,+)
Token(INTEGER,0)
Token(PLUS,+)
Token(INTEGER,6)
```
In the tokenization process, always removes tabs (\ t), skips lines (\ n) and blanks.

<a href="https://nullsafety.dartpad.dev/85f835ad6ba38260da80d85725b531d9">link to run the code online </a>




# :construction_worker: Installation

```
$ git clone https://github.com/pedrohsampaioo/basic_lexical_analyser.git

$ cd lexical_analyser

```

# :runner: Getting Started

Run the following command in order to start the application:

```
 # Run main file
 $ dart run lexical/analyser/bin/lexical_analyser.dart
```
