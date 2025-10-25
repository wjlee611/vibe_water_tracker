import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatsRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  StatsRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Future<Map<String, int>> getPersonalStats() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      return {'week': 0, 'month': 0};
    }

    final dailyIntakes = userDoc.data()?['daily_intakes'] as Map<String, dynamic>? ?? {};
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonth = DateTime(now.year, now.month, 1);

    int weeklyIntake = 0;
    int monthlyIntake = 0;

    dailyIntakes.forEach((dateStr, intake) {
      final date = DateTime.parse(dateStr);
      if (date.isAfter(startOfWeek.subtract(const Duration(days: 1)))) {
        weeklyIntake += (intake as num).toInt();
      }
      if (date.isAfter(startOfMonth.subtract(const Duration(days: 1)))) {
        monthlyIntake += (intake as num).toInt();
      }
    });

    return {'week': weeklyIntake, 'month': monthlyIntake};
  }

  Future<int> getTotalIntake() async {
    final doc = await _firestore.collection('global_stats').doc('total_intake').get();
    if (!doc.exists) {
      return 0;
    }
    return (doc.data()?['totalAmount'] as num?)?.toInt() ?? 0;
  }
}
