import '../models/calculation.dart';

class CalculatorController {
  double calculate({
    required String firstText,
    required String secondText,
    required String operatorSymbol,
  }) {
    final double first = double.parse(firstText);
    final double second = double.parse(secondText);

    final calculation = Calculation(
      firstOperand: first,
      secondOperand: second,
      operatorSymbol: operatorSymbol,
    );

    return _compute(calculation);
  }

  double _compute(Calculation c) {
    switch (c.operatorSymbol) {
      case '+':
        return c.firstOperand + c.secondOperand;
      case '-':
        return c.firstOperand - c.secondOperand;
      case '*':
        return c.firstOperand * c.secondOperand;
      case '/':
        if (c.secondOperand == 0) {
          throw ArgumentError('Nulliga jagamine ei ole lubatud.');
        }
        return c.firstOperand / c.secondOperand;
      default:
        throw ArgumentError('Toetamata operaator: ${c.operatorSymbol}');
    }
  }
}
