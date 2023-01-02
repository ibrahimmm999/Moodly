import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodly/models/article_model.dart';

class ArticleService {
  final CollectionReference _articlesReference =
      FirebaseFirestore.instance.collection('articles');

  Future<void> addArticle(ArticleModel article) async {
    try {
      await _articlesReference.add(article.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateArticle(ArticleModel article) async {
    try {
      await _articlesReference.doc(article.id).update(article.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteArticle(ArticleModel article) async {
    try {
      await _articlesReference.doc(article.id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
