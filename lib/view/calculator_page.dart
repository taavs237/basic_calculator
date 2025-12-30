import 'package:flutter/material.dart';
import '../controllers/calculator_controller.dart';
import '../services/history_service.dart';
import 'converter_page.dart';
import 'history_page.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _calculatorController = CalculatorController();
  final _historyService = HistoryService();

  String _selectedOperator = '+';
  String _resultText = '';

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  String _nowTimestamp() {
    final dt = DateTime.now();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }

  Future<void> _onCalculatePressed() async {
    try {
      final result = _calculatorController.calculate(
        firstText: _firstController.text,
        secondText: _secondController.text,
        operatorSymbol: _selectedOperator,
      );

      final line =
          '${_firstController.text} $_selectedOperator ${_secondController.text} = $result';

      await _historyService.add(
        HistoryEntry(line: line, timestamp: _nowTimestamp()),
      );

      setState(() {
        _resultText = result.toString();
      });
    } on FormatException {
      setState(() {
        _resultText = 'Invalid number input';
      });
    } on ArgumentError catch (e) {
      setState(() {
        _resultText = e.message.toString();
      });
    } catch (_) {
      setState(() {
        _resultText = 'Unknown error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVC Calculator'),
        actions: [
          IconButton(
            tooltip: 'Converter',
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ConverterPage()),
              );
            },
          ),
          IconButton(
            tooltip: 'History',
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const HistoryPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstController,
              decoration: const InputDecoration(labelText: 'First number'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedOperator,
              items: const [
                DropdownMenuItem(value: '+', child: Text('+')),
                DropdownMenuItem(value: '-', child: Text('-')),
                DropdownMenuItem(value: '*', child: Text('*')),
                DropdownMenuItem(value: '/', child: Text('/')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => _selectedOperator = value);
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _secondController,
              decoration: const InputDecoration(labelText: 'Second number'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onCalculatePressed,
              child: const Text('='),
            ),
            const SizedBox(height: 16),
            Text(
              'Result: $_resultText',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
