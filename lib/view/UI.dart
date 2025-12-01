// lib/views/calculator_page.dart

import 'package:flutter/material.dart';
import '../controllers/calculator_controller.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _calculatorController = CalculatorController();

  String _selectedOperator = '+';
  String _resultText = '';

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _onCalculatePressed() {
    try {
      final result = _calculatorController.calculate(
        firstText: _firstController.text,
        secondText: _secondController.text,
        operatorSymbol: _selectedOperator,
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
    // View = UI only. No math logic here.
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVC Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstController,
              decoration: const InputDecoration(labelText: 'First number'),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
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
                setState(() {
                  _selectedOperator = value;
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _secondController,
              decoration: const InputDecoration(labelText: 'Second number'),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
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
