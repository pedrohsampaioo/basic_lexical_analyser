import 'token.dart';

class LexicalAnalyser {
  final String input;

  const LexicalAnalyser(this.input);

  List<Token<String, String>> generateTokens() {
    final tabString = '\u{0009}';
    final newLineString = '\n';
    final spaceString = ' ';
    final caracters = input
        .replaceAll(tabString, '')
        .replaceAll(newLineString, '')
        .replaceAll(spaceString, '')
        .trim()
        .split('');
    final tokens = caracters.map<Token<String, String>>(_handleChar).toList();
    return tokens;
  }

  int calc() {
    final tokens = generateTokens();
    if (tokens.isEmpty) {
      throw Exception('Syntax error - no have tokens');
    }

    while (tokens.any(_tokenIsNotInteger)) {
      final indexOfOperationDivOrMult =
          tokens.indexWhere(_tokenIsDivideOrMultiple);
      if (indexOfOperationDivOrMult != -1) {
        _performArithmeticOperation(tokens, indexOfOperationDivOrMult);
      }

      final indexOfOperationPlusOrMinus =
          tokens.indexWhere(_tokenIsPlusOrMinus);
      if (indexOfOperationPlusOrMinus != -1) {
        _performArithmeticOperation(tokens, indexOfOperationPlusOrMinus);
      }
    }
    int sum = int.parse(tokens[0].value);

    return sum;
  }

  bool _tokenIsInteger(Token<String, String> token) => token.type == 'INTEGER';
  bool _tokenIsNotInteger(Token<String, String> token) =>
      token.type != 'INTEGER';

  bool _tokenIsDivideOrMultiple(Token<String, String> token) =>
      token.type == 'DIVIDE' || token.type == 'MULTIPLE';
  bool _tokenIsPlusOrMinus(Token<String, String> token) =>
      token.type == 'PLUS' || token.type == 'MINUS';

  void _performArithmeticOperation(
    List<Token<String, String>> tokenListRef,
    int indexOfOperation,
  ) {
    final leftIndex = indexOfOperation - 1;
    final rightIndex = indexOfOperation + 1;
    if (leftIndex < 0 ||
        rightIndex >= tokenListRef.length ||
        _tokenIsNotInteger(tokenListRef[leftIndex]) ||
        _tokenIsNotInteger(tokenListRef[rightIndex])) {
      throw Exception(
          'Syntax error - invalid order to apply arithmetic operations ');
    }

    final operation = tokenListRef.removeAt(indexOfOperation).type;
    int indexToIterableLeft = leftIndex;
    String newNumberLeft = '';

    while (_tokenIsInteger(tokenListRef[indexToIterableLeft])) {
      newNumberLeft =
          '${tokenListRef[indexToIterableLeft].value}$newNumberLeft';
      tokenListRef.removeAt(indexToIterableLeft);
      indexToIterableLeft--;
      if (indexToIterableLeft < 0 || tokenListRef.isEmpty) {
        break;
      }
    }

    int indexToIterableRight = indexToIterableLeft + 1;
    String newNumberRight = '';
    while (_tokenIsInteger(tokenListRef[indexToIterableRight])) {
      newNumberRight =
          '$newNumberRight${tokenListRef[indexToIterableRight].value}';
      tokenListRef.removeAt(indexToIterableRight);
      if (indexToIterableRight > tokenListRef.length || tokenListRef.isEmpty) {
        break;
      }
    }

    if (operation == 'PLUS') {
      final numberToInsert =
          int.parse(newNumberLeft) + int.parse(newNumberRight);

      tokenListRef.insert(
        indexToIterableLeft + 1,
        Token<String, String>(
          'INTEGER',
          numberToInsert.toString(),
        ),
      );
    } else if (operation == 'MINUS') {
      final numberToInsert =
          int.parse(newNumberLeft) - int.parse(newNumberRight);
      tokenListRef.insert(
        indexToIterableLeft + 1,
        Token<String, String>(
          'INTEGER',
          numberToInsert.toString(),
        ),
      );
    } else if (operation == 'MULTIPLE') {
      final numberToInsert =
          int.parse(newNumberLeft) * int.parse(newNumberRight);
      tokenListRef.insert(
        indexToIterableLeft + 1,
        Token<String, String>(
          'INTEGER',
          numberToInsert.toString(),
        ),
      );
    } else if (operation == 'DIVIDE') {
      final numberToInsert =
          int.parse(newNumberLeft) / int.parse(newNumberRight);
      tokenListRef.insert(
        indexToIterableLeft + 1,
        Token<String, String>(
          'INTEGER',
          numberToInsert.toString(),
        ),
      );
    }
  }

  Token<String, String> _handleChar(String char) {
    final isNumber = int.tryParse(char) != null;
    if (isNumber) {
      return _parseToToken('INTEGER', char);
    }
    final isPlus = char == '+';
    if (isPlus) {
      return _parseToToken('PLUS', char);
    }
    final isMinus = char == '-';
    if (isMinus) {
      return _parseToToken('MINUS', char);
    }
    final isMultiple = char == '*';
    if (isMultiple) {
      return _parseToToken('MULTIPLE', char);
    }

    final isDivide = char == '/';
    if (isDivide) {
      return _parseToToken('DIVIDE', char);
    }

    throw Exception('Syntax error - some token is invalid ');
  }

  Token<String, String> _parseToToken(String type, String value) {
    final factoryToken = _mappedTokens[type];
    if (factoryToken != null) {
      return factoryToken(type, value);
    }
    throw Exception('Syntax error - some token is invalid');
  }

  Map<String, Token<String, String> Function(String type, String value)>
      get _mappedTokens => {
            'INTEGER': (String type, String value) =>
                Token<String, String>(type, value),
            'MINUS': (String type, String value) =>
                Token<String, String>(type, value),
            'DIVIDE': (String type, String value) =>
                Token<String, String>(type, value),
            'MULTIPLE': (String type, String value) =>
                Token<String, String>(type, value),
            'PLUS': (String type, String value) =>
                Token<String, String>(type, value),
          };
}
