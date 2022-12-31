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
    this.title = '',
    this.content = '',
    this.author = '',
    this.thumbnail = '',
    required this.date,
  });

  factory ArticleModel.fromJson(String id, Map<String, dynamic> json) =>
      ArticleModel(
        id: id,
        title: json['title'],
        content: json['content'],
        thumbnail: json['thumbnail'],
        author: json['thumbnail'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
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
