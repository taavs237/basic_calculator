import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryEntry {
  final String line;      // nt "4 * 5 = 20"
  final String timestamp; // ISO string

  HistoryEntry({
    required this.line,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'line': line,
    'timestamp': timestamp,
    'createdAt': FieldValue.serverTimestamp(),
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    line: json['line'] as String,
    timestamp: json['timestamp'] as String,
  );
}

class HistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('User not authenticated');
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('users').doc(_uid).collection('history');


  Stream<List<HistoryEntry>> watchAll() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        return HistoryEntry.fromJson(data);
      }).toList(),
    );
  }


  Future<void> add(HistoryEntry entry) async {
    await _collection.add(entry.toJson());
  }


  Future<void> clear() async {
    final snapshot = await _collection.get();
    final batch = _db.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
