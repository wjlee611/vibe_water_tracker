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

  Future<int> getTodayIntake() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      return 0;
    }

    final data = userDoc.data();
    final today = _getTodayDateString();
    return data?['daily_intakes']?[today] ?? 0;
  }

  Future<void> updateIntake(int newTotalIntake, int changeAmount) async {
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
