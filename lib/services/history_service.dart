import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryEntry {
  final String line;      // nt "4 * 5 = 20"
  final String timestamp; // nt "2022-10-22 15:30"

  HistoryEntry({required this.line, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'line': line,
    'timestamp': timestamp,
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    line: json['line'] as String,
    timestamp: json['timestamp'] as String,
  );
}

class HistoryService {
  static const _key = 'calc_history';

  Future<List<HistoryEntry>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];

    final items = raw
        .map((s) => HistoryEntry.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();


    return items.reversed.toList();
  }

  Future<void> add(HistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    raw.add(jsonEncode(entry.toJson()));
    await prefs.setStringList(_key, raw);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
