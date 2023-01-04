import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class QuestionService {
  Future<void> saveQuestion(List<TextEditingController> listController) async {
    final CollectionReference<Map<String, dynamic>> questionReference =
        FirebaseFirestore.instance.collection('tracking');

    try {
      List<String> listQuestion = [];
      for (var element in listController) {
        listQuestion.add(element.text);
      }

      await questionReference
          .doc('questions')
          .update({'listQuestion': listQuestion});
    } catch (e) {
      rethrow;
    }
  }
}
