import 'package:math_expressions/math_expressions.dart';

class ExpressionEvaluator {
  static String evaluate(String input) {
    final normalized = input
        .replaceAll(' ', '')
        .replaceAll('×', '*')
        .replaceAll('÷', '/');

    final parser = Parser();
    final expr = parser.parse(normalized);
    final ctx = ContextModel();

    final value = expr.evaluate(EvaluationType.REAL, ctx);

    if (value.isNaN || value.isInfinite) {
      throw Exception('Invalid result');
    }


    final asInt = value.toInt();
    if (value == asInt.toDouble()) return asInt.toString();


    return value.toStringAsFixed(10).replaceFirst(RegExp(r'\.?0+$'), '');
  }
}
