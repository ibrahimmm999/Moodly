import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mood_data.dart';

class TrackingService {
  final CollectionReference<Map<String, dynamic>> _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateScore(String id, MoodDataModel mood) async {
    try {
      await _userReference.doc(id).update({
        'moodDataList': FieldValue.arrayUnion([mood.toJson()])
      });
    } catch (e) {
      rethrow;
    }
  }
}
