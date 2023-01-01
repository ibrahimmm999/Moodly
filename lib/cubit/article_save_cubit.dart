import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moodly/models/article_model.dart';
import 'package:moodly/service/article_service.dart';
import 'package:moodly/service/image_service.dart';

part 'article_save_state.dart';

class ArticleSaveCubit extends Cubit<ArticleSaveState> {
  ArticleSaveCubit() : super(ArticleSaveInitial());

  void save({required File? image, required ArticleModel article}) async {
    emit(ArticleSaveLoading());
    ImageTool imageTool = ImageTool();
    ArticleService articleService = ArticleService();

    String newThumbnail = article.thumbnail;

    if ((image == null && newThumbnail.isEmpty) ||
        article.title.isEmpty ||
        article.content.isEmpty ||
        article.author.isEmpty) {
      emit(const ArticleSaveFailed('Form is Required'));
    } else {
      try {
        if (image != null) {
          if (newThumbnail.isNotEmpty) {
            await imageTool.deleteImage(newThumbnail);
          }
          await imageTool.uploadImage(image, 'article');
          newThumbnail = imageTool.imageUrl!;
        }

        if (article.id.isEmpty) {
          await articleService.addArticle(
            ArticleModel(
              id: article.id,
              title: article.title,
              content: article.content,
              author: article.author,
              thumbnail: newThumbnail,
              date: Timestamp.now(),
            ),
          );
        } else {
          await articleService.updateArticle(
            ArticleModel(
              id: article.id,
              title: article.title,
              content: article.content,
              author: article.author,
              thumbnail: newThumbnail,
              date: Timestamp.now(),
            ),
          );
        }
        emit(ArticleSaveSuccess());
      } catch (e) {
        emit(ArticleSaveFailed(e.toString()));
      }
    }
  }
}
