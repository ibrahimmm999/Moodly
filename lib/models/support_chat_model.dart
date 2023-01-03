import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SupportChatModel extends Equatable {
  final Timestamp date;
  final String message;
  final String imageUrl;
  final bool isRead;
  final bool isUser;

  const SupportChatModel({
    required this.date,
    this.message = '',
    this.imageUrl = '',
    this.isRead = false,
    this.isUser = true,
  });

  factory SupportChatModel.fromJson(Map<String, dynamic> json) {
    return SupportChatModel(
      date: json['date'],
      message: json['message'],
      imageUrl: json['imageUrl'],
      isRead: json['isRead'],
      isUser: json['isUser'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'message': message,
        'imageUrl': imageUrl,
        'isRead': isRead,
        'isUser': isUser,
      };

  @override
  List<Object?> get props => [
        date,
        message,
        imageUrl,
        isRead,
        isUser,
      ];
}
