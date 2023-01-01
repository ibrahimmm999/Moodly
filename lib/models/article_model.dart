import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  final String id;
  final String thumbnail;
  final String title;
  final String content;
  final String author;
  final Timestamp date;
  const ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.thumbnail,
    required this.date,
  });

  // get
  factory ArticleModel.fromJson(String id, Map<String, dynamic> json) =>
      ArticleModel(
        id: id,
        title: json['title'],
        content: json['content'],
        thumbnail: json['thumbnail'],
        author: json['author'],
        date: json['date'],
      );

  // post
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'thumbnail': thumbnail,
        'author': author,
        'date': date,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        thumbnail,
        author,
        date,
      ];
}
