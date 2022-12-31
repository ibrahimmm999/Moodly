part of 'article_cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final List<ArticleModel> articles;

  const ArticleSuccess(this.articles);
  @override
  List<Object> get props => [articles];
}

class ArticleFailed extends ArticleState {
  final String error;
  const ArticleFailed(this.error);
  @override
  List<Object> get props => [error];
}
