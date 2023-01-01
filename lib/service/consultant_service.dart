import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodly/models/consultant_model.dart';

class ConsultantService {
  final CollectionReference _articlesReference =
      FirebaseFirestore.instance.collection('consultants');

  Future<void> addConsultant(ConsultantModel consultant) async {
    try {
      await _articlesReference.add(consultant.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateConsultant(ConsultantModel consultant) async {
    try {
      await _articlesReference.doc(consultant.id).update(consultant.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
