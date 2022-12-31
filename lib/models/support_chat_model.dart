import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SupportChatModel extends Equatable {
  final Timestamp date;
  final String message;
  final String imageUrl;
  final bool isRead;

  const SupportChatModel({
    required this.date,
    this.message = '',
    this.imageUrl = '',
    this.isRead = false,
  });

  factory SupportChatModel.fromJson(Map<String, dynamic> json) {
    return SupportChatModel(
      date: json['date'],
      message: json['message'],
      imageUrl: json['imageUrl'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'message': message,
        'imageUrl': imageUrl,
        'isRead': isRead,
      };

  @override
  List<Object?> get props => [
        date,
        message,
        imageUrl,
        isRead,
      ];
}
