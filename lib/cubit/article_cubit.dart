import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moodly/model/article_model.dart';
import 'package:moodly/service/article_service.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());

  void fetchArticle() async {
    try {
      emit(ArticleLoading());
      List<ArticleModel> article = await ArticleService().fetchArticles();
      emit(ArticleSuccess(article));
    } catch (e) {
      emit(ArticleFailed(e.toString()));
    }
  }
}
