class Calculation {
  final String expression; // nt "5+6/2"
  final String result;     // nt "8"
  final DateTime timestamp;

  Calculation({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'expression': expression,
    'result': result,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
    expression: json['expression'],
    result: json['result'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
