import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodly/model/article_model.dart';

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
      return ArticleModel(
          id: id,
          title: snapshot['title'],
          content: snapshot['content'],
          date: snapshot['date']);
    } catch (e) {
      rethrow;
    }
  }
}
