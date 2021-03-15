import 'lexical_analyser.dart';

void main(List<String> args) {
  print(LexicalAnalyser('   15 + 1   +   5 \n  5  +   0 + 6').generateTokens());
}