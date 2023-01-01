import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodly/models/article_model.dart';

class ArticleService {
  final CollectionReference _articlesReference =
      FirebaseFirestore.instance.collection('articles');
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      QuerySnapshot result = await _articlesReference.get();
      List<ArticleModel> articles = result.docs.map((e) {
        return ArticleModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<ArticleModel> getArticleById(String id) async {
    try {
      DocumentSnapshot snapshot = await _articlesReference.doc(id).get();
      return ArticleModel.fromJson(id, snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

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
}
