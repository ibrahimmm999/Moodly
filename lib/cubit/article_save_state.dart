part of 'article_save_cubit.dart';

abstract class ArticleSaveState extends Equatable {
  const ArticleSaveState();

  @override
  List<Object> get props => [];
}

class ArticleSaveInitial extends ArticleSaveState {}

class ArticleSaveLoading extends ArticleSaveState {}

class ArticleSaveSuccess extends ArticleSaveState {}

class ArticleSaveFailed extends ArticleSaveState {
  const ArticleSaveFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
