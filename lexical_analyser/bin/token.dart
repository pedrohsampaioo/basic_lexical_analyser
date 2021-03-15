class Token<Type, Value> {
  final Type type;
  final Value value;

  const Token(this.type, this.value);

  @override
  String toString() {
    return 'Token($type,$value)';
  }
}