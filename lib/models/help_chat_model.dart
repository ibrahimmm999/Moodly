import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HelpChatModel extends Equatable {
  final Timestamp date;
  final String message;
  final String imageUrl;
  final bool isRead;
  final bool isUser;
  final bool isCompleted;
  final bool isRecomendation;

  const HelpChatModel({
    required this.date,
    this.message = '',
    this.imageUrl = '',
    this.isRead = false,
    this.isUser = true,
    this.isCompleted = false,
    this.isRecomendation = false,
  });

  factory HelpChatModel.fromJson(Map<String, dynamic> json) {
    return HelpChatModel(
      date: json['date'],
      message: json['message'],
      imageUrl: json['imageUrl'],
      isRead: json['isRead'],
      isUser: json['isUser'],
      isCompleted: json['isCompleted'],
      isRecomendation: json['isRecomendation'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'message': message,
        'imageUrl': imageUrl,
        'isRead': isRead,
        'isUser': isUser,
        'isCompleted': isCompleted,
        'isRecomendation': isRecomendation,
      };

  @override
  List<Object?> get props => [
        date,
        message,
        imageUrl,
        isRead,
        isUser,
        isCompleted,
        isRecomendation,
      ];
}
