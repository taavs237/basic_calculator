import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final _kmController = TextEditingController();
  String _milesText = '';

  @override
  void dispose() {
    _kmController.dispose();
    super.dispose();
  }

  void _convert() {
    try {
      final km = double.parse(_kmController.text);
      final miles = km * 0.621371;
      setState(() {
        _milesText = miles.toStringAsFixed(4);
      });
    } on FormatException {
      setState(() => _milesText = 'Invalid input');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Km → Miles')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _kmController,
              decoration: const InputDecoration(labelText: 'Kilometers'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            Text('Miles: $_milesText', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
