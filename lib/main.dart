import 'package:flutter/material.dart';
import 'controllers/calculator_controller.dart'; // <-- lisa see

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kalkulaatori esimene versioon'),
    );
  }
}

// SEE ON SINU VIEW (UI)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // UI state
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
        _resultText = 'Vigane sisend (pole number)';
      });
    } on ArgumentError catch (e) {
      setState(() {
        _resultText = e.message.toString();
      });
    } catch (_) {
      setState(() {
        _resultText = 'Tundmatu viga';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // View: ainult UI, mitte arvutusloogikat
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstController,
              decoration: const InputDecoration(labelText: 'Esimene arv'),
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
              decoration: const InputDecoration(labelText: 'Teine arv'),
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
              'Tulemus: $_resultText',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
