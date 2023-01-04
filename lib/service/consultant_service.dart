import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodly/models/consultant_model.dart';

class ConsultantService {
  final CollectionReference _consultantReference =
      FirebaseFirestore.instance.collection('consultants');

  Future<void> addConsultant(ConsultantModel consultant) async {
    try {
      await _consultantReference.add(consultant.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateConsultant(ConsultantModel consultant) async {
    try {
      await _consultantReference.doc(consultant.id).update(consultant.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteArticle(ConsultantModel consultant) async {
    try {
      await _consultantReference.doc(consultant.id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
