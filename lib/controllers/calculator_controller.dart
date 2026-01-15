import '../services/expression_evaluator.dart';
import '../models/calculation.dart';

class CalculatorController {
  String _expression = '';

  String get expression => _expression;

  void clear() {
    _expression = '';
  }


  double calculate({
    required String firstText,
    required String secondText,
    required String operatorSymbol,
  }) {
    final first = double.parse(firstText);
    final second = double.parse(secondText);

    switch (operatorSymbol) {
      case '+':
        return first + second;
      case '-':
        return first - second;
      case '*':
      case '×':
        return first * second;
      case '/':
      case '÷':
        if (second == 0) {
          throw ArgumentError('Nulliga jagamine ei ole lubatud.');
        }
        return first / second;
      default:
        throw ArgumentError('Toetamata operaator: $operatorSymbol');
    }
  }


  void append(String value) {
    if (_expression.isEmpty) {
      if (_isOperator(value) && value != '-') return;
      _expression = value;
      return;
    }

    final last = _expression.substring(_expression.length - 1);

    if (_isOperator(last) && _isOperator(value)) {
      _expression = _expression.substring(0, _expression.length - 1) + value;
      return;
    }

    _expression += value;
  }


  Calculation evaluate() {
    final result = ExpressionEvaluator.evaluate(_expression);

    return Calculation(
      expression: _expression,
      result: result,
      timestamp: DateTime.now(),
    );
  }

  bool _isOperator(String s) => s == '+' || s == '-' || s == '*' || s == '/' || s == '×' || s == '÷';
}
