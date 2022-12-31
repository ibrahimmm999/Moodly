import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HelpChatModel extends Equatable {
  final Timestamp date;
  final String message;
  final String imageUrl;
  final bool isRead;
  final bool isCompleted;

  const HelpChatModel({
    required this.date,
    this.message = '',
    this.imageUrl = '',
    this.isRead = false,
    this.isCompleted = false,
  });

  factory HelpChatModel.fromJson(Map<String, dynamic> json) {
    return HelpChatModel(
      date: json['date'],
      message: json['message'],
      imageUrl: json['imageUrl'],
      isRead: json['isRead'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'message': message,
        'imageUrl': imageUrl,
        'isRead': isRead,
        'isCompleted': isCompleted,
      };

  @override
  List<Object?> get props => [
        date,
        message,
        imageUrl,
        isRead,
        isCompleted,
      ];
}
