// lib/models/calculation.dart

class Calculation {
  final double firstOperand;
  final double secondOperand;
  final String operatorSymbol; // '+', '-', '*', '/'

  Calculation({
    required this.firstOperand,
    required this.secondOperand,
    required this.operatorSymbol,
  });

  double compute() {
    switch (operatorSymbol) {
      case '+':
        return firstOperand + secondOperand;
      case '-':
        return firstOperand - secondOperand;
      case '*':
        return firstOperand * secondOperand;
      case '/':
        if (secondOperand == 0) {
          throw ArgumentError('Nulliga jagamine ei ole lubatud.');
        }
        return firstOperand / secondOperand;
      default:
        throw ArgumentError('Toetamata operaator: $operatorSymbol');
    }
  }
}
