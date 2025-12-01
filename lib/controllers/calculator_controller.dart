// lib/controllers/calculator_controller.dart

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

    return calculation.compute();
  }
}
