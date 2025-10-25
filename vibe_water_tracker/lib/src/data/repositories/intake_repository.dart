import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IntakeRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  IntakeRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<double> getTodayIntake() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      return 0.0;
    }

    final data = userDoc.data();
    final today = _getTodayDateString();
    return (data?['daily_intakes']?[today] ?? 0).toDouble();
  }

  Future<double> getWeeklyIntake() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
    double weeklyTotal = 0.0;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      return 0.0;
    }

    final data = userDoc.data();
    if (data != null && data['daily_intakes'] != null) {
      (data['daily_intakes'] as Map).forEach((dateString, intake) {
        final dateParts = dateString.split('-').map(int.parse).toList();
        final date = DateTime(dateParts[0], dateParts[1], dateParts[2]);
        if (date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            date.isBefore(now.add(const Duration(days: 1)))) {
          weeklyTotal += (intake ?? 0).toDouble();
        }
      });
    }
    return weeklyTotal;
  }

  Future<double> getMonthlyIntake() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    double monthlyTotal = 0.0;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      return 0.0;
    }

    final data = userDoc.data();
    if (data != null && data['daily_intakes'] != null) {
      (data['daily_intakes'] as Map).forEach((dateString, intake) {
        final dateParts = dateString.split('-').map(int.parse).toList();
        final date = DateTime(dateParts[0], dateParts[1], dateParts[2]);
        if (date.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
            date.isBefore(now.add(const Duration(days: 1)))) {
          monthlyTotal += (intake ?? 0).toDouble();
        }
      });
    }
    return monthlyTotal;
  }

  Future<double> getTotalIntake() async {
    final globalStatsDoc = await _firestore.collection('global_stats').doc('total_intake').get();
    if (!globalStatsDoc.exists) {
      return 0.0;
    }
    final data = globalStatsDoc.data();
    return (data?['totalAmount'] ?? 0).toDouble();
  }

  Future<void> updateIntake(double newTotalIntake, double changeAmount) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final today = _getTodayDateString();
    final userDocRef = _firestore.collection('users').doc(user.uid);
    final globalStatsRef = _firestore.collection('global_stats').doc('total_intake');

    await _firestore.runTransaction((transaction) async {
      // Update user's daily intake
      transaction.set(
        userDocRef,
        {
          'daily_intakes': {
            today: newTotalIntake,
          },
        },
        SetOptions(merge: true),
      );

      // Update global total intake
      transaction.set(
        globalStatsRef,
        {
          'totalAmount': FieldValue.increment(changeAmount),
        },
        SetOptions(merge: true),
      );
    });
  }
}