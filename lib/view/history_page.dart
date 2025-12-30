import 'package:flutter/material.dart';
import '../services/history_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _historyService = HistoryService();

  Future<List<HistoryEntry>> _load() => _historyService.getAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            tooltip: 'Clear history',
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await _historyService.clear();
              if (!mounted) return;
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<HistoryEntry>>(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No history yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final e = items[i];
              return ListTile(
                title: Text(e.line),
                subtitle: Text(e.timestamp),
              );
            },
          );
        },
      ),
    );
  }
}
